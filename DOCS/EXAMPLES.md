# Examples & Recipes

This document contains small, copyable examples showing how to use shared widgets and common flows.

1) Adding `ProfileWalletActions` to an AppBar

```dart
import 'package:flutter/material.dart';
import 'package:wastec_bank_app/widgets/profile_wallet_actions.dart';

class ExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
        actions: [ProfileWalletActions()],
      ),
      body: Center(child: Text('Hello')), 
    );
  }
}
```

2) Navigating to a category detail from the category bar

```dart
InkWell(
  onTap: () => Navigator.push(context, MaterialPageRoute(
    builder: (_) => ScrapCategoriesScreen(category: category)
  )),
  child: HomeCategoryCard(...),
)
```

3) Building and sharing an APK (script)

```powershell
# build release apk
flutter build apk --release
# copy to builds folder
Copy-Item "build\app\outputs\flutter-apk\app-release.apk" -Destination "builds\WastecBank-app-release.apk" -Force
# zip
Compress-Archive -Path "builds\WastecBank-app-release.apk" -DestinationPath "builds\WastecBank-app-release.zip" -Force
```

4) Simple widget test:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:wastec_bank_app/main.dart';

void main() {
  testWidgets('Smoke test: app starts', (tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
```
