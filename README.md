# D2YBank — Enterprise Banking Super App

> Production-grade Flutter base architecture for fintech/banking applications.

## Quick Start

```bash
# 1. Extract the project
tar -xzf d2ybank_project.tar.gz
cd d2ybank

# 2. Download real fonts (placeholder .ttf files included — replace with real ones)
#    Download PlusJakartaSans from Google Fonts: https://fonts.google.com/specimen/Plus+Jakarta+Sans
#    Download DMSans from Google Fonts: https://fonts.google.com/specimen/DM+Sans
#    Place .ttf files in assets/fonts/PlusJakartaSans/ and assets/fonts/DMSans/

# 3. Get dependencies
flutter pub get

# 4. Run the app
flutter run
```

## Architecture Overview

```
lib/
├── app/          # Bootstrap, DI, routing, observers
├── core/         # Config, errors, network, services, database, logging
├── shared/       # D2Y* components, extensions, utils, base classes
└── features/     # Isolated feature modules (Clean Architecture)
```

### Dependency Flow (STRICT)
```
features/ → shared/ → core/ → external packages
REVERSE IS FORBIDDEN
```

## What's Included (83 Dart files)

### Core Layer
- **Config**: Colors, spacing, radius, shadows, durations, text styles, theme (light+dark), breakpoints, icon sizes
- **Network**: Dio ApiClient, logging interceptor, error interceptor, API response wrapper, pagination
- **Services**: SecureStorage, LocalStorage, Connectivity, DeviceInfo, Language
- **Errors**: Sealed Failure hierarchy, typed Exceptions, ErrorHandler (Dio→Failure mapping)
- **Database**: SQLite helper with migration support, BaseDao CRUD
- **Logging**: AppLogger with emoji prefixes, debug-only output

### Shared Layer
- **Components**: D2YButton (4 variants), D2YTextField, D2YPasswordField, D2YLoading, D2YNoData, D2YErrorView, D2YToast, D2YGap
- **Extensions**: BuildContext, String, Number, DateTime, Widget
- **Utils**: CurrencyFormatter (IDR), DateFormatter, NumberFormatter, PhoneFormatter
- **Validators**: Email, Password, composable FormValidators
- **Helpers**: Debouncer, UrlLauncher
- **Converters**: DateTime, BoolInt JSON converters for freezed
- **Base Classes**: BaseEntity, BaseModel, BaseBloc, BaseCubit, BaseState, BaseRepository, BasePage

### App Layer
- **DI**: GetIt injection container with tiered service registration
- **Router**: GoRouter with ShellRoute (bottom nav), named routes, placeholder pages
- **Observers**: BLoC observer, Navigator observer
- **Flavors**: Development/Staging/Production enum
- **Lifecycle**: AppLifecycleHandler

### Features
- **Splash**: Animated splash screen → auto-navigate to home

## Adding a New Feature

```bash
# 1. Create folder structure
mkdir -p lib/features/auth/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{bloc,pages,widgets}}

# 2. Implement following Clean Architecture:
#    domain/entities/     → Pure business objects (extend BaseEntity)
#    domain/repositories/ → Abstract contracts
#    domain/usecases/     → Business logic (extend UseCase)
#    data/models/         → DTOs with freezed (extend BaseModel)
#    data/datasources/    → API calls (extend BaseRemoteDataSource)
#    data/repositories/   → Implementations (extend BaseRepository)
#    presentation/bloc/   → BLoC/Cubit (extend BaseBloc)
#    presentation/pages/  → UI (extend BasePage)

# 3. Register in DI (lib/app/di/injection_container.dart)
# 4. Add routes (lib/app/navigation/app_router.dart)
# 5. Run code generation
dart run build_runner build --delete-conflicting-outputs
```

## Commands

```bash
flutter run                              # Run app
flutter test                             # Run tests
flutter analyze                          # Lint check
dart run build_runner build --delete-conflicting-outputs  # Code gen (freezed)
flutter build apk --release              # Build Android
flutter build ipa --release              # Build iOS
```

## Design System Usage

```dart
// Button
D2YButton(text: 'Transfer', onPressed: () {})
D2YButton.outlined(text: 'Cancel', onPressed: () {})
D2YButton(text: 'Loading...', isLoading: true, onPressed: () {})

// Text Field
D2YTextField(labelText: 'Email', hintText: 'Enter email', onChanged: (v) {})
D2YPasswordField(labelText: 'Password', validator: PasswordValidator.validate)

// Feedback
D2YLoading()
D2YNoData(title: 'Empty', actionLabel: 'Refresh', onAction: () {})
D2YErrorView(message: 'Failed', onRetry: () {})
D2YToast.success(context, 'Transfer berhasil!')

// Spacing
D2YGap.md  // 16px vertical
D2YGap.xl  // 24px vertical

// Extensions
'hello world'.capitalizeWords  // "Hello World"
1500000.toIdr()                // "Rp 1.500.000"
DateTime.now().smart           // "Today"
myWidget.padAll(16)            // Padding
```

## Architecture Documents

For complete implementation details of ALL 160+ files, refer to:
- **Section 1**: Folder structure, config, pubspec, init flow, errors
- **Section 2**: 40 D2Y* UI components
- **Section 3**: 12 services, network layer, database, utilities
- **Section 4**: Base classes, feature template, GoRouter, testing, CI/CD
- **Section 5**: Security, WebSocket, session management, auth feature
