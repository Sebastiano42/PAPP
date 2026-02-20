# SPAPP — Tech Stack
## Documento: Scelte Tecnologiche

**Data:** 2026-02-20
**Stato:** Approvato (planning phase)

---

## Panoramica Stack

```
┌─────────────────────────────────────────────────────┐
│                   MOBILE APP                         │
│              Flutter + Dart                          │
│    (iOS & Android — unico codebase)                  │
├─────────────────────────────────────────────────────┤
│               STATE MANAGEMENT                       │
│                  Riverpod                            │
├─────────────────────────────────────────────────────┤
│                   BACKEND                            │
│                  Supabase                            │
│     (Auth · Database · Storage · Realtime)           │
├─────────────────────────────────────────────────────┤
│              ANIMAZIONI ESERCIZI                     │
│                    Rive                              │
│         (animazioni vettoriali interattive)          │
└─────────────────────────────────────────────────────┘
```

---

## 1. Frontend — Flutter

### Perché Flutter?

| Criterio | Flutter | React Native | Nativo (Swift/Kotlin) |
|----------|---------|-------------|----------------------|
| Unico codebase iOS+Android | ✅ | ✅ | ❌ |
| Performance animazioni | ✅ Eccellente | ⚠️ Buona | ✅ Eccellente |
| Design customizzabile | ✅ Totale | ⚠️ Parziale | ✅ Totale |
| Velocità sviluppo | ✅ Alta | ✅ Alta | ❌ Bassa |
| Community & ecosystem | ✅ Maturo | ✅ Maturo | ✅ Maturo |
| Adatto a design premium | ✅ Ottimo | ⚠️ Buono | ✅ Ottimo |

Flutter è il vincitore chiaro per un'app fitness che richiede:
- Animazioni degli esercizi fluide e complesse
- UI altamente personalizzata (non standard Material/Cupertino)
- Performance costante su entrambe le piattaforme

### Versione
- Flutter: **3.x (stable channel)**
- Dart: **3.x**

### Librerie Flutter principali

| Libreria | Scopo |
|----------|-------|
| `riverpod` | State management (reattivo, testabile) |
| `go_router` | Navigazione dichiarativa |
| `rive` | Animazioni esercizi interattive |
| `flutter_animate` | Animazioni UI (entrate, transizioni) |
| `supabase_flutter` | Client Supabase ufficiale |
| `cached_network_image` | Cache immagini remote |
| `intl` | Internazionalizzazione e date |
| `flutter_local_notifications` | Notifiche push locali |
| `table_calendar` | Calendario prenotazioni |
| `fl_chart` | Grafici statistiche allenamento |
| `shimmer` | Loading skeleton UI |
| `lottie` | Animazioni JSON (alternativa/complemento a Rive) |

---

## 2. Backend — Supabase

### Perché Supabase?

- **Database PostgreSQL** — relazionale, perfetto per prenotazioni e profili complessi
- **Auth integrata** — email/password, social login (Google, Apple), magic link
- **Row Level Security (RLS)** — ogni utente vede solo i propri dati
- **Storage** — per video esercizi, foto profilo, immagini sessioni
- **Realtime** — posti disponibili aggiornati in tempo reale senza polling
- **Open source** — no vendor lock-in totale, self-hostable
- **Free tier generoso** — ottimo per sviluppo e early stage

### Servizi Supabase utilizzati

| Servizio | Utilizzo |
|----------|---------|
| **Auth** | Registrazione, login, sessioni, OAuth |
| **PostgreSQL** | Tutti i dati (utenti, sessioni, prenotazioni, esercizi) |
| **Storage** | Video esercizi, immagini profilo, thumbnail sessioni |
| **Realtime** | Disponibilità posti in live durante la prenotazione |
| **Edge Functions** | Logica business complessa (reminder, cancellazioni automatiche) |

---

## 3. Animazioni Esercizi — Rive

### Perché Rive?

- Animazioni vettoriali **leggere** (pochi KB vs MB di video)
- **Interattive** — possono rispondere a input utente
- Integrazione nativa con Flutter tramite pacchetto ufficiale `rive`
- Le animazioni possono avere **stati** (idle → esecuzione → pausa)
- Designer possono lavorare su Rive.app separatamente dagli sviluppatori

### Alternativa: Lottie
- Per animazioni più semplici o decorative
- JSON-based, molte animazioni gratuite su LottieFiles.com

### Strategia animazioni esercizi
1. **Rive** per esercizi principali (corpo umano stilizzato in movimento)
2. **Video brevi** (mp4 ottimizzati) come fallback o per dettaglio avanzato
3. **Immagini sequenziali** per esercizi semplici

---

## 4. State Management — Riverpod

### Perché Riverpod?

- Versione moderna e migliorata di Provider (il pattern più diffuso Flutter)
- **Type-safe** e compile-time checked
- Ottimo per dati asincroni (fetch da Supabase)
- Testabile senza dipendenze dal BuildContext
- Supporto per `AsyncNotifier`, `StreamNotifier` — perfetto con Supabase Realtime

---

## 5. Navigazione — GoRouter

- Navigazione dichiarativa e URL-based
- Deep linking support (es. link diretto a una sessione)
- Gestione route protette (auth guard)

---

## 6. Design & Prototipazione

| Tool | Utilizzo |
|------|---------|
| **Figma** | UI design, prototipi interattivi, design system |
| **Rive.app** | Creazione animazioni esercizi |

---

## 7. Sviluppo & DevOps

| Tool | Utilizzo |
|------|---------|
| **Git + GitHub/GitLab** | Version control |
| **GitHub Actions** | CI/CD pipeline |
| **Fastlane** | Build automation e deploy su store |
| **Flutter Test** | Unit e widget test |
| **Supabase CLI** | Gestione migrazioni database |

---

## Decisioni Architetturali Chiave

1. **Nessun backend custom** — Supabase copre tutto il necessario nella fase 1
2. **Offline-first parziale** — Cache locale per programmazione, ma prenotazioni richiedono connessione
3. **Monorepo** — unico repository per l'app Flutter (iOS + Android stessa codebase)
4. **Feature-first folder structure** — cartelle organizzate per feature, non per layer tecnico
