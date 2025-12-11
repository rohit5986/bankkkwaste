# Wastec Bank App - Complete Codebase Analysis

## 🎯 Project Overview

**Wastec Bank** is a Flutter-based mobile application designed for eco-friendly waste management and scrap recycling. It combines marketplace functionality (like Swiggy) with environmental sustainability, allowing users to track waste pickups, earn money from recycling, and shop eco-friendly products.

### Key Features:
- Waste Bank: Sell scrap materials and track earnings
- Eco-Friendly Store: Purchase sustainable living products
- Track Orders: Monitor real-time waste pickup status
- Wallet: Manage credits and payments
- Trending Rates: View current scrap material prices
- User Profile & Location Management

---

## 📱 App Architecture

### **Technology Stack**
- **Framework:** Flutter 3.38.3+ (Dart 3.0+)
- **State Management:** Provider (v6.0.0)
- **UI/Design:** Material Design 3, Google Fonts
- **Location Services:** Google Maps Flutter, Geolocator, Geocoding
- **Payment:** Razorpay Flutter
- **Storage:** SharedPreferences
- **Networking:** HTTP, Cached Network Image
- **Permissions:** Permission Handler

### **Project Structure**

```
lib/
├── main.dart                    # App entry point
├── config/
│   └── theme.dart              # Theme colors and styling
├── screens/                      # Screen pages
│   ├── home_clean.dart          # Main app shell (4-tab navigation)
│   ├── track_order_screen.dart  # Track waste pickups
│   ├── wastec_bank_screen.dart  # Scrap materials marketplace
│   ├── eco_friendly_page.dart   # Eco products store
│   ├── wallet_screen.dart       # Wallet/payment management
│   ├── profile_screen.dart      # User profile
│   └── [other screens]
├── widgets/                      # Reusable components
│   ├── wallet_tab.dart          # Wallet UI component
│   ├── category_tabs.dart       # Category navigation tabs
│   ├── home_category_card.dart  # Hero card components
│   ├── location_header.dart     # Location display
│   ├── wastec_order_card.dart   # Order tracking cards
│   └── [other widgets]
├── models/                       # Data models
│   ├── user_profile.dart
│   └── saved_address.dart
├── data/                         # Static/mock data
│   └── wastec_bank_data.dart    # Trending rates, orders
├── services/                     # Business logic & APIs
└── utils/                        # Helpers & utilities
```

---

## 🎨 Design System

### **Color Palette** (`config/theme.dart`)

| Color | Hex Code | Usage |
|-------|----------|-------|
| Primary Green | #0A8C4A | Brand primary, buttons, accents |
| Light Green | #E4F5EA | Light backgrounds |
| Dark Green | #05472A | Dark elements |
| Accent Amber | #FF8C32 | Marketplace highlights |
| Accent Coral | #FF7043 | Secondary highlights |
| Accent Teal | #1FB6A6 | Tertiary accents |
| White | #FFFFFF | Base surfaces |
| Mist Gray | #F3F5F7 | Light backgrounds |
| Medium Gray | #8A8F94 | Secondary text |
| Dark Gray | #282C34 | Primary text |

### **Gradients**
- **Hero Gradient:** Green → Teal
- **Vibrant Marketplace:** Amber → Coral
- **Muted Card:** Light Green variations

---

## 🏠 Main Navigation Structure

### **HomeScreen** (`screens/home_clean.dart`)
Acts as the main app shell with **bottom navigation (4 tabs)**:

```
Tab Index | Tab Name        | Source Screen | Contextual NavBar
----------|-----------------|---------------|------------------
0         | Home            | _HomeTab      | Standard (all 4 tabs)
1         | Be Eco-Friendly | EcoFriendlyPage | Contextual (Home → Eco → Track → Wallet)
2         | Waste Bank      | WastecBankScreen | Contextual (Home → WasteBank → Track → Wallet)
3         | Wallet          | WalletTab     | Standard (all 4 tabs)
```

### **Navigation Architecture**

