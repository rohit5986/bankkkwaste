# Development Guide

This guide helps contributors make changes, run the app locally, debug, and follow common conventions.

Project setup (recap)

```powershell
cd 'C:\Wastec Bank\wastec_bank_app'
flutter pub get
```

Coding conventions

- Follow Dart style (use `dart format` to format code):
```powershell
dart format .
```
- Keep widget trees readable; extract complex pieces into small widgets under `lib/widgets/`.
- Put screen-specific logic in controllers under `lib/controllers/`.

Working with branches

- Create a feature branch for changes:
```powershell
git checkout -b feat/your-feature-name
```
- Commit small changes with clear messages:
```powershell
git add <files>
git commit -m "feat: add category bar component"
```

Running & debugging

- Debug in IDE (VS Code / Android Studio) with Flutter plugin.
- Use `flutter run -d chrome` or `flutter run -d <deviceId>` for device testing.
- Use `flutter logs` for running log output and `adb logcat` for Android system logs.

Adding tests

- Add widget tests to `test/` for new UI behavior.
- Example test skeleton:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:wastec_bank_app/main.dart';

void main() {
  testWidgets('home loads', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Wastec Bank'), findsOneWidget);
  });
}
```

Pull request & code review

- Open a Pull Request against `main`.
- Include screenshots for UI changes and test results (if any).
- Ensure analysis passes: `flutter analyze`.

Local helpers

- Format and analyze before committing:
```powershell
dart format .
flutter analyze
```

- Run a single test file:
```powershell
flutter test test/widget_test.dart
```
