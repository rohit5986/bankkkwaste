# API Reference (High-level)

This reference lists important classes, widgets, and screens with short descriptions and example usage.

Screens

- `WastecBankScreen` (`lib/screens/wastec_bank_screen.dart`)
  - Hub screen for Wastec Bank features. Contains category bar and bottom row for Trending, Track Order, Wallet.
  - Example usage (navigation):
```dart
Navigator.push(context, MaterialPageRoute(builder: (_) => WastecBankScreen()));
```

- `Home` / `HomeClean` (`lib/screens/home_clean.dart`)
  - Main home UI. Note: top feature cards were moved into Wastec Bank as requested.

- `TrendingRatesScreen`, `TrackOrderScreen`, `WalletScreen` (`lib/screens/`)
  - Each screen contains details and navigation from the bottom feature row.

Widgets

- `ProfileWalletActions` (`lib/widgets/profile_wallet_actions.dart`)
  - Reusable AppBar actions showing wallet balance and profile button.
  - Example:
```dart
AppBar(
  title: Text('Home'),
  actions: [ProfileWalletActions()],
)
```

- `WastecBankCategoryBar` (`lib/widgets/wastec_bank_category_bar.dart`)
  - Horizontal category bar with tiles to navigate to category details.

- `WastecOrderCard`, `HomeCategoryCard` (`lib/widgets/`)
  - Small card widgets showing order or category information.

Data & Services

- `wastec_bank_data.dart` (`lib/data/`)
  - Provides sample/mock data for rates and orders. For production, replace with a network-backed repository.

- `auth_service.dart` (`lib/services/`)
  - Authentication layer used by screens to check login state and user profile.

Code examples

- Retrieve data and navigate to details:
```dart
final rates = WastecBankData.getTrendingRates();
Navigator.push(context, MaterialPageRoute(builder: (_) => TrendingRatesScreen(rates)));
```

Notes

- For deeper code-level references (methods and properties), explore the files in `lib/` and consider generating API docs with `dartdoc` if you prefer HTML documentation.
