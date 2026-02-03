import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/inventory_screen.dart';
import 'config/app_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppConfig.skipLogin
          ? const InventoryScreen() // 👈 로그인 스킵
          : const LoginScreen(),
    );
  }
}
