# SPAPP — Feature List
## Documento: Funzionalità dell'Applicazione

**Data:** 2026-02-20
**Stato:** Draft — da validare

---

## Legenda Priorità

| Simbolo | Significato |
|---------|-------------|
| 🔴 MVP | Must have — fase 1 |
| 🟡 V2 | Should have — fase 2 |
| 🟢 V3 | Nice to have — fase futura |

---

## 1. Autenticazione & Profilo Utente

| ID | Feature | Priorità | Note |
|----|---------|----------|------|
| F01 | Registrazione con email/password | 🔴 MVP | |
| F02 | Login con email/password | 🔴 MVP | |
| F03 | Login con Google | 🟡 V2 | |
| F04 | Login con Apple ID | 🟡 V2 | Obbligatorio per App Store se si offre social login |
| F05 | Recupero password via email | 🔴 MVP | |
| F06 | Profilo utente privato | 🔴 MVP | Nome, foto, dati fisici opzionali |
| F07 | Modifica profilo | 🔴 MVP | |
| F08 | Foto profilo | 🟡 V2 | Upload su Supabase Storage |
| F09 | Storico allenamenti completati | 🔴 MVP | |
| F10 | Statistiche personali | 🟡 V2 | Sessioni completate, streak, ecc. |

---

## 2. Sessioni di Allenamento

| ID | Feature | Priorità | Note |
|----|---------|----------|------|
| F11 | Lista sessioni disponibili | 🔴 MVP | Con data, ora, posti disponibili |
| F12 | Dettaglio sessione | 🔴 MVP | Coach, tipo allenamento, durata, posti |
| F13 | Prenotazione sessione | 🔴 MVP | |
| F14 | Cancellazione prenotazione | 🔴 MVP | Con policy cancellazione |
| F15 | Posti disponibili in realtime | 🔴 MVP | Aggiornamento live via Supabase Realtime |
| F16 | Lista prenotazioni personali | 🔴 MVP | Prossime + passate |
| F17 | Calendario prenotazioni | 🟡 V2 | Vista mensile/settimanale |
| F18 | Lista d'attesa (waitlist) | 🟡 V2 | Se sessione piena |
| F19 | Notifica posto disponibile | 🟡 V2 | Se si è in waitlist |
| F20 | Conferma prenotazione via notifica | 🔴 MVP | Push notification |
| F21 | Reminder prima della sessione | 🟡 V2 | Es. 1h prima |
| F22 | Filtro sessioni per tipo/coach/data | 🟡 V2 | |
| F23 | Valutazione sessione post-allenamento | 🟢 V3 | Rating + feedback |

---

## 3. Programmazione Allenamento

| ID | Feature | Priorità | Note |
|----|---------|----------|------|
| F24 | Visualizzazione piano allenamento personale | 🔴 MVP | Settimana corrente |
| F25 | Calendario programmazione settimanale | 🔴 MVP | |
| F26 | Piano mensile | 🟡 V2 | |
| F27 | Assegnazione programma da parte del coach | 🔴 MVP | Admin crea e assegna |
| F28 | Programmi predefiniti (templates) | 🟡 V2 | Per livello (principiante, avanzato) |
| F29 | Progressione automatica del programma | 🟢 V3 | AI-based o rule-based |

---

## 4. Libreria Esercizi & Animazioni

| ID | Feature | Priorità | Note |
|----|---------|----------|------|
| F30 | Libreria esercizi completa | 🔴 MVP | Ricercabile per categoria/muscolo |
| F31 | Dettaglio esercizio | 🔴 MVP | Descrizione, muscoli coinvolti |
| F32 | Animazione esercizio (omino Rive) | 🔴 MVP | Visualizzazione movimento |
| F33 | Video esercizio (alternativa/complemento) | 🟡 V2 | Per esercizi complessi |
| F34 | Filtro per gruppo muscolare | 🟡 V2 | |
| F35 | Esercizi preferiti / salvati | 🟡 V2 | |
| F36 | Indicazioni su serie, reps, rest | 🔴 MVP | Nella scheda esercizio nel programma |
| F37 | Timer integrato per rest | 🟡 V2 | Countdown visuale |
| F38 | Modalità allenamento guidato | 🟢 V3 | Esercizio per esercizio con timer |

---

## 5. Area Admin / Coach

| ID | Feature | Priorità | Note |
|----|---------|----------|------|
| F39 | Dashboard admin (web o mobile) | 🔴 MVP | Gestione sessioni e utenti |
| F40 | Creazione/modifica sessioni | 🔴 MVP | Data, ora, capienza, tipo |
| F41 | Gestione prenotazioni | 🔴 MVP | Visualizzare chi ha prenotato |
| F42 | Assegnazione programmi agli utenti | 🔴 MVP | |
| F43 | Creazione esercizi | 🔴 MVP | Con upload animazione/video |
| F44 | Gestione libreria esercizi | 🔴 MVP | |
| F45 | Report presenze | 🟡 V2 | |
| F46 | Comunicazioni push agli utenti | 🟡 V2 | Notifiche broadcast |

---

## 6. Notifiche

| ID | Feature | Priorità | Note |
|----|---------|----------|------|
| F47 | Notifica conferma prenotazione | 🔴 MVP | |
| F48 | Notifica cancellazione prenotazione | 🔴 MVP | |
| F49 | Reminder pre-sessione | 🟡 V2 | Configurabile dall'utente |
| F50 | Notifica posto disponibile (waitlist) | 🟡 V2 | |
| F51 | Notifiche in-app | 🔴 MVP | Centro notifiche interno |

---

## Riepilogo per Fase

### MVP (Fase 1) — Core
- Auth completa (email/password)
- Profilo utente base
- Lista e prenotazione sessioni con realtime
- Programmazione settimanale
- Libreria esercizi con animazioni Rive
- Area admin base
- Notifiche prenotazione

### V2 (Fase 2) — Enhancement
- Social login (Google, Apple)
- Calendario avanzato
- Waitlist
- Reminder e notifiche avanzate
- Filtri e ricerca avanzata
- Statistiche utente
- Video esercizi

### V3 (Fase 3) — Advanced
- Allenamento guidato con timer
- Progressione automatica AI
- Valutazioni e feedback
- Report analytics avanzati
