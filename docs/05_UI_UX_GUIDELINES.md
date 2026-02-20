# SPAPP — UI/UX Guidelines
## Documento: Linee Guida Design e UX

**Data:** 2026-02-20
**Stato:** Draft — v2 (palette aggiornata)

---

## Filosofia di Design

SPAPP deve trasmettere **energia, motivazione e chiarezza**.
- **Energia** — contrasto alto, accento vibrante, animazioni dinamiche
- **Motivazione** — feedback visivi positivi, progressi celebrati
- **Chiarezza** — navigazione intuitiva, gerarchia visiva netta

---

## Direzione Estetica

### Mood & Tone
- Palette ristretta e coerente: **bianco · nero · grigio · giallo-arancio**
- Stile atletico, diretto, ad alto contrasto — pensa Nike, Gymshark
- Il giallo-arancio è l'unico accento cromatico: usarlo con parsimonia e intenzione
- Forme pulite, geometriche, senza decorazioni superflue
- Tipografia bold e potente per i titoli
- Entrambi i temi (light e dark) condividono esattamente gli stessi colori, invertiti

### Riferimenti Visivi (Benchmark)
- **Nike Training Club** — alto contrasto, chiarezza, premium feel
- **Gymshark** — bianco/nero con accento caldo, atletico
- **Freeletics** — energia e motivazione visiva
- **Strava** — dati e statistiche ben presentati

---

## Palette Colori

> La palette usa **esclusivamente** queste famiglie: bianco, nero, grigio, giallo-arancio.
> Nessun altro colore è ammesso nel design dell'interfaccia.

### Colori Base (condivisi tra i due temi)

```
Giallo-arancio principale:  #FF9500   (accento, CTA, highlights, elementi attivi)
Giallo-arancio scuro:       #CC7700   (pressed state, hover su light)
Giallo-arancio chiaro:      #FFB84D   (tint, sfondo badge su dark)
```

---

### Light Theme

```
┌─────────────────────────────────────────────────────────┐
│  SFONDI                                                  │
│  Background principale:   #FFFFFF   (bianco puro)        │
│  Background secondario:   #F2F2F2   (grigio chiarissimo) │
│  Background terziario:    #E5E5E5   (grigio chiaro)      │
│                                                          │
│  ACCENTO                                                 │
│  Accent primario:         #FF9500   (giallo-arancio)     │
│  Accent pressed:          #CC7700   (giallo-arancio scuro│
│  Accent tint (sfondo):    #FFF3E0   (arancio chiarissimo)│
│                                                          │
│  TESTI                                                   │
│  Testo primario:          #0A0A0A   (nero quasi puro)    │
│  Testo secondario:        #4A4A4A   (grigio scuro)       │
│  Testo terziario:         #8A8A8A   (grigio medio)       │
│  Testo disabilitato:      #B5B5B5   (grigio chiaro)      │
│  Testo su accento:        #0A0A0A   (nero su giallo)     │
│                                                          │
│  BORDI & DIVIDERS                                        │
│  Bordo standard:          #D4D4D4   (grigio tenue)       │
│  Bordo enfatizzato:       #8A8A8A   (grigio medio)       │
│                                                          │
│  SEMANTICI (entro la palette)                            │
│  Successo / Confermato:   #0A0A0A + icona check          │
│  Errore / Cancellato:     #0A0A0A + icona x             │
│  Warning / Quasi pieno:   #FF9500   (stesso accento)     │
│  Pieno / Indisponibile:   #B5B5B5   (grigio disabilitato)│
└─────────────────────────────────────────────────────────┘
```

**Anteprima Light:**
```
┌─────────────────────────────────┐  sfondo bianco #FFFFFF
│  BENVENUTO                      │  testo nero #0A0A0A
│  ─────────────────────────────  │  divider grigio #D4D4D4
│  ┌───────────────────────────┐  │
│  │  HIIT Morning Blast       │  │  card grigio #F2F2F2
│  │  09:00 · Sala 1           │  │  testo secondario #4A4A4A
│  │  ████████░░  8/15         │  │  barra accento #FF9500
│  │         [ PRENOTA → ]     │  │  bottone #FF9500, testo #0A0A0A
│  └───────────────────────────┘  │
└─────────────────────────────────┘
```

