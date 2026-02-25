# Setup Log - WEFIT Project
**Data:** 2026-02-21
**Tecnico:** Claude (AI Assistant)
**Cliente:** Monia

---

## 📌 PANORAMICA

Questo documento descrive il setup completo dell'ambiente di sviluppo Flutter per il progetto **WEFIT** (PAPP - Fitness Booking App) su Windows.

---

## 🎯 OBIETTIVO

Configurare da zero un ambiente di sviluppo Flutter completo per sviluppare un'app mobile iOS/Android con:
- Flutter SDK
- Android Studio + Android SDK
- Dipendenze del progetto
- Asset necessari (font, struttura cartelle)

---

## 💻 AMBIENTE DI LAVORO

**Sistema Operativo:** Windows 10 (Build 26200.7840)
**Directory Progetto:** `C:\Users\monia\Desktop\Progetti\wefit`
**Repository GitHub:** https://github.com/Sebastiano42/PAPP

---

## ✅ TASK COMPLETATI

### 1. Installazione Flutter SDK

**Versione installata:** Flutter 3.27.1 (Dart 3.6.0)
**Percorso:** `C:\src\flutter`

**Passi eseguiti:**
```bash
# Download Flutter SDK
curl -L -o flutter_windows.zip "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.27.1-stable.zip"

# Estrazione
unzip flutter_windows.zip -d C:\src\

# Configurazione PATH (permanente)
setx PATH "C:\src\flutter\bin;%PATH%"

# Disabilitazione analytics
flutter --disable-analytics
```

**Verifica:**
```bash
C:\src\flutter\bin\flutter.bat --version
# Output: Flutter 3.27.1 • Dart 3.6.0
```

---

### 2. Installazione Android Studio

**Versione installata:** Android Studio 2024.2
**Percorso:** `C:\Program Files\Android\Android Studio`
**Android SDK:** `C:\Users\monia\AppData\Local\Android\Sdk`

**Passi eseguiti:**
```bash
# Download installer
curl -L -o android-studio-installer.exe "https://redirector.gvt1.com/edgedl/android/studio/install/2024.2.1.12/android-studio-2024.2.1.12-windows.exe"

# Installazione manuale tramite GUI
# - Setup Standard
# - Android SDK, Platform Tools, Build Tools installati
# - Android SDK 34.0.0
```

**Componenti installati:**
- Android SDK Platform 34
- Android SDK Build-Tools 34.0.0
- Android Emulator
- Platform-tools
- System images

---

### 3. Installazione Android Command-Line Tools

I cmdline-tools non erano inclusi nell'installazione di Android Studio, quindi sono stati installati manualmente.

**Versione:** 11076708
**Percorso:** `C:\Users\monia\AppData\Local\Android\Sdk\cmdline-tools\latest\`

**Passi eseguiti:**
```bash
# Download cmdline-tools
curl -L -o commandlinetools-win.zip "https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip"

# Estrazione nella directory SDK
unzip commandlinetools-win.zip -d C:\Users\monia\AppData\Local\Android\Sdk\cmdline-tools

# Rinomina per struttura corretta
cd C:\Users\monia\AppData\Local\Android\Sdk\cmdline-tools
mv cmdline-tools latest
```

---

### 4. Accettazione Licenze Android

**Problema riscontrato:** Le licenze Android SDK non erano state accettate automaticamente.

**Soluzione:**
```bash
# Script creato: C:\Users\monia\Desktop\accept-licenses.bat
set JAVA_HOME=C:\Program Files\Android\Android Studio\jbr
echo y | sdkmanager.bat --licenses

