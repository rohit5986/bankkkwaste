# Wastec Bank — Full Documentation

Generated: 2025-11-25

This document provides a comprehensive, engineering-grade overview of the `Wastec Bank` Flutter project. It includes the project purpose, architecture, folder-by-folder explanations, detailed file-by-file analysis, data and UI design documentation, diagrams, build/run instructions, and recommended improvements.

---

## 1. Project Overview

- **Project name:** Wastec Bank
- **Location:** `wastec_bank_app/`
- **Description:** An eco-friendly waste collection and scrap recycling Flutter application inspired by marketplace UIs. Users can view live scrap rates, schedule scrap pickups, track orders, and manage a wallet for payments and credits.
- **Primary goals:** Provide a simple, visual-first mobile experience for recycling and scrap trading; enable quick booking and tracking of pickups; provide localized rate information; and manage wallet transactions.

### Key features

- Wastec Bank hub with a Zepto-style category bar (quick tiles).
- Trending rates for recyclable materials with highlights.
- Order tracking with timeline and progress UI.
- Wallet with balance and monthly earnings.
- Sell-scrap / dealer marketplace scaffold.
- Consistent AppBar actions (profile & wallet) available across main screens.

---

## 2. Architecture Documentation

### Summary

- **Framework:** Flutter (Dart)
- **UI style:** Material 3 with custom theme tokens in `lib/config/theme.dart`.
- **Routing:** Imperative routing using `Navigator.of(context).push(MaterialPageRoute(...))` throughout the codebase.
- **State management:** Local widget state (StatefulWidget). `provider` is declared in `pubspec.yaml` and can be adopted for global state. Several placeholder files (controllers/services) indicate a planned separation of concerns.
- **Data:** Current implementation uses static/mock data in `lib/data/wastec_bank_data.dart`. Replaceable by remote services.

### High-level text diagram

```
[Platform (Android/iOS/Web/Desktop)]
           ↓
     Flutter Engine / Framework
           ↓
     Material Widgets + Theme (lib/config/theme.dart)
           ↓
   Screens (lib/screens/*) ←→ Widgets (lib/widgets/*)
           ↓
    Local Data (lib/data/*) and Services (lib/services/*)
           ↓
    External APIs / Backend (Firebase / Razorpay / Dealers API)
```

### Screen flow

- Launch → Splash (placeholder) → Home (`HomeScreen`)
  - Home → Eco page
  - Home → Wastec Bank (hub)
  - Home → Sell Scrap
  - Global AppBar actions → Profile / Wallet

### Navigation structure

- Uses inline `MaterialPageRoute` pushes. No named-route router or deeplink configuration present. For maintainability, consider `go_router` or a centralized named-route map.

---

## 3. Folder-by-Folder Explanation

Below is a concise explanation of each top-level folder and how the app uses it.

- `android/` — Native Android project (Gradle configs, manifest, native glue). Used during Android build steps. Edit for native permissions, Google Play signing, or platform channels.

- `ios/` — Native iOS project (Xcode runner, `AppDelegate`, workspace). Used for iOS builds and Apple-specific configuration.

- `linux/`, `macos/`, `windows/` — Desktop runner scaffolding. Contains platform-specific build scripts and runner code. Useful for desktop builds.

- `web/` — Static assets used by Flutter web builds (`index.html`, `manifest.json`, icons). Use `flutter build web` to produce deployable assets.

- `lib/` — Main application code. This is where app logic, UI, and data live.
  - `config/` — Theme and global configuration (`theme.dart`). Centralizes colors, typography, button styles, gradients.
  - `data/` — Static/mock data (`wastec_bank_data.dart`). Currently the primary source for rates, orders, and wallet mock values.
  - `models/` — Domain models (presently empty placeholder `user_profile.dart`). Replace `Map` usages with typed models here.
  - `controllers/` — Business logic controllers (placeholder `auth_controller.dart` for auth state and orchestration).
  - `services/` — External integrations & API clients (placeholder `auth_service.dart`, payment services, rate-fetching service).
  - `screens/` — Full-screen widgets that compose the user experience (home, waste bank, wallet, trending, track order, sell scrap, profile, etc.).
  - `widgets/` — Reusable UI components (category bar, cards, order widget, AppBar actions).
  - `utils/` — Utility helpers and validators (placeholder `validators.dart`).

