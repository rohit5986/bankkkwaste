import 'package:flutter/material.dart';
import 'config/theme.dart';
import 'screens/home_clean.dart';

void main() {
  runApp(const WastecBankApp());
}

class WastecBankApp extends StatelessWidget {
  const WastecBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Wastec Bank',
      theme: WastecTheme.lightTheme,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
}
