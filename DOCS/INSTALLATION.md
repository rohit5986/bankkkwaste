# Installation & Quick Start

This section explains how to set up the development environment, run the app locally (web and Android), and build production APKs.

Prerequisites

- Flutter SDK (stable channel recommended)
- Android SDK + platform-tools (`adb`)
- A device (USB) or emulator for Android testing
- (Optional) Git & GitHub for source control

Quick checks

```powershell
flutter --version
adb --version
git --version   # optional
```

Set up

1. Clone the repository (or copy files into a local folder):

```powershell
git clone https://github.com/<youruser>/<repo>.git
cd "C:\Wastec Bank\wastec_bank_app"
```

2. Install dependencies:

```powershell
flutter pub get
```

3. Run on Chrome (web):

```powershell
flutter run -d chrome
```

4. Run on a connected Android device:

```powershell
# list devices
flutter devices
# run on the device id shown
flutter run -d <device-id>
```

Build release APK

```powershell
# create a release APK
flutter build apk --release
# output path:
# build\app\outputs\flutter-apk\app-release.apk
```

Install the release APK on a connected device

```powershell
# install release apk
flutter install --release
# or using adb directly:
adb install -r build\app\outputs\flutter-apk\app-release.apk
```

If you need to serve the `builds/` folder on your local network for a device to download the APK, use Python or a simple HTTP server (see `APK_SHARING.md` in project root).
