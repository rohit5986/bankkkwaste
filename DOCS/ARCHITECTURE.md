# Architecture & Project Structure

This document explains the high-level architecture, key components, and where to find important code in the repository.

High-level overview

- The app is built with Flutter, using a screens + widgets structure. State is handled by small controller classes and services (see `lib/controllers/` and `lib/services/`).
- Major modules:
  - `lib/screens/` — Screen-level widgets for navigation (Home, Wastec Bank, Wallet, Trending Rates, Track Order)
  - `lib/widgets/` — Reusable UI components (AppBars, category bars, cards)
  - `lib/data/` — Static or in-memory data used by the UI (mocked data for trending rates/orders)
  - `lib/services/` — App services (auth, network adapters)

Important files and responsibilities

- `lib/main.dart` — App entrypoint, theme and route configuration.
- `lib/screens/wastec_bank_screen.dart` — The Wastec Bank hub screen where the category bar and the bottom feature row are located.
- `lib/widgets/profile_wallet_actions.dart` — Shared AppBar actions (wallet & profile buttons) used across screens.
- `lib/data/wastec_bank_data.dart` — Central place for sample data items (trending rates, active orders).

UI notes

- The app uses standard Material widgets with custom `BoxDecoration`, `InkWell` and `GestureDetector` for touch interactions.
- Top feature cards were moved from Home to Wastec Bank and added to `bottomNavigationBar` for consistent placement across screen sizes.

Build & deploy

- CI/CD: Add GitHub Actions or other CI to run `flutter analyze`, `flutter test`, and build artifacts. Use the `build` folder outputs for release artifacts.

Testing

- Unit & widget tests live in `test/` (there's a starter `widget_test.dart`). Add tests for new screens and controllers when introducing features.

Notes about state and data

- The project uses simple controller classes and injected services for auth and data. For scaling, consider using Provider, Riverpod, or Bloc for clearer state separation.

Security

- Keep release keystore and environment secrets out of the repo. Use environment variables, secret stores, or encrypted CI secrets for signing keys.