#### **From Home Tab (_HomeTab)**
- Two hero cards: "Be Eco-Friendly" and "Waste Bank"
- Tapping either:
  - Sets `_currentIndex` to 1 (Eco) or 2 (Waste Bank)
  - Shows contextual navbar for that tab

#### **From Eco-Friendly Tab**
- Contextual navbar items:
  - **Home:** Sets `_currentIndex = 0`
  - **Eco-Friendly:** Stays on tab (index 1)
  - **Track Order:** Pushes `TrackOrderScreen(source: TrackOrderSource.ecoFriendly)`
  - **Wallet:** Sets `_currentIndex = 3`

#### **From Waste Bank Tab**
- Contextual navbar items:
  - **Home:** Sets `_currentIndex = 0`
  - **Waste Bank:** Stays on tab (index 2)
  - **Track Order:** Pushes `TrackOrderScreen(source: TrackOrderSource.wasteBank)`
  - **Wallet:** Sets `_currentIndex = 3`

---

## 📦 Screen Details

### **1. HomeScreen** (`home_clean.dart`)
**Purpose:** Main app container with 4-tab navigation

**Components:**
- AppBar: Dynamic title based on selected tab
- Profile/Wallet action buttons
- Body: Switches between 4 different content areas
- Bottom Navigation: Standard 4-tab navbar + contextual navbars

**Tab Contents:**
- **Tab 0 (_HomeTab):** Location header + two hero banner cards
- **Tab 1 (Eco-Friendly):** EcoFriendlyPage widget
- **Tab 2 (Waste Bank):** WastecBankScreen widget
- **Tab 3 (Wallet):** WalletTab widget

---

### **2. TrackOrderScreen** (`track_order_screen.dart`)
**Purpose:** Display real-time waste pickup tracking

**Features:**
- Shows active pickups in progress
- Displays order cards with:
  - Order ID, status, ETA
  - Driver details, vehicle info
  - Contact information
  - Timeline of pickup stages

**Navigation (Source-Aware):**
```dart
enum TrackOrderSource { wasteBank, ecoFriendly }
```

**Navbar Behavior:**
- **If source == wasteBank:**
  - Shows: Home → WasteBank → TrackOrder → Wallet
  - Home: `pushReplacement` to HomeScreen
  - WasteBank: `pop()` back to previous screen
  - Wallet: `pop()` back (reverted from pushReplacement)

- **If source == ecoFriendly:**
  - Shows: Home → EcoFriendly → TrackOrder → Wallet
  - Home: `pushReplacement` to HomeScreen
  - EcoFriendly: `pop()` back
  - Wallet: `pop()` back

---

### **3. WastecBankScreen** (`wastec_bank_screen.dart`)
**Purpose:** Main scrap materials marketplace

**Sections:**
1. **Quick Access Row:** Navigation to Eco-Friendly
2. **Trending Rates:** Current market prices for:
   - Paper, Plastic, Metal, E-Waste
   - Newspaper, Hard Plastic, AC units, Iron
3. **Material Categories:** Organized by type
4. **Seller Services:** Information for scrap sellers
5. **Bottom Padding:** Ensures content isn't hidden by navbar

**Data Source:** `WastecBankData.trendingRates`

---

### **4. EcoFriendlyPage** (`eco_friendly_page.dart`)
**Purpose:** Sustainable products store and eco tips

**Sections:**
1. **Eco Tips:** 4 sustainability tips with icons:
   - Home composting with cocopeat
   - Biodegradable garbage bags
   - Zero-waste edible plates
   - Organic plant growing

2. **Eco Products:** 10+ sustainable products:
   - Cocopeat blocks, composts
   - Biodegradable bags, edible plates
   - Bamboo toothbrushes, recycled planters
   - Bio enzyme cleaners, cloth bags

Each product shows:
- Name, price, category tag, icon
- Quantity/packaging information

---

### **5. WalletTab** (`widgets/wallet_tab.dart`)
**Purpose:** Payment & wallet management