# Esecuzione manuale dall'utente tramite:
cd C:\src\flutter\bin
flutter.bat doctor --android-licenses
# (premuto 'y' per ogni licenza)
```

**Verifica:**
```bash
flutter doctor
# Output: [✓] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
```

---

### 5. Installazione Dipendenze Progetto

**Eseguito in:** `C:\Users\monia\Desktop\Progetti\wefit`

```bash
flutter pub get
```

**Risultato:**
- ✅ 52 dipendenze installate correttamente
- ⚠️ 83 pacchetti hanno versioni più recenti disponibili (ma incompatibili con i constraint attuali)

**Dipendenze principali installate:**
- `supabase_flutter: ^2.5.0` - Backend
- `flutter_riverpod: ^2.5.1` - State management
- `go_router: ^13.2.0` - Navigazione
- `rive: ^0.13.4` - Animazioni esercizi
- `flutter_animate: ^4.5.0` - Animazioni UI
- `lottie: ^3.1.0` - Animazioni JSON
- `cached_network_image: ^3.3.1` - Cache immagini
- `fl_chart: ^0.68.0` - Grafici
- `table_calendar: ^3.1.2` - Calendario
- `shimmer: ^3.0.0` - Loading UI

---

### 6. Setup Asset

**Struttura creata:**
```
wefit/
├── assets/
│   ├── fonts/
│   │   ├── Inter-Regular.ttf (407 KB)
│   │   ├── Inter-SemiBold.ttf (414 KB)
│   │   ├── Inter-Bold.ttf (415 KB)
│   │   └── Inter-Black.ttf (414 KB)
│   ├── animations/ (vuota, pronta per file .riv)
│   └── images/ (vuota, pronta per immagini)
```

**Font scaricati:**
```bash
# Download Inter font family v4.0
curl -L -o Inter.zip "https://github.com/rsms/inter/releases/download/v4.0/Inter-4.0.zip"

# Estrazione e copia dei font necessari
cp extras/ttf/Inter-Regular.ttf assets/fonts/
cp extras/ttf/Inter-SemiBold.ttf assets/fonts/
cp extras/ttf/Inter-Bold.ttf assets/fonts/
cp extras/ttf/Inter-Black.ttf assets/fonts/
```

**Configurazione in pubspec.yaml (già presente):**
```yaml
fonts:
  - family: Inter
    fonts:
      - asset: assets/fonts/Inter-Regular.ttf
        weight: 400
      - asset: assets/fonts/Inter-SemiBold.ttf
        weight: 600
      - asset: assets/fonts/Inter-Bold.ttf
        weight: 700
      - asset: assets/fonts/Inter-Black.ttf
        weight: 900
```

---

## 📊 STATO FINALE - Flutter Doctor

```
[!] Flutter (Channel stable, 3.27.1)
    ! Flutter binary non nel PATH globale (configurato, richiede riavvio terminale)

[✓] Windows Version (10.0.26200.7840)

[✓] Android toolchain (Android SDK version 34.0.0)
    • Android SDK at C:\Users\monia\AppData\Local\Android\sdk
    • Platform android-34, build-tools 34.0.0
    • Java version OpenJDK Runtime Environment (build 21.0.3)

[✓] Chrome - develop for the web

[✗] Visual Studio (NON NECESSARIO per Android/iOS)
    • Serve solo per sviluppo app Windows native

[✓] Android Studio (version 2024.2)
    • Plugin Flutter e Dart da installare (opzionale)

[✓] VS Code
    • Estensione Flutter da installare (opzionale)

[✓] Connected device (3 available)
    • Windows (desktop)
    • Chrome (web)
    • Edge (web)

[✓] Network resources
```

**Verdict:** ✅ Ambiente pronto per sviluppo Android/iOS

---

## ⚠️ PROBLEMI RISCONTRATI NEL CODICE

Durante l'analisi statica (`flutter analyze`) sono emersi **6 errori** nel codice esistente:

### Errori da correggere:

1. **login_screen.dart:95** e **register_screen.dart:112**
   ```dart
   // ❌ ERRORE
   Icons.visibility_outline
   Icons.visibility_off_outline

   // ✅ CORREZIONE
   Icons.visibility
   Icons.visibility_off
   ```
   **Motivo:** Le icone `*_outline` non esistono in Flutter Material Icons.

2. **program_screen.dart:194**
   ```dart
   // ❌ ERRORE
   theme.textTheme.caption

   // ✅ CORREZIONE
   theme.textTheme.bodySmall  // o labelSmall
   ```
   **Motivo:** `caption` è deprecato da Flutter 3.0+

3. **exercises_screen.dart:28**
   ```dart
   // ⚠️ WARNING
   final theme = Theme.of(context); // variabile non usata

   // ✅ CORREZIONE
   // Rimuovere la variabile o utilizzarla
   ```

---

## 📦 STRUTTURA PROGETTO

```
wefit/
├── .git/                         # Repository Git
├── .claude/                      # Configurazione Claude AI
├── lib/
│   ├── main.dart                 # Entry point
│   ├── app/
│   │   ├── router.dart          # GoRouter config
│   │   ├── shell/
│   │   │   └── main_shell.dart  # Bottom navigation
│   │   └── theme/
│   │       ├── app_theme.dart
│   │       ├── app_colors.dart
│   │       └── app_typography.dart
│   ├── core/
│   │   └── supabase/
│   │       └── supabase_client.dart
│   └── features/
│       ├── auth/
│       │   └── presentation/
│       │       └── screens/
│       │           ├── login_screen.dart
│       │           └── register_screen.dart
│       ├── sessions/
│       ├── exercises/
│       ├── program/
│       └── profile/
├── docs/                         # Documentazione completa
│   ├── 00_PROJECT_OVERVIEW.md
│   ├── 01_TECH_STACK.md
│   ├── 02_FEATURES.md
│   ├── 03_ARCHITECTURE.md
│   ├── 04_DATA_MODEL.md
│   └── 05_UI_UX_GUIDELINES.md
├── assets/
│   ├── fonts/                    # ✅ Font Inter installati
│   ├── animations/               # 📁 Pronta per file .riv
│   └── images/                   # 📁 Pronta per immagini
├── pubspec.yaml                  # Dipendenze
├── pubspec.lock
├── README.md
└── SETUP_LOG.md                  # Questo file

