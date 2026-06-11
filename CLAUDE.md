# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

**cubelab** is a Flutter app that teaches Rubik's Cube solving by helping users understand what phase they're in (cross, F2L, OLL, PLL) and what to do next — rather than memorizing algorithms.

## Commands

```fish
# Dependencies
flutter pub get

# Run (default device)
flutter run

# Run on specific platform
flutter run -d macos
flutter run -d ios

# Tests
flutter test
flutter test test/cube_state_test.dart   # single file
flutter test --coverage

# Static analysis
flutter analyze

# Format
dart format .

# Build
flutter build macos
flutter build ios
flutter build apk
flutter build appbundle
flutter build web

# Clean
flutter clean
```

## Architecture

### Data Layer (`lib/db/`)

Three strict layers — always go through Services in UI code, never call repositories directly:

1. **Models** (`lib/db/models/`) — `Model<T>` base class; implement `getValuesMap()` and `fillFromValues()` for SQLite serialization.
2. **Repositories** (`lib/db/repositories/`) — `Repository<T>` generic CRUD base hitting SQLite directly. Parameterized queries throughout.
3. **Services** (`lib/db/services/`) — `Service<T>` wraps repositories, adds `setup()` (upsert). **Only layer UI should call.**

`DatabaseService` is a singleton managing `cubelab.db`. Schema migrations are in `lib/db/migrations.dart`.

### Cube Logic (`lib/cube/`)

- `CubeState` — 3×3 cube represented as 8 corners (permutation + orientation) and 12 edges. Has `fromFacelets()` factory and phase detection methods.
- `CubeMove` — Individual moves (U, R, F, D, L, B) with 90°/180°/270° variants.
- `CubePhase` — Enum: `initialScramble → cross → f2l → oll → pll → solved`. Drives the learning flow.

### Scan Flow (`lib/scan/`)

Camera input (via `camera` package) with a manual fallback form (`cube_state_form.dart`) for entering cube colors directly when the camera isn't available.

### Routing

`go_router` in `lib/main.dart`. Routes: `/` → home, `/home`, `/scan`, `/learn`, `/settings`. All transitions use `FadeTransition` with `easeInOutCirc`.

### Theming

- `AppTheme` extends `ThemeExtension<AppTheme>` — use `context.appTheme` everywhere, not `Theme.of(context)`.
- Semantic color names (e.g., `backgroundColor`, `accentColor`, `cubeColors`) — define new colors semantically, never use raw color values in widgets.
- `HIcon` wraps SVG assets (`assets/icons/`) with theme-aware color mapping. Use it for all icons; don't use `SvgPicture` directly.
- Icon paths are centralized in `lib/theme/icon_path.dart`.
- Custom **Brandon** font family (weights 100–700) used throughout.

### State Management

`provider` package. `SettingsProvider` (ChangeNotifier) is the main app-wide state — locale, theme mode, haptics, menu caption visibility. Settings are persisted to SQLite via `SettingsService`.

### Internationalization

`flutter_localizations` with auto-generated delegates. Translation ARB files are organized by feature under `lib/l10n/` (general, home, scan, learn, settings). Languages: English, French, Spanish.

## Conventions

- Access theme via `context.appTheme`, not `Theme.of(context)`.
- All SVG icons via `HIcon`, never bare `SvgPicture`.
- Services only in UI — not repositories.
- Models own their serialization via `getValuesMap()` / `fillFromValues()`.
- Linting via `flutter_lints`; `prefer_const_constructors` is enforced.
- Pre-commit hooks via `flutter_pre_commit` — don't skip them.