**Sections:**
1. **Balance Card:** Current wallet balance display
2. **Quick Actions:**
   - Add Money
   - Send Money
   - Withdraw
   - Rewards

3. **Wallet Services:**
   - Transaction History
   - Linked Accounts
   - Wallet Security
   - Help & Support

---

## 🧩 Key Widgets

### **CategoryTabs** (`widgets/category_tabs.dart`)
**Purpose:** Horizontal scrollable category navigation

**Features:**
- 4 category tabs (Waste Bank, Trending Rates, Scrap Categories, Eco-Friendly)
- Each has:
  - Custom color scheme (pastel background)
  - Icon in colored circle
  - Title with optional subtitle
  - Press animation (scale 0.97)
  - Navigation to respective screens

**Code Structure:**
```dart
_CategoryTabConfig { title, icon, pastelColor, textColor, accentColor, destinationBuilder }
_CategoryTabTile extends StatefulWidget { _isPressed, _handleTap() }
```

---

### **WastecOrderCard** (`widgets/wastec_order_card.dart`)
**Purpose:** Display individual order tracking information

**Shows:**
- Order ID, status, ETA
- Last update timestamp
- Date, payment method, weight
- Notes about materials
- Pickup & drop-off locations
- Driver & vehicle details
- Contact information
- Visual stage indicator

---

### **LocationHeader** (`widgets/location_header.dart`)
**Purpose:** Display user's current location

**Features:**
- Current location display
- Change location option
- Location-based services

---

### **HomeCategoryCard** (`widgets/home_category_card.dart`)
**Purpose:** Hero banner cards on home tab

**Features:**
- Gradient backgrounds
- Large icon display
- Title & subtitle text
- On-tap navigation
- Customizable styling

---

## 📊 Data Structure

### **Orders** (`data/wastec_bank_data.dart`)
```dart
Map<String, dynamic> {
  id: String                    // Order ID
  status: String                // Current status
  eta: String                   // Estimated arrival
  lastUpdate: String            // Last update time
  date: String                  // Order date
  payment: String               // Payment method & amount
  weight: String                // Total weight
  notes: String                 // Material notes
  pickup: String                // Pickup location
  drop: String                  // Drop-off location
  agent: String                 // Driver name
  vehicle: String               // Vehicle details
  contact: String               // Driver contact
  icon: IconData                // Status icon
  color: Color                  // Status color
  stage: int (0-5)              // Completion stage
  timeline: List<String?>       // Pickup timeline
}
```

### **Trending Rates**
```dart
Map<String, dynamic> {
  name: String                  // Material name
  price: String                 // Current price
  icon: IconData                // Material icon
}
```

---

## 🔄 Navigation Flow

### **Complete App Flow Diagram**

```
┌─────────────────┐
│   HomeScreen    │ (Main App Shell)
└────────┬────────┘
         │
    ┌────┴─────┬──────────┬──────────┐
    │           │          │          │
Tab 0        Tab 1       Tab 2       Tab 3
(Home)   (EcoFriendly) (WasteBank) (Wallet)
    │           │          │          │
    │      ┌────▼────┐     │          │
    │      │ Contextual NavBar       │
    │      │ (4 items)      │        │
    │      │ Home|Eco|Track|Wallet   │
    │      │         │     │         │
    │      │    ┌────▼─────┴─────┐   │
    │      └───▶│ TrackOrderScreen│   │
    │           │ source=ecoFriendly   │
    │           └────────┬────────┘   │
    │                    │             │
    └────────────────────┼─────────────┘
                         │
                    ┌────▼─────┐
                    │ Navbar    │
                    │ (2 modes) │
                    └──────────┘
```

### **Navbar Behaviors**

**Standard Navbar (Home & Wallet tabs):**
- All 4 tabs visible
- Tap navigates to index

**Contextual NavBar (Eco & Waste Bank tabs):**
- 4 items specific to current context
- Home button: `pushReplacement` to HomeScreen
- Context button (Eco/WasteBank): stays on tab
- Track Order: `push` with source parameter
- Wallet: `setState` to navigate