```

---

## 🔧 CONFIGURAZIONI APPLICATE

### Variabili d'Ambiente (Windows)

```cmd
# PATH (permanente)
C:\src\flutter\bin

# JAVA_HOME (usato da Android SDK tools)
C:\Program Files\Android\Android Studio\jbr
```

**Nota:** Il PATH è stato configurato con `setx`, quindi sarà attivo nelle nuove sessioni di terminale.

---

## 🚀 COME AVVIARE IL PROGETTO

### 1. Verificare l'ambiente
```bash
cd C:\Users\monia\Desktop\Progetti\wefit
C:\src\flutter\bin\flutter.bat doctor -v
```

### 2. Avviare un emulatore Android

**Opzione A - Da Android Studio:**
1. Aprire Android Studio
2. Tools → Device Manager
3. Creare/avviare un Virtual Device

**Opzione B - Da linea di comando:**
```bash
# Listare emulatori disponibili
C:\Users\monia\AppData\Local\Android\Sdk\emulator\emulator.exe -list-avds

# Avviare emulatore
C:\Users\monia\AppData\Local\Android\Sdk\emulator\emulator.exe -avd <nome_avd>
```

### 3. Eseguire l'app

```bash
cd C:\Users\monia\Desktop\Progetti\wefit

# Con emulatore già avviato
C:\src\flutter\bin\flutter.bat run

# O specificare device
C:\src\flutter\bin\flutter.bat devices
C:\src\flutter\bin\flutter.bat run -d <device_id>
```

**Nota:** L'app richiede credenziali Supabase per funzionare. Usare:
```bash
flutter run \
  --dart-define=SUPABASE_URL=https://xxx.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key