---

### Dark Theme

```
┌─────────────────────────────────────────────────────────┐
│  SFONDI                                                  │
│  Background principale:   #0A0A0A   (nero quasi puro)   │
│  Background secondario:   #141414   (grigio scurissimo) │
│  Background terziario:    #1F1F1F   (grigio scuro)      │
│                                                          │
│  ACCENTO                                                 │
│  Accent primario:         #FF9500   (giallo-arancio)     │
│  Accent pressed:          #FFB84D   (giallo-arancio tenue│
│  Accent tint (sfondo):    #2A1F00   (arancio scurissimo) │
│                                                          │
│  TESTI                                                   │
│  Testo primario:          #FFFFFF   (bianco puro)        │
│  Testo secondario:        #A3A3A3   (grigio chiaro)      │
│  Testo terziario:         #6B6B6B   (grigio medio)       │
│  Testo disabilitato:      #3D3D3D   (grigio scuro)       │
│  Testo su accento:        #0A0A0A   (nero su giallo)     │
│                                                          │
│  BORDI & DIVIDERS                                        │
│  Bordo standard:          #2A2A2A   (grigio molto scuro) │
│  Bordo enfatizzato:       #4A4A4A   (grigio scuro)       │
│                                                          │
│  SEMANTICI (entro la palette)                            │
│  Successo / Confermato:   #FFFFFF + icona check          │
│  Errore / Cancellato:     #FFFFFF + icona x             │
│  Warning / Quasi pieno:   #FF9500   (stesso accento)     │
│  Pieno / Indisponibile:   #3D3D3D   (grigio disabilitato)│
└─────────────────────────────────────────────────────────┘
```

**Anteprima Dark:**
```
┌─────────────────────────────────┐  sfondo nero #0A0A0A
│  BENVENUTO                      │  testo bianco #FFFFFF
│  ─────────────────────────────  │  divider grigio #2A2A2A
│  ┌───────────────────────────┐  │
│  │  HIIT Morning Blast       │  │  card grigio #141414
│  │  09:00 · Sala 1           │  │  testo secondario #A3A3A3
│  │  ████████░░  8/15         │  │  barra accento #FF9500
│  │         [ PRENOTA → ]     │  │  bottone #FF9500, testo #0A0A0A
│  └───────────────────────────┘  │
└─────────────────────────────────┘
```

---

### Regole d'uso dell'Accento (#FF9500)

1. **CTA primari** — bottone principale di ogni schermata
2. **Elementi attivi** — tab selezionata, toggle on, progresso barra
3. **Highlights** — stat importante, badge "NUOVO", label categoria
4. **Mai** su grandi superfici di sfondo — solo su elementi puntuali
5. **Mai** come colore di testo su sfondi chiari (contrasto insufficiente) — usarlo come sfondo con testo nero sopra

---

## Tipografia

### Font Principale: **Inter**
- Moderna, leggibile, ottima per UI ad alto contrasto
- Disponibile gratuitamente (Google Fonts)

### Gerarchia

| Stile | Peso | Dimensione | Utilizzo |
|-------|------|------------|---------|
| Display XL | Black (900) | 40px | Titoli hero, splash |
| Heading 1 | Bold (700) | 28px | Titoli schermata |
| Heading 2 | SemiBold (600) | 22px | Sezioni |
| Heading 3 | SemiBold (600) | 18px | Card title |
| Body Large | Regular (400) | 16px | Testo principale |
| Body Small | Regular (400) | 14px | Testo secondario |
| Caption | Regular (400) | 12px | Labels, metadata |
| Button | SemiBold (600) | 15px | CTA — MAIUSCOLO |

> I titoli principali vanno preferibilmente in **MAIUSCOLO** per enfatizzare il tono atletico.

---

## Spacing System

Basato su multipli di **4px**:

```
4px   → xs    (padding minimo, gap icona-testo)
8px   → sm    (padding interno card piccole)
12px  → md-sm
16px  → md    (padding standard, margin tra elementi)
24px  → lg    (padding sezioni)
32px  → xl    (margin tra sezioni)
48px  → 2xl   (spazi grandi)
64px  → 3xl   (spazi hero)
```

