# SPAPP — Data Model
## Documento: Schema del Database

**Data:** 2026-02-20
**Stato:** Draft — soggetto a revisione

---

## Diagramma Entità-Relazioni (ERD)

```
users ─────────────────┐
  │                    │
  │ 1:1                │ 1:N
  ▼                    ▼
profiles          bookings ────── sessions
                      │               │
                      │           1:N │
                  (waitlist)      session_types

users ──────── user_programs
                   │
                   │ 1:N
               program_days
                   │
                   │ 1:N
             program_exercises ────── exercises
                                          │
                                      1:1 │
                                   exercise_animations
```

---

## Tabelle

### `users` (gestita da Supabase Auth)
Tabella automatica di Supabase — non modificabile direttamente.

| Campo | Tipo | Note |
|-------|------|------|
| `id` | uuid | PK — generato da Auth |
| `email` | text | Unico |
| `created_at` | timestamptz | |

---

### `profiles`
Profilo esteso dell'utente (1:1 con users).

| Campo | Tipo | Note |
|-------|------|------|
| `id` | uuid | PK, FK → users.id |
| `first_name` | text | |
| `last_name` | text | |
| `avatar_url` | text | URL Supabase Storage |
| `role` | enum | 'user' \| 'coach' \| 'admin' |
| `birth_date` | date | Opzionale |
| `phone` | text | Opzionale |
| `created_at` | timestamptz | |
| `updated_at` | timestamptz | |

---

### `session_types`
Tipologie di allenamento (es. HIIT, Yoga, Forza, Cardio).

| Campo | Tipo | Note |
|-------|------|------|
| `id` | uuid | PK |
| `name` | text | Es. "HIIT", "Forza", "Yoga" |
| `description` | text | |
| `color_hex` | text | Per UI (es. "#FF5733") |
| `icon_url` | text | Icona della tipologia |
| `created_at` | timestamptz | |

---

### `sessions`
Singola sessione di allenamento prenotabile.

| Campo | Tipo | Note |
|-------|------|------|
| `id` | uuid | PK |
| `session_type_id` | uuid | FK → session_types.id |
| `coach_id` | uuid | FK → users.id (coach) |
| `title` | text | Es. "HIIT Morning Blast" |
| `description` | text | |
| `starts_at` | timestamptz | Data e ora inizio |
| `ends_at` | timestamptz | Data e ora fine |
| `max_capacity` | integer | Posti massimi |
| `current_bookings` | integer | Posti prenotati (computed o cached) |
| `location` | text | Es. "Sala 1", "Online" |
| `status` | enum | 'scheduled' \| 'cancelled' \| 'completed' |
| `created_at` | timestamptz | |
| `updated_at` | timestamptz | |

---

### `bookings`
Prenotazioni degli utenti alle sessioni.

| Campo | Tipo | Note |
|-------|------|------|
| `id` | uuid | PK |
| `user_id` | uuid | FK → users.id |
| `session_id` | uuid | FK → sessions.id |
| `status` | enum | 'confirmed' \| 'cancelled' \| 'attended' \| 'no_show' |
| `booked_at` | timestamptz | Momento della prenotazione |
| `cancelled_at` | timestamptz | Null se non cancellata |
| `cancellation_reason` | text | Opzionale |

**Constraint:** UNIQUE(user_id, session_id) — un utente non può prenotare due volte la stessa sessione.

---

### `waitlist`
Lista d'attesa per sessioni piene.

| Campo | Tipo | Note |
|-------|------|------|
| `id` | uuid | PK |
| `user_id` | uuid | FK → users.id |
| `session_id` | uuid | FK → sessions.id |
| `position` | integer | Posizione in lista (1 = primo) |
| `joined_at` | timestamptz | |
| `notified_at` | timestamptz | Quando è stato notificato di posto disponibile |

---

### `exercises`
Libreria di esercizi.