**TrackOrderScreen NavBar:**
- Depends on `TrackOrderSource` (wasteBank or ecoFriendly)
- Home: Independent navigation to HomeScreen
- Back button: `pop()` to previous context
- Wallet: Currently pops (behavior pending fix)

---

## 🎯 Current Implementation Status

### ✅ Completed Features
1. 4-tab main navigation in HomeScreen
2. Contextual navbars for Eco-Friendly and Waste Bank tabs
3. TrackOrderScreen with source-aware navigation
4. Order tracking display with timeline
5. Eco-Friendly tips and products listing
6. Waste Bank marketplace with trending rates
7. Wallet management UI
8. Theme system with color palette

### 🔧 In Progress
1. **Home button in TrackOrderScreen:** Recently updated to use `pushReplacement` for independent navigation ✅
2. **Wallet button in TrackOrderScreen:** Needs fix - currently using pop() instead of independent navigation

### 🐛 Known Issues
1. Wallet button in TrackOrderScreen doesn't navigate independently (reverted to pop behavior)
2. Duplicate AppBar issue when navigating (resolved by removing nested Scaffolds)

---

## 📋 File Dependencies

### **Import Graph**

```
main.dart
├─→ home_clean.dart
│   ├─→ track_order_screen.dart
│   ├─→ eco_friendly_page.dart
│   ├─→ wastec_bank_screen.dart
│   ├─→ wallet_tab.dart
│   └─→ location_header.dart

track_order_screen.dart
├─→ wastec_bank_data.dart
├─→ wastec_order_card.dart
└─→ home_clean.dart

category_tabs.dart
├─→ wastec_bank_screen.dart
├─→ eco_friendly_page.dart
├─→ trending_rates_screen.dart
└─→ scrap_categories_screen.dart

eco_friendly_page.dart
└─→ wastec_bank_screen.dart

wastec_bank_screen.dart
└─→ eco_friendly_page.dart
```

---

## 🎓 Key Programming Patterns

### **1. Widget Composition**
- StatelessWidget for pure UI
- StatefulWidget for screens with navigation state
- Separation of concerns (screens vs widgets)

### **2. Navigation Patterns**
- `Navigator.push()` for new routes
- `Navigator.pushReplacement()` for independent navigation
- `Navigator.pop()` for returning to previous screen
- `setState()` for tab switching

### **3. Data Binding**
- Static data in `WastecBankData`
- Maps for flexible data structures
- Hardcoded sample data for MVP

### **4. UI Patterns**
- Hero cards with gradients
- Contextual bottom navbars
- Custom styled cards
- Color-coded status indicators

---

## 🚀 Extension Points

### **Easy to Add:**
1. Real API integration (replace static data)
2. Firebase authentication
3. Payment gateway integration (Razorpay already imported)
4. Real-time location tracking
5. Push notifications
6. User preferences & dark mode

### **Requires Refactoring:**
1. State management (migrate to Provider properly)
2. Route management (consider GoRouter)
3. Data fetching (implement proper services layer)
4. Error handling & logging

---

## 📝 Notes for Developers

1. **Theme System:** All colors centralized in `config/theme.dart` - maintain consistency
2. **Navigation Context:** Remember to pass `TrackOrderSource` when navigating to TrackOrderScreen
3. **Bottom Padding:** WastecBankScreen has special padding logic to accommodate navbar
4. **Responsive Design:** Uses flexible/expanded widgets for different screen sizes
5. **Icons:** Uses Material icons throughout (Icons.xxx)

---

## 🔍 Summary

The **Wastec Bank app** is a well-structured Flutter application with:
- Clean separation of screens, widgets, and data
- Smart contextual navigation based on user context
- Consistent design system and color palette
- MVP-ready structure with sample data
- Ready for integration with real APIs and services

The navigation architecture cleverly uses a main HomeScreen container with conditional navbars that adapt based on the current tab, providing context-aware navigation while maintaining a single source of truth for the app state.