---

## Border Radius

```
4px   → piccoli elementi (badge, chip, tag)
8px   → bottoni, input, card compatte
12px  → card standard
16px  → card grandi, modal
24px  → bottom sheet
999px → pill (bottoni full-rounded, avatar)
```

---

## Navigazione

### Struttura Bottom Navigation (MVP)

```
┌─────────────────────────────────────────┐
│                                         │
│              [Content Area]             │
│                                         │
├─────────────────────────────────────────┤
│  Home  │  Sessioni  │  Esercizi  │  Profilo │
│   ●    │            │            │          │
│ (attivo = icona + label in #FF9500)         │
└─────────────────────────────────────────┘
```

| Tab | Contenuto |
|-----|-----------|
| **Home** | Dashboard: prossima sessione, programma oggi, statistiche |
| **Sessioni** | Lista sessioni disponibili, prenotazioni attive |
| **Esercizi** | Libreria esercizi con animazioni |
| **Profilo** | Profilo utente, storico, impostazioni |

---

## Schermate Principali

### 1. Onboarding / Auth

```
LIGHT:                              DARK:
┌─────────────────────┐             ┌─────────────────────┐
│ sfondo #FFFFFF       │             │ sfondo #0A0A0A       │
│                     │             │                     │
│   [Logo SPAPP]      │             │   [Logo SPAPP]      │
│   testo #0A0A0A     │             │   testo #FFFFFF     │
│                     │             │                     │
│  [Splash animata]   │             │  [Splash animata]   │
│                     │             │                     │
│  "IL TUO            │             │  "IL TUO            │
│   ALLENAMENTO       │             │   ALLENAMENTO       │
│   INIZIA QUI"       │             │   INIZIA QUI"       │
│                     │             │                     │
│ [██ INIZIA →] #FF9500│            │ [██ INIZIA →] #FF9500│
│ [    Accedi   ]     │             │ [    Accedi   ]     │
└─────────────────────┘             └─────────────────────┘
```

### 2. Home Dashboard

```
┌──────────────────────────┐
│ BUONGIORNO, MARCO        │  ← testo primario
│ Lunedì 20 Feb            │  ← testo secondario (grigio)
├──────────────────────────┤
│  PROSSIMA SESSIONE       │  ← label sezione (grigio)
│  ┌────────────────────┐  │
│  │ HIIT BLAST         │  │  ← card (bg secondario)
│  │ Oggi · 18:30       │  │
│  │ ██████████░  12/15 │  │  ← barra #FF9500
│  │       [PRENOTA →]  │  │  ← bottone #FF9500, nero sopra
│  └────────────────────┘  │
├──────────────────────────┤
│  ALLENAMENTO OGGI        │
│  Leg Day                 │
│  [Squat] [Lunge] [RDL]  │  ← chip/pill bordo grigio
├──────────────────────────┤
│  QUESTA SETTIMANA        │
│  ▓▓▓░░░░  3/7 giorni    │  ← barra progresso #FF9500
└──────────────────────────┘
```

### 3. Lista Sessioni

```
┌──────────────────────────┐
│ SESSIONI                 │
│ [OGGI] [SETT.] [MESE]   │  ← tab attivo in #FF9500
├──────────────────────────┤
│ LUN 20 FEB               │  ← label data (grigio)
│ ┌────────────────────┐   │
│ │ HIIT               │   │  ← card bg secondario
│ │ 09:00 – 10:00      │   │
│ │ Coach: Sara        │   │  ← grigio
│ │ ██████░░  8/15     │   │  ← barra #FF9500
│ └────────────────────┘   │
│ ┌────────────────────┐   │
│ │ YOGA               │   │
│ │ 18:30 – 19:30      │   │
│ │ Coach: Luca        │   │
│ │ COMPLETO           │   │  ← testo grigio disabilitato
│ └────────────────────┘   │
└──────────────────────────┘
```

### 4. Dettaglio Esercizio con Animazione

