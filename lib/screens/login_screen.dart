import 'package:flutter/material.dart';
import 'inventory_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '로그인',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            TextField(
              decoration: InputDecoration(
                labelText: 'ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'PW',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const InventoryScreen(),
                  ),
                );
              },
              child: const Text('로그인'),
            ),

            const SizedBox(height: 16),
            const Divider(),

            ElevatedButton(
              onPressed: () {},
              child: const Text('구글 로그인'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('네이버 로그인'),
            ),
          ],
        ),
      ),
    );
  }
}
