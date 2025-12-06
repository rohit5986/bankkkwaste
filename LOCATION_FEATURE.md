# Location Feature Documentation

## Overview
A comprehensive location management system similar to Zepto's delivery location feature, integrated across the Wastec Bank app.

## Features Implemented

### 1. **Location Header Widget** (`lib/widgets/location_header.dart`)
- Displays current delivery time estimate (5 minutes)
- Shows selected address with dropdown indicator
- Quick access to location picker via tap
- Profile icon for user access
- Compact variant for smaller spaces

### 2. **Select Location Screen** (`lib/screens/select_location_screen.dart`)
- **Search Bar**: Search for addresses with auto-suggestions
- **Current Location**: Detect and use device GPS location
- **Add New Address**: Navigate to address form
- **Request from Friend**: Placeholder for sharing feature (via WhatsApp)
- **Saved Addresses**: Display all saved addresses with:
  - Address label (Home, Work, etc.)
  - Full address details
  - Distance from current location
  - Delete option via popup menu

### 3. **Add Address Screen** (`lib/screens/add_address_screen.dart`)
- **Interactive Map**: Pick location on Google Maps
- **Address Labels**: Home, Work, Hotel, Other (chip selection)
- **Form Fields**:
  - House/Flat/Block No. (required)
  - Apartment/Road/Area
  - Landmark (optional)
  - City (required)
  - State (required)
  - Pincode (required, 6 digits)
- **Auto-fill**: Reverse geocoding fills address from map selection
- **Edit Mode**: Pre-fills existing address data

### 4. **Location Service** (`lib/services/location_service.dart`)
- **Permission Handling**: Request and check location permissions
- **GPS Location**: Get current device position
- **Geocoding**: Convert coordinates to addresses
- **Reverse Geocoding**: Convert addresses to coordinates
- **Distance Calculation**: Calculate km between two coordinates
- **Storage Management**: Save/load/delete addresses via SharedPreferences
- **Address Selection**: Track currently selected address
- **Search**: Mock search implementation (ready for API integration)

### 5. **Saved Address Model** (`lib/models/saved_address.dart`)
- Comprehensive address structure
- JSON serialization/deserialization
- Distance calculation support
- Short and full address formats
- Label-based categorization

## Integration

The location feature is integrated into:
1. **Home Screen** - Shows LocationHeader at top
2. **Waste Bank Screen** - Shows LocationHeader at top
3. **Eco-Friendly Page** - Shows LocationHeader at top

## Dependencies Added
```yaml
geolocator: ^10.1.0          # GPS location
geocoding: ^2.1.1            # Address ↔ Coordinates
shared_preferences: ^2.2.2    # Local storage
permission_handler: ^11.0.1   # Location permissions
```

## Platform Permissions

### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS (`ios/Runner/Info.plist`)
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to provide accurate delivery services...</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>We need your location to provide accurate delivery services...</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>We need your location to provide accurate delivery services...</string>
```

## Usage Flow

### Adding a New Address
1. Tap location header on any page
2. Select "Add New Address"
3. Tap map to select location (or use auto-detect)
4. Form auto-fills from coordinates
5. Choose label (Home/Work/etc.)
6. Fill/verify address details
7. Save address

### Selecting an Address
1. Tap location header
2. Choose from saved addresses OR
3. Use "Current Location" for instant GPS location
4. Selected address appears in header across all pages

### Searching Addresses
1. Tap location header
2. Type in search bar
3. Select from search results
4. Address is set as current location

## Future Enhancements
- **Real Search API**: Integrate Google Places API or similar
- **WhatsApp Integration**: Share/request addresses via WhatsApp
- **Live Tracking**: Real-time delivery tracking
- **Multiple Addresses**: Support multiple delivery addresses per order
- **Address Verification**: Verify addresses with pin codes
- **Favorite Addresses**: Mark frequently used addresses
- **Recent Addresses**: Quick access to recently used locations

## Technical Notes
- All location data stored locally via SharedPreferences
- Distance calculations use Haversine formula
- Map integration via Google Maps Flutter plugin
- Permission handling via permission_handler package
- Async/await pattern for all location operations
- Error handling for permission denials and GPS failures