```
┌──────────────────────────┐
│ ←  SQUAT                 │
├──────────────────────────┤
│                          │
│   [  ANIMAZIONE RIVE  ]  │  ← sfondo bg terziario
│   omino che esegue       │
│   il movimento           │
│                          │
├──────────────────────────┤
│ MUSCOLI COINVOLTI        │
│ [Quadricipiti] [Glutei]  │  ← chip con bordo grigio, attivi #FF9500
│                          │
│ Difficoltà               │
│ ●●●○○  Intermedio        │  ← pallini #FF9500 / grigio
│                          │
│ COME ESEGUIRE            │
│ 1. Piedi larghezza       │
│    spalle...             │
└──────────────────────────┘
```

---

## Animazioni & Transizioni

### Principi
- **Purposeful** — ogni animazione ha uno scopo (feedback, transizione, attenzione)
- **Fast** — durate brevi: 200ms (micro), 300ms (standard), 400ms (complesse)
- **Consistent** — stesso easing ovunque: `Curves.easeOutCubic`

### Animazioni specifiche

| Elemento | Animazione | Durata |
|----------|-----------|--------|
| Tap bottone | Scale 0.95 + feedback haptic | 150ms |
| Navigazione tab | Slide + fade | 300ms |
| Card prenotazione confermata | Flash bordo #FF9500 + check | 400ms |
| Caricamento pagina | Shimmer skeleton (grigio) | continua |
| Esercizio animato (Rive) | Loop continuo, interattivo | — |
| Posti disponibili (realtime) | Numero che cambia con fade | 200ms |
| Sessione completata | Burst di forme geometriche #FF9500 | 800ms |

---

## Componenti UI Chiave

### Bottoni

```
PRIMARY:   [████ PRENOTA ORA ████]  sfondo #FF9500, testo nero bold
SECONDARY: [─ ─  Vedi Dettagli ─ ] bordo grigio, testo primario
GHOST:     [      Annulla       ]   solo testo grigio, no bordo
DISABLED:  [████ NON DISPONIBILE ]  sfondo grigio disabilitato, testo grigio
```

### Card Sessione

```
┌─────────────────────────────┐
│ HIIT MORNING BLAST          │  ← testo primario bold
│ Coach: Sara Rossi           │  ← testo secondario grigio
│                             │
│ Lun 20 Feb · 09:00          │
│ 60 min · Sala Principale    │
│                             │
│ ██████████░░  8/15 posti    │  ← barra #FF9500
│                             │
│              [PRENOTA →]    │  ← bottone #FF9500
└─────────────────────────────┘
```

### Badge Disponibilità

```
DISPONIBILE   → testo bianco/nero, bordo grigio
QUASI PIENO   → bordo #FF9500, testo #FF9500
COMPLETO      → testo grigio disabilitato, sfondo grigio tenue
IN WAITLIST   → sfondo #FF9500 tint, testo primario
PRENOTATO     → sfondo #FF9500, testo nero
```

---

## Accessibilità

- **Contrasto minimo** — WCAG AA (4.5:1 per testo normale)
  - Testo nero #0A0A0A su #FF9500: rapporto ~4.6:1 ✅
  - Testo bianco #FFFFFF su #0A0A0A: rapporto 19.6:1 ✅
  - Testo #0A0A0A su #FFFFFF: rapporto 19.6:1 ✅
- **Touch target minimo** — 44x44pt (linee guida Apple/Google)
- **Supporto Dynamic Type** — font scalabili con impostazioni sistema
- **Haptic feedback** — su azioni importanti (prenotazione confermata)
- **Screen reader** — semantic labels su tutti gli elementi interattivi

---

## App Icon & Splash

- **Icon light:** lettera "S" o simbolo atletico in nero su sfondo #FF9500
- **Icon dark:** lettera "S" o simbolo atletico in #FF9500 su sfondo nero
- **Splash screen:** animazione Rive breve (max 2 secondi) — logo che appare, accento arancio
- **Adaptive icon Android:** supporto monocromatico

---

## Design Deliverable (da produrre in Figma)

- [ ] Design system / component library (light + dark)
- [ ] Palette token naming (es. `color.accent.primary`, `color.bg.primary`)
- [ ] Wireframes bassa fedeltà — tutti i flussi MVP
- [ ] Mockup alta fedeltà — schermate principali (entrambi i temi)
- [ ] Prototipo interattivo — flusso prenotazione
- [ ] Animazioni Rive — almeno 3 esercizi base per MVP