- `build/` — Generated compilation outputs and plugin intermediates. Should be excluded from source control. Contains `flutter_assets` and built APK/APP bundles during build commands.

- `DOCS/` — Project documentation, design notes, and guides. Contains `ARCHITECTURE.md`, `INSTALLATION.md`, `DEVELOPMENT.md`, etc.

- `test/` — Unit and widget tests. Only a sample `widget_test.dart` present.

---

## 4. Detailed Code Explanation (File-level)

Below are detailed explanations for the major files you requested. Each section explains: purpose, logic, UI construction, navigation, and key classes/methods.

### `lib/main.dart`

- Purpose: Application entry point. Registers the root widget and theme.
- Logic: Simple `runApp(const WastecBankApp());` with `MaterialApp` using `WastecTheme.lightTheme` and `home: const HomeScreen()`.
- Navigation & UI: Bootstraps widget tree and global theme. No Firebase initialization present — if using Firebase, `WidgetsFlutterBinding.ensureInitialized()` and `Firebase.initializeApp()` are required.

Snippet:

```dart
void main() {
  runApp(const WastecBankApp());
}

class WastecBankApp extends StatelessWidget { ... }
```

### `lib/config/theme.dart`

- Purpose: Centralized styling tokens (colors, gradients, text theme) and `ThemeData`.
- Logic: Declares `WastecColors` color constants and `WastecTheme.lightTheme` that configures `ThemeData` (Material 3, textTheme, cardTheme, button themes, input decorations, chip theme, bottom nav, snackbars).
- UI: Ensures consistent spacing, radii, and color tokens across widgets. Use `WastecTheme.lightTheme` in `MaterialApp`.

Important tokens to reference in code: `WastecColors.primaryGreen`, `heroGradient`, `vibrantMarketplaceGradient`, `mutedCardGradient`.

### `lib/screens/home_clean.dart`

- Purpose: Main app home with bottom navigation and hero banners for Eco and Wastec Bank.
- Logic: `HomeScreen` is a `StatefulWidget` that holds `_currentIndex` for tab selection. `_getBody()` returns content for each tab.
- UI: `Scaffold` with `AppBar` (title varies by selected tab) and `BottomNavigationBar`. `_HomeTab` contains hero banners implemented as `_HeroBanner` widgets — tap navigates using `Navigator.of(context).push(MaterialPageRoute(...))`.

Key Widget: `_HeroBanner` is a reusable inkable Material card with gradient, icon, title, subtitle, and a CTA button. The button and the card tap use the same navigation handler.

### `lib/screens/wastec_bank_screen.dart`

- Purpose: The Wastec Bank hub — categories, trending rates, orders, and pinned quick-actions.
- Logic:
  - Reads mock data from `WastecBankData`.
  - Applies an explicit bottom padding to avoid content being overlapped by the bottom quick-action bar:

```dart
final bottomSafe = MediaQuery.of(context).padding.bottom;
final bodyBottomPadding = bottomSafe + kBottomNavigationBarHeight + 12.0;
```

  - Uses `SingleChildScrollView` for the screen content and `bottomNavigationBar` for pinned quick actions.
- UI: Composed of `WastecBankCategoryBar`, highlight card (top rate), trending rates list (`_buildTrendingRates()`), and an orders list (`_buildOrdersList()`) which uses `WastecOrderCard`.
- Navigation: Tiles and pinned quick actions navigate to `TrendingRatesScreen`, `TrackOrderScreen`, and `WalletScreen` via `Navigator.push`.