| Campo | Tipo | Note |
|-------|------|------|
| `id` | uuid | PK |
| `name` | text | Es. "Squat", "Push-up" |
| `description` | text | Descrizione e istruzioni |
| `muscle_groups` | text[] | Array: ["quadriceps", "glutes"] |
| `equipment` | text[] | Array: ["barbell"] o ["bodyweight"] |
| `difficulty` | enum | 'beginner' \| 'intermediate' \| 'advanced' |
| `category` | enum | 'strength' \| 'cardio' \| 'flexibility' \| 'balance' |
| `created_at` | timestamptz | |

---

### `exercise_media`
Media associati a un esercizio (animazioni Rive, video, thumbnail).

| Campo | Tipo | Note |
|-------|------|------|
| `id` | uuid | PK |
| `exercise_id` | uuid | FK → exercises.id |
| `type` | enum | 'rive_animation' \| 'video' \| 'thumbnail' |
| `url` | text | URL Supabase Storage |
| `created_at` | timestamptz | |

---

### `programs`
Piano di allenamento (template assegnabile).

| Campo | Tipo | Note |
|-------|------|------|
| `id` | uuid | PK |
| `name` | text | Es. "Programma Forza 8 Settimane" |
| `description` | text | |
| `duration_weeks` | integer | Durata in settimane |
| `difficulty` | enum | 'beginner' \| 'intermediate' \| 'advanced' |
| `created_by` | uuid | FK → users.id (coach/admin) |
| `created_at` | timestamptz | |

---

### `program_days`
Giorni di allenamento all'interno di un programma.

| Campo | Tipo | Note |
|-------|------|------|
| `id` | uuid | PK |
| `program_id` | uuid | FK → programs.id |
| `week_number` | integer | Settimana (1, 2, 3...) |
| `day_of_week` | integer | 1=Lunedì, 7=Domenica |
| `name` | text | Es. "Upper Body", "Leg Day" |
| `notes` | text | Note del coach |

---

### `program_exercises`
Esercizi all'interno di un giorno di programma.

| Campo | Tipo | Note |
|-------|------|------|
| `id` | uuid | PK |
| `program_day_id` | uuid | FK → program_days.id |
| `exercise_id` | uuid | FK → exercises.id |
| `order` | integer | Ordine nell'allenamento |
| `sets` | integer | Numero di serie |
| `reps` | text | Es. "10", "8-12", "AMRAP" |
| `rest_seconds` | integer | Secondi di recupero |
| `notes` | text | Note specifiche (es. "mantieni la schiena dritta") |

---

### `user_programs`
Assegnazione di un programma a un utente.

| Campo | Tipo | Note |
|-------|------|------|
| `id` | uuid | PK |
| `user_id` | uuid | FK → users.id |
| `program_id` | uuid | FK → programs.id |
| `start_date` | date | Data di inizio del programma |
| `end_date` | date | Data fine (calcolata) |
| `status` | enum | 'active' \| 'completed' \| 'paused' |
| `assigned_by` | uuid | FK → users.id (coach) |
| `assigned_at` | timestamptz | |

---

### `push_tokens`
Token per notifiche push per dispositivo.

| Campo | Tipo | Note |
|-------|------|------|
| `id` | uuid | PK |
| `user_id` | uuid | FK → users.id |
| `token` | text | FCM o APNs token |
| `platform` | enum | 'ios' \| 'android' |
| `created_at` | timestamptz | |
| `updated_at` | timestamptz | |

---

## Indici Consigliati

```sql
-- Sessioni future (query più frequente)
CREATE INDEX idx_sessions_starts_at ON sessions(starts_at) WHERE status = 'scheduled';

-- Prenotazioni per utente
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- Prenotazioni per sessione (per contare posti)
CREATE INDEX idx_bookings_session_id ON bookings(session_id) WHERE status = 'confirmed';

-- Programma attivo per utente
CREATE INDEX idx_user_programs_active ON user_programs(user_id) WHERE status = 'active';
```

---

## Note sul Design del Database

1. **UUID ovunque** — evita ID sequenziali esposti all'esterno
2. **Soft delete non implementato in MVP** — si può aggiungere in V2
3. **current_bookings in sessions** — può essere un campo calcolato con un database trigger oppure calcolato a runtime con COUNT; per MVP si usa COUNT, in V2 si può ottimizzare con trigger
4. **muscle_groups come array PostgreSQL** — più semplice che una tabella di join per MVP