```

---

## 📝 TASK DA COMPLETARE

### 🔴 Alta Priorità

1. **Correggere errori di codice**
   - [ ] Sostituire `Icons.visibility_outline` → `Icons.visibility`
   - [ ] Sostituire `Icons.visibility_off_outline` → `Icons.visibility_off`
   - [ ] Sostituire `TextTheme.caption` → `TextTheme.bodySmall`
   - [ ] Rimuovere variabile `theme` inutilizzata in exercises_screen.dart

2. **Setup Backend Supabase**
   - [ ] Creare progetto su https://supabase.com
   - [ ] Implementare schema database (vedi `docs/04_DATA_MODEL.md`)
   - [ ] Configurare Row Level Security (RLS)
   - [ ] Ottenere SUPABASE_URL e SUPABASE_ANON_KEY
   - [ ] Creare file `.env` o usare `--dart-define`

3. **Creare emulatore Android**
   - [ ] Configurare AVD (Android Virtual Device) in Android Studio
   - [ ] Testare avvio emulatore
   - [ ] Verificare che Flutter riconosca il device

### 🟡 Media Priorità

4. **Installare plugin IDE (opzionale ma consigliato)**
   - [ ] Flutter plugin per Android Studio
   - [ ] Dart plugin per Android Studio
   - [ ] Flutter extension per VS Code

5. **Aggiungere animazioni Rive**
   - [ ] Creare/scaricare animazioni esercizi in formato .riv
   - [ ] Posizionare in `assets/animations/`
   - [ ] Testare rendering in app

6. **Aggiungere immagini placeholder**
   - [ ] Logo app
   - [ ] Icone categorie allenamento
   - [ ] Immagini placeholder per sessioni

### 🟢 Bassa Priorità

7. **Ottimizzazione dipendenze**
   - [ ] Eseguire `flutter pub outdated`
   - [ ] Valutare aggiornamento pacchetti compatibili
   - [ ] Testare compatibilità

8. **Configurazione CI/CD**
   - [ ] Setup GitHub Actions
   - [ ] Configurare build automatiche
   - [ ] Test automatici

---

## 🐛 TROUBLESHOOTING

### Problema: "flutter: command not found"
**Soluzione:**
- Chiudere e riaprire il terminale (PATH configurato con setx)
- Oppure usare il percorso completo: `C:\src\flutter\bin\flutter.bat`

### Problema: "Android licenses not accepted"
**Soluzione:**
```bash
C:\src\flutter\bin\flutter.bat doctor --android-licenses
# Premere 'y' per ogni licenza
```

### Problema: "JAVA_HOME not set"
**Soluzione:**
```cmd
set JAVA_HOME=C:\Program Files\Android\Android Studio\jbr
set PATH=%JAVA_HOME%\bin;%PATH%
```

### Problema: Emulatore non parte
**Soluzioni:**
1. Verificare virtualizzazione abilitata nel BIOS
2. Installare Intel HAXM (se CPU Intel)
3. Usare emulatore ARM invece di x86
4. Verificare spazio disco disponibile (almeno 10GB)

### Problema: "Gradle build failed"
**Soluzioni:**
1. Verificare connessione internet
2. Aumentare heap size Gradle
3. Pulire build: `flutter clean && flutter pub get`

---

## 📚 RISORSE UTILI

### Documentazione Progetto
- **Project Overview:** `docs/00_PROJECT_OVERVIEW.md`
- **Tech Stack:** `docs/01_TECH_STACK.md`
- **Features:** `docs/02_FEATURES.md`
- **Architecture:** `docs/03_ARCHITECTURE.md`
- **Data Model:** `docs/04_DATA_MODEL.md`
- **UI/UX Guidelines:** `docs/05_UI_UX_GUIDELINES.md`

### Link Esterni
- [Flutter Docs](https://docs.flutter.dev/)
- [Supabase Docs](https://supabase.com/docs)
- [Riverpod Docs](https://riverpod.dev/)
- [GoRouter Package](https://pub.dev/packages/go_router)
- [Rive Animations](https://rive.app/)

### Repository
- **Codice:** https://github.com/Sebastiano42/PAPP
- **Issues:** https://github.com/Sebastiano42/PAPP/issues

---

## 👥 CONTATTI

**Cliente:** Monia
**Repository Owner:** Sebastiano42 (GitHub)
**Progetto:** WEFIT (PAPP - Fitness Booking App)

---

## 📅 CRONOLOGIA

| Data | Attività | Stato |
|------|----------|-------|
| 2026-02-21 | Setup Flutter SDK 3.27.1 | ✅ Completato |
| 2026-02-21 | Installazione Android Studio 2024.2 | ✅ Completato |
| 2026-02-21 | Configurazione Android SDK + licenze | ✅ Completato |
| 2026-02-21 | Installazione dipendenze progetto | ✅ Completato |
| 2026-02-21 | Setup asset (font Inter) | ✅ Completato |
| 2026-02-21 | Analisi codice - trovati 6 errori | ⚠️ Da correggere |
| - | Correzione errori codice | ⏳ Pending |
| - | Setup Supabase backend | ⏳ Pending |
| - | Primo test su emulatore | ⏳ Pending |

---

## ✅ CHECKLIST RAPIDA

**Ambiente di sviluppo:**
- [x] Flutter SDK installato
- [x] Android Studio installato
- [x] Android SDK configurato
- [x] Licenze Android accettate
- [x] Dipendenze progetto installate
- [x] Font configurati
- [x] Struttura asset creata

**Backend:**
- [ ] Progetto Supabase creato
- [ ] Database schema implementato
- [ ] Credenziali ottenute
- [ ] RLS configurato

**Testing:**
- [ ] Emulatore Android configurato
- [ ] App avviata su emulatore
- [ ] Test navigazione base
- [ ] Test connessione Supabase

**Sviluppo:**
- [ ] Errori codice corretti
- [ ] IDE plugin installati
- [ ] Hot reload testato
- [ ] Debug funzionante

---

**Fine Setup Log**
_Generato automaticamente da Claude AI - 2026-02-21_