### `lib/widgets/wastec_bank_category_bar.dart`

- Purpose: Zepto-like quick category tiles. Provides responsive layout and tactile press animation.
- Logic:
  - `_categories` list defines the tiles and destination builders.
  - `LayoutBuilder` chooses `Wrap` layout for wide screens (>=640px) or a horizontal scroll list for smaller screens.
  - `_WastecCategoryTile` handles `onTap` with an `AnimatedScale` press effect.
- UI: Each tile has a colored circular badge, white inner card, and bold label. Colors and icon tints are taken from `WastecColors`.
- Navigation: Each tile uses a `destinationBuilder` to push a route.

### `lib/widgets/wastec_order_card.dart`

- Purpose: Visual representation of a pickup order, including status, ETA, driver, route stops, progress, and timeline.
- Logic: The widget expects a `Map<String, dynamic>` with fields like `id`, `status`, `eta`, `lastUpdate`, `pickup`, `drop`, `agent`, `vehicle`, `contact`, `stage`, and `timeline`.
- UI: Structured columns: header row with icon and meta, info chips (weight, payment), route stops block, driver card, delivery progress, and a timeline showing timestamps per stage.

Important: Converting `Map` objects to typed `Order` models will increase maintainability and type-safety.

### `lib/widgets/home_category_card.dart`

- Purpose: Reusable card style for category tiles / CTAs.
- Logic: Takes `title`, `subtitle`, `icon`, `onTap`, and optional gradient / icon background. Uses `Material` + `InkWell` for ripple.
- UI: Circular icon badge, title, and subtitle with gradient background. Designed for use in grid or list contexts.

### `lib/widgets/profile_wallet_actions.dart`

- Purpose: Centralized AppBar action widgets. Provides consistent navigation to Profile and Wallet screens.
- Logic: Stateless `Row` containing two `IconButton`s. On press, pushes `WalletScreen` or `ProfileScreen`.

### `lib/widgets/wallet_tab.dart` and `lib/screens/wallet_screen.dart`

- Purpose: Wallet UI surfaces. `WalletTab` is used in bottom navigation; `WalletScreen` is a full-screen wallet page.
- Logic/UI: Displays `WastecBankData.walletBalance` and monthly earnings. Intended to support top-up, withdraw, and transaction history.

### `lib/screens/trending_rates_screen.dart`

- Purpose: Displays `WastecBankData.trendingRates` in a list/grid.
- Logic: Simple builder pattern iterating the `trendingRates` list and rendering cards with `name`, `price`, and icons.

### `lib/screens/track_order_screen.dart`

- Purpose: Track orders with a timeline and progress widget.
- Logic/UI: Uses `WastecOrderCard` instances for user's orders and shows stage/timestamps.

### `lib/screens/eco_friendly_page.dart` and `lib/screens/sell_scrap_screen.dart`

- Purpose: Informational and marketplace flows respectively. `eco_friendly_page.dart` is an educational landing; `sell_scrap_screen.dart` is a listing/ordering marketplace screen.

### `lib/screens/profile_screen.dart`

- Purpose: User profile & settings. Reachable via `ProfileWalletActions`.
- UI: Editable profile fields, summary stats, and logout action.

---

## 5. Authentication Module Documentation

Although the following files are present but empty, they form the expected architecture for authentication. Below are concise responsibilities and recommended designs.

- `lib/services/auth_service.dart` (expected)
  - Responsibility: Low-level authentication operations (sign-in, register, sign out, password reset, email verification). Should wrap the underlying authentication provider (Firebase Auth or custom backend).
  - Recommended API:

```dart
class AuthService {
  // Example using Firebase
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmail(String email, String password) async { ... }
  Future<User?> registerWithEmail(String email, String password) async { ... }
  Future<void> signOut() async { ... }
  Future<void> sendPasswordReset(String email) async { ... }
  Stream<User?> authStateChanges() => _auth.authStateChanges();
}
```

