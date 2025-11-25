# APK Sharing Guide

**Purpose:** Short, practical instructions for copying the release APK to an Android phone and sharing it (for example via WhatsApp). This guide covers manual USB (MTP), `adb` push, `flutter install`, serving locally, and extracting the APK from an installed app.

**Where the built APK is located (project paths):**

- Primary build output (Flutter): `build\app\outputs\flutter-apk\app-release.apk`
- Packaged copy used during this session: `builds\WastecBank-app-release.apk`

**Important:** The instructions below assume you're on Windows (PowerShell). Adjust paths if your project root differs.

**Option A — Manual USB (recommended, simplest)**

1. Connect your phone with USB cable.
2. On the phone choose **File transfer / MTP** (sometimes shown as "Transfer files").
3. On the PC open File Explorer and go to the builds folder:

```powershell
explorer 'C:\Wastec Bank\wastec_bank_app\builds'
```

4. Drag or copy `WastecBank-app-release.apk` into your phone's `Internal storage\Download` folder.
5. On the phone open Files (or Downloads) → long-press the APK → Share → WhatsApp → choose contact and send. Select "Document" in WhatsApp to keep the APK file intact.


**Option B — Using adb (push file to Downloads)**

1. Make sure `adb` is installed and available. Check from PowerShell:

```powershell
where.exe adb
```

If `where.exe` returns a path, `adb` is available. If not, locate `adb.exe` inside your Android SDK `platform-tools` folder or Flutter cache (example paths):

- Android SDK: `C:\Users\<you>\AppData\Local\Android\sdk\platform-tools\adb.exe`
- Flutter cache candidate: `C:\path\to\flutter\bin\cache\artifacts\platform-tools\adb.exe`

2. Verify device is connected:

```powershell
adb devices
```

You should see your device id listed and `device` status.

3. Push the APK to the phone's Download folder:

```powershell
adb push "C:\Wastec Bank\wastec_bank_app\builds\WastecBank-app-release.apk" /sdcard/Download/
```

4. On the phone open Files → Downloads and share the APK via WhatsApp (as Document).


**Option C — Install directly with adb or flutter**

- Install with adb (useful for testing if you want the phone to run the APK immediately):

```powershell
adb install -r "C:\Wastec Bank\wastec_bank_app\builds\WastecBank-app-release.apk"
```

- Or use Flutter (installs the app built by Flutter onto a connected device):

```powershell
cd 'C:\Wastec Bank\wastec_bank_app'
flutter install --release
```

Note: `flutter install` requires the Flutter SDK in PATH and an attached device.


**Option D — Extract APK from an installed app on the phone**

If the app is already installed on the phone, you can use an "APK extractor" app on the phone to generate a distributable APK and then share it through WhatsApp.


**Option E — Serve the builds folder for a direct download (local network)**

- Easiest with Python installed (in project `builds` folder):

```powershell
cd 'C:\Wastec Bank\wastec_bank_app\builds'
python -m http.server 8000
```

Then on the phone open a browser and visit `http://<PC_IP>:8000/` and tap the APK to download.

- PowerShell HttpListener approach (requires running PowerShell as Administrator):

```powershell
# Run as Administrator
$port=8000; $folder='C:\Wastec Bank\wastec_bank_app\builds';
$listener = New-Object System.Net.HttpListener; $prefix = "http://*:$port/"; $listener.Prefixes.Add($prefix); $listener.Start();
Write-Output "Server started. Access files from http://<PC_IP>:$port/"; 
while ($listener.IsListening) { $context = $listener.GetContext(); # lightweight file server loop here }
```

Warning: the PowerShell HttpListener approach requires admin privileges and may be blocked by firewall rules.


**Sharing via WhatsApp (on phone)**

- In WhatsApp choose the chat → attach (+) → Document → Browse → Downloads → pick the APK file. Sending as "Media" can alter the file; always send as Document to preserve the APK.


**Permissions and installation settings on phone**

- If the receiver's phone blocks installation from unknown sources, they must enable package installation permissions for the File manager or WhatsApp (depends on Android version). Modern Android versions prompt per-app permission when installing.

**Troubleshooting**

- If `adb devices` shows the device is "unauthorized", accept the USB debugging prompt on the phone.
- If MTP doesn't show the phone in File Explorer, try a different USB cable or change USB mode in phone notifications.
- If you cannot run local server because Python is not installed, either install Python or use the manual copy method.


**Security note**

- Only share signed release APKs you trust. Do not share debug builds publicly. The release APK built here should be signed with the app's release key (verify in your build process).


**If you want me to push the APK from this environment**

- Provide the full path to `adb.exe` on this machine (for example: `C:\Users\you\AppData\Local\Android\sdk\platform-tools\adb.exe`) and I will attempt the `adb push` and report the output.

---

_Last updated: 2025-11-25_
