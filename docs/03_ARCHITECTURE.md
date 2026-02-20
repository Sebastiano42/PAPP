# SPAPP — Architecture
## Documento: Architettura del Sistema

**Data:** 2026-02-20
**Stato:** Draft

---

## Panoramica Architettura

```
┌──────────────────────────────────────────────────────────────────┐
│                        CLIENT LAYER                              │
│                                                                  │
│   ┌─────────────────┐          ┌─────────────────┐              │
│   │   iOS App        │          │  Android App    │              │
│   │  (Flutter)       │          │   (Flutter)     │              │
│   └────────┬─────────┘          └────────┬────────┘              │
│            │                             │                        │
│            └──────────┬──────────────────┘                        │
│                       │ (stesso codebase Dart)                    │
└───────────────────────┼──────────────────────────────────────────┘
                        │
                        │ HTTPS / WebSocket
                        │
┌───────────────────────┼──────────────────────────────────────────┐
│                   SUPABASE BACKEND                               │
│                       │                                          │
│   ┌───────────────────▼──────────────────────────────────────┐  │
│   │                  API Gateway (PostgREST)                  │  │
│   └──────┬──────────────┬────────────────┬────────────────┬───┘  │
│          │              │                │                │       │
│   ┌──────▼────┐  ┌──────▼────┐  ┌───────▼────┐  ┌───────▼───┐  │
│   │ PostgreSQL│  │   Auth    │  │  Storage   │  │ Realtime  │  │
│   │ (database)│  │ (utenti)  │  │ (media)    │  │(WebSocket)│  │
│   └───────────┘  └───────────┘  └────────────┘  └───────────┘  │
│                                                                  │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │              Edge Functions (Deno)                       │   │
│   │   - Logica business complessa                            │   │
│   │   - Invio notifiche push (FCM/APNs)                     │   │
│   │   - Cancellazioni automatiche                            │   │
│   └─────────────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────────┘
```

---

## Architettura App Flutter

L'app segue il pattern **Feature-First** con architettura **Clean Architecture** semplificata.

### Struttura Cartelle

```
lib/
├── main.dart
├── app/
│   ├── app.dart                    # Widget root, router setup
│   ├── router.dart                 # GoRouter configuration
│   └── theme/
│       ├── app_theme.dart          # Tema globale
│       ├── colors.dart             # Palette colori
│       └── typography.dart         # Font e stili testo
│
├── core/
│   ├── supabase/
│   │   └── supabase_client.dart    # Inizializzazione Supabase
│   ├── constants/
│   ├── utils/
│   └── widgets/                    # Widget condivisi (bottoni, card, ecc.)
│
└── features/
    ├── auth/
    │   ├── data/                   # Repository, datasource
    │   ├── domain/                 # Models, entities
    │   ├── presentation/           # Screens, widgets, providers
    │   └── auth_providers.dart
    │
    ├── profile/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    ├── sessions/                   # Prenotazione sessioni
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    ├── program/                    # Programmazione allenamento
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    └── exercises/                  # Libreria esercizi + animazioni
        ├── data/
        ├── domain/
        └── presentation/
```

### Pattern Layer (per ogni feature)

```
Presentation Layer  →  Provider (Riverpod)  →  Repository
     (UI)                (business logic)      (data access)
                                                     │
                                              Supabase Client
```

---

## Flusso Dati — Prenotazione Sessione

```
[User tappa "Prenota"]
        │
        ▼
[SessionsProvider.bookSession(sessionId)]
        │
        ▼
[SessionRepository.bookSession()]
        │
        ├── Supabase: INSERT INTO bookings
        │
        ├── Supabase Realtime: aggiorna posti disponibili
        │   └── tutti i client connessi ricevono update
        │
        └── Edge Function: invia push notification conferma
```

---

## Flusso Autenticazione

```
[App avvio]
    │
    ▼
[Supabase.auth.currentSession]
    │
    ├── Session valida → Home Screen
    │
    └── No session → Login Screen
            │
            ▼
        [Login/Register]
            │
            ▼
        [Supabase Auth]
            │
            ├── OK → JWT token salvato automaticamente
            │         └── Home Screen
            │
            └── Error → Mostra errore
```

---

## Sicurezza — Row Level Security (RLS)

Ogni tabella Supabase ha policy RLS per garantire che ogni utente acceda solo ai propri dati:

```sql
-- Esempio: ogni utente vede solo le proprie prenotazioni
CREATE POLICY "Users see own bookings"
ON bookings FOR SELECT
USING (auth.uid() = user_id);

-- Coach/Admin possono vedere tutte le prenotazioni
CREATE POLICY "Admin sees all bookings"
ON bookings FOR SELECT
USING (auth.jwt() ->> 'role' = 'admin');
```

---

## Ruoli Utente

| Ruolo | Permessi |
|-------|---------|
| `user` | Vede sessioni, prenota, vede proprio profilo e programma |
| `coach` | Come user + gestisce sessioni, vede prenotazioni |
| `admin` | Accesso completo — gestione utenti, sessioni, esercizi |

Il ruolo è salvato nel JWT di Supabase Auth come custom claim.

---

## Notifiche Push

```
[Event trigger]  →  [Supabase Edge Function]  →  [FCM / APNs]  →  [Device]
   (booking)           (Deno runtime)              (Google/Apple)
```

- **Android:** Firebase Cloud Messaging (FCM)
- **iOS:** Apple Push Notification service (APNs)
- Gestiti tramite Supabase Edge Functions che chiamano le API di FCM/APNs

---

## Offline & Cache

| Dato | Strategia |
|------|-----------|
| Lista sessioni | Cache 5 minuti, refresh on-demand |
| Programma allenamento | Cache locale, sincronizzazione all'avvio |
| Libreria esercizi | Cache aggressiva (dati quasi statici) |
| Prenotazioni | Always online — no prenotazioni offline |
| Animazioni Rive | Bundle nell'app (offline disponibili) |