- `lib/controllers/auth_controller.dart` (expected)
  - Responsibility: High-level orchestration, bridging UI forms and `AuthService`. Should handle loading state, errors, and navigation post-auth. Implement as `ChangeNotifier` (Provider) or as a `StateNotifier` (Riverpod).

- `lib/screens/auth/login_screen.dart`, `register_screen.dart`, `forgot_password_screen.dart`, `email_verification_screen.dart` (expected)
  - Responsibility: UI forms + validation. Use `Form` and `TextFormField` with validators from `utils/validators.dart`. Call controller methods for actions and show success/errors.

- `lib/screens/auth/auth_gate.dart` (expected)
  - Responsibility: High-level gate that decides which initial screen to show depending on the auth state. Should listen to `AuthService.authStateChanges()` and return either `HomeScreen` or the appropriate auth flow.

Security recommendations

- Use secure storage for tokens where necessary. Avoid storing secrets inside the repo.
- Implement server-side validation and role-based rules for any backend (Firestore/REST API).

---

## 6. Data Layer Documentation

**`lib/data/wastec_bank_data.dart`**

- Structure: static lists and constants used by UI:
  - `trendingRates`: List<Map> — each object includes `name`, `price`, and `icon`.
  - `orders`: List<Map> — each order contains fields (`id`, `status`, `eta`, `timeline`, etc.).
  - `walletBalance`, `walletMonthlyEarning`: strings representing the wallet data.

- Loading: currently synchronous static in-memory data. Screens import and use the lists directly.

- How to evolve:
  - Create typed models (`Rate`, `Order`, `Wallet`) and JSON serialization methods.
  - Create `RatesService` and `OrdersService` that fetch from backend endpoints, with caching and error handling.

Example data consumption:

```dart
final topRate = WastecBankData.trendingRates.first;
// used to build highlight card in WastecBankScreen
```

---

## 7. UI/UX Documentation

### Design system tokens (from `theme.dart`)

