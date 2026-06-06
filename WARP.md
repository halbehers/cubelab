# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

cubelab is a Flutter-based lunar calendar application that supports multiple calendar views (year, month, week) with event management and persistent settings storage. The app uses SQLite for local data persistence and go_router for navigation.

## Development Commands

### Setup and Dependencies
```fish
flutter pub get
```

### Run Application
```fish
# Run on default device
flutter run

# Run on specific platform
flutter run -d macos
flutter run -d ios
flutter run -d android
flutter run -d web

# Run with hot reload (default behavior)
flutter run --hot
```

### Build
```fish
# Build for macOS
flutter build macos

# Build for iOS
flutter build ios

# Build for Android
flutter build apk        # Debug APK
flutter build appbundle  # Release bundle

# Build for web
flutter build web

# Build for Linux
flutter build linux

# Build for Windows
flutter build windows
```

### Testing
```fish
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage
```

### Code Quality
```fish
# Static analysis
flutter analyze

# Format code
dart format .

# Format specific file
dart format lib/main.dart
```

### Clean Build Artifacts
```fish
flutter clean
```

## Architecture

### Three-Layer Data Architecture

The codebase follows a clean architecture pattern with three distinct layers for data access:

1. **Model Layer** (`lib/db/models/`)
   - Abstract `Model<T>` base class that all data models extend
   - Models implement `getValuesMap()` for serialization and `fillFromValues()` for deserialization
   - Models: `Event`, `Setting`

2. **Repository Layer** (`lib/db/repositories/`)
   - Abstract `Repository<T extends Model<T>>` providing generic CRUD operations
   - Direct database interaction via SQLite (`sqflite` package)
   - Implements: `findById()`, `findAll()`, `findBy()`, `create()`, `update()`, `delete()`, `exists()`
   - Concrete implementations: `EventsRepository`, `SettingsRepository`

3. **Service Layer** (`lib/db/services/`)
   - Abstract `Service<T extends Model<T>>` acting as business logic layer
   - Wraps repository operations and adds convenience methods like `setup()` (upsert)
   - Concrete implementations: `EventsService`, `SettingsService`
   - **Important**: Services are the proper entry point for UI components - do not call repositories directly

### Database

- **DatabaseService**: Singleton pattern managing SQLite database initialization
- Database file: `cubelab.db`
- Tables defined in `DatabaseTable` class: `settings`, `events`
- Schema created in `_onCreate()` method

### Routing

- Uses `go_router` package for declarative routing
- Routes defined in `_router` (lib/main.dart):
  - `/` → CalendarPage
  - `/calendar` → CalendarPage
  - `/tasks` → TasksPage
  - `/settings` → SettingsPage

### Theming

- Custom theme system using Flutter's `ThemeExtension<AppTheme>`
- `AppTheme` class defines semantic colors (backgroundColor, iconColor, accentColor, etc.)
- Supports both light and dark themes via `ThemeMode.system`
- Theme accessed via `context.appTheme` extension method
- Custom icon component `HIcon` uses SVG assets with dynamic color mapping based on active/inactive state

### UI Structure

- **Pages** (`lib/pages/`): Top-level screens (Calendar, Tasks, Settings)
- **Components** (`lib/components/`): Reusable UI elements
  - `buttons/`: Navigation and view selection controls
  - `headers/`: Page header components
- **Views** (`lib/pages/views/`): Calendar view implementations (Year, Month, Week)
- Calendar views managed via enum pattern in `CalendarPage`

### Assets

- **Icons**: SVG icons stored in `assets/icons/` directory
- **Fonts**: Custom "Brandon" font family with 5 weights (100-700) from `fonts/` directory
- Icon paths centralized in `lib/theme/icon_path.dart` enum

## Conventions

### File Organization
- Models, repositories, and services for the same entity (e.g., Event) follow parallel structure across their respective directories
- Abstract base classes (`Model`, `Repository`, `Service`) define contracts for concrete implementations

### Database Patterns
- Always use services (not repositories) for data operations in UI code
- Repository queries use parameterized queries for safety
- Models handle their own serialization/deserialization via `getValuesMap()` and `fillFromValues()`

### Theming Patterns
- Access theme colors via `context.appTheme` instead of `Theme.of(context)`
- Use `HIcon` component for all SVG icons to ensure proper theme color integration
- Define semantic color names in `AppTheme` rather than using raw colors

### Code Style
- Uses `flutter_lints` package (see `analysis_options.yaml`)
- Material Design disabled (`uses-material-design: false`)
