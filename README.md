# PAPP — Fitness Booking App

App mobile per la prenotazione di sessioni di allenamento, con programmazione personalizzata e libreria esercizi interattiva.

## Stack

| Layer | Tecnologia |
|-------|-----------|
| Mobile (iOS + Android) | Flutter + Dart |
| Backend | Supabase (Auth · DB · Storage · Realtime) |
| State Management | Riverpod |
| Navigazione | GoRouter |
| Animazioni esercizi | Rive |

## Prerequisiti

- [Flutter SDK](https://docs.flutter.dev/get-started/install) ≥ 3.x
- [Dart](https://dart.dev/get-dart) ≥ 3.x
- Account [Supabase](https://supabase.com) (gratuito)

## Setup

```bash
# 1. Clona la repo
git clone https://github.com/Sebastiano42/PAPP.git
cd PAPP

# 2. Installa dipendenze
flutter pub get

# 3. Configura Supabase (vedi docs/04_DATA_MODEL.md per lo schema)
# Crea un progetto su supabase.com e copia URL + anon key

# 4. Avvia l'app con le variabili d'ambiente
flutter run \
  --dart-define=SUPABASE_URL=https://xxx.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key
```

## Documentazione

Tutta la documentazione di progetto è nella cartella `/docs`:

| File | Contenuto |
|------|-----------|
| `00_PROJECT_OVERVIEW.md` | Panoramica generale |
| `01_TECH_STACK.md` | Stack e motivazioni |
| `02_FEATURES.md` | Feature list (MVP / V2 / V3) |
| `03_ARCHITECTURE.md` | Architettura del sistema |
| `04_DATA_MODEL.md` | Schema database |
| `05_UI_UX_GUIDELINES.md` | Design system e linee guida |

## Struttura Progetto

```
lib/
├── main.dart
├── app/
│   ├── router.dart          # GoRouter — tutte le route
│   ├── shell/               # Bottom navigation shell
│   └── theme/               # Colori, tipografia, tema Flutter
├── core/
│   └── supabase/            # Client Supabase
└── features/
    ├── auth/                # Login, registrazione
    ├── sessions/            # Lista e prenotazione sessioni
    ├── exercises/           # Libreria esercizi + animazioni Rive
    ├── program/             # Home dashboard + programmazione
    └── profile/             # Profilo utente
```

## Palette Colori

| Colore | Hex | Utilizzo |
|--------|-----|---------|
| Nero | `#0A0A0A` | Background dark / Testo light |
| Bianco | `#FFFFFF` | Background light / Testo dark |
| Grigio | varie scale | Superfici, bordi, testi secondari |
| **Giallo-arancio** | `#FF9500` | Unico accento — CTA, progress, elementi attivi |