- Colors: `primaryGreen` (#0A8C4A), `lightGreen`, `darkGreen`, `accentAmber` (#FF8C32), `accentCoral`, neutrals (white, mistGray, mediumGray, darkGray).
- Typography: `headlineLarge` 32/`w800`, `titleLarge` 20/`w700`, `bodyLarge` 16/`w500`, `labelLarge` 14/`w600`.
- Gradients: `heroGradient`, `vibrantMarketplaceGradient`, `mutedCardGradient`.

### Components & styles

- Cards: Rounded corners (12–20px), shadow depth 6–12, white inner cards, outer colored backgrounds for emphasis.
- Buttons: Primary elevated buttons with `primaryGreen`, rounded shape (30px). Outlined secondary actions use green border.
- Navigation: Bottom navigation with white background, green selected icon color, tiny icon size variance between selected/unselected.
- Animations: Subtle scale on tile press (`AnimatedScale`), InkWell ripples. Consider adding route transitions or SharedElement animations for richer UX.

---

## 8. Flow Diagrams (ASCII)

### App navigation flow

```
[Launch]
  ↓
[HomeScreen]
  ├─ Eco → [EcoFriendlyPage]
  ├─ Waste Bank → [WastecBankScreen]
  │    ├─ Trending Rates → [TrendingRatesScreen]
  │    ├─ Track Order → [TrackOrderScreen]
  │    └─ Wallet → [WalletScreen]
  ├─ Sell Scrap → [SellScrapScreen]
  └─ Bottom Nav Wallet → [WalletTab]
```

### Data flow

```
[UI widgets] ↔ [Screens / Controllers] ↔ [Services] ↔ [Remote APIs / Firebase]
                          ↘︎
                          [Local cache (SharedPreferences/Hive)]
```

### User journey (Home → Wastec Bank → Trending Rates → Track Orders → Wallet)

```
User opens app
  ↓ (tap hero)
Open Wastec Bank
  ↓ (tap category)
Open Trending Rates
  ↓ (tap bottom action)
Open Track Orders
  ↓ (tap wallet icon)
Open Wallet
```

---

## 9. How to Build & Run

### Environment

- Dart SDK: `>=3.0.0 <4.0.0` (use a Flutter stable channel that uses Dart >= 3).
- Flutter: Use the stable channel (Flutter 3.x+ or newer that supports Dart 3). Verify with `flutter --version`.

### Commands (PowerShell)

Install dependencies:

```powershell
Set-Location 'C:\Wastec Bank\wastec_bank_app'
flutter pub get
```

Run on a connected device:

```powershell
flutter run -d <device-id>
```

Build release APK (recommended to sign for Play Store):

```powershell
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

Build Android App Bundle (Play Store):

```powershell
flutter build appbundle --release
```

Build web:

```powershell
flutter build web
```

Run tests:

```powershell
flutter test
```

### Firebase setup (high level)

1. Create project in Firebase console.
2. Add Android app: supply package name, download `google-services.json`, place in `android/app/`.
3. Add iOS app: download `GoogleService-Info.plist` and add to `ios/Runner/`.
4. Add Firebase Flutter packages (`firebase_core`, `firebase_auth`, etc.) and call `await Firebase.initializeApp()` in `main()`.
5. Configure platform Gradle and iOS entitlements per plugin docs.

### Signing and Play Store

1. Generate a keystore.
2. Add signing config to `android/key.properties` and `android/app/build.gradle`.
3. Build app bundle and upload to Play Console.

---

## 10. Suggested Improvements

### Architecture & code quality

- Adopt typed data models for `Order`, `Rate`, and `Wallet` instead of `Map<String, dynamic>`.
- Introduce global state management: `Provider` (simple), `Riverpod` (recommended for testability), or `BLoC` for larger apps.
- Centralize navigation using `go_router` or a named-route map.
- Add strong typing and DTO conversion for network payloads using `freezed` + `json_serializable`.

### Features to add

- Real-time rate updates (WebSocket or Firebase Realtime DB).
- Push notifications (FCM) for order updates.
- Map-based driver tracking with polylines and live location updates.
- In-app payments & order checkout flows with Razorpay integration completed.
- Transaction history and wallet withdrawal flows.

### Testing & automation

- Add widget tests for `WastecOrderCard`, `WastecBankCategoryBar`, and `WastecBankScreen`.
- Add CI (GitHub Actions) to run `flutter analyze`, `flutter test`, and build validation on PRs.

### Security & operations

- Enforce secure backend rules for any Firestore/Realtime DB.
- Do not commit secrets to the repo; use environment variables or secret manager.

---

## Appendix: Useful Snippets & Templates

### `Order` model template

```dart
class Order {
  final String id;
  final String status;
  final String eta;
  final String lastUpdate;
  final String pickup;
  final String drop;
  final String agent;
  final int stage;
  final List<String?> timeline;

  Order({ ... });

  factory Order.fromJson(Map<String, dynamic> json) => Order(...);
}
```

### `AuthService` skeleton

```dart
class AuthService {
  // Use FirebaseAuth or a custom API client
  Future<User?> signIn(String email, String password) async { ... }
  Future<User?> register(String email, String password) async { ... }
  Future<void> signOut() async { ... }
  Stream<User?> authStateChanges() => _auth.authStateChanges();
}
```

---

## Deliverables & Next Steps

I created this consolidated engineering documentation for your repo. I can now:

- Commit and push this file to `DOCS/FULL_DOCUMENTATION.md` (I'll do that now if you confirmed).
- Create a `docs/full-dump` branch and open a PR instead if you'd prefer a review-first workflow.
- Convert this to `.docx` using `pandoc` locally if `pandoc` is installed.

Reply `done` to have me commit & push this file to `main` now, or `pr` to create a PR instead, or `export docx` to prepare conversion instructions.

---

End of documentation.
