// register_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  bool loading = false;

  Future<void> sendVerificationEmail() async {
    setState(() => loading = true);
    try {
      // TODO: 이메일 발송 및 인증 기능은 나중에 구현
      // 현재는 바로 닉네임/유저네임 입력 화면으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NicknameScreen(
            email: emailController.text.trim(),
            password: pwController.text.trim(),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('서버 연결 실패: $e')));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: '이메일'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: pwController,
              obscureText: true,
              decoration: const InputDecoration(labelText: '비밀번호'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : sendVerificationEmail,
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('다음'),
            ),
          ],
        ),
      ),
    );
  }
}

// 이메일 인증 화면 제거 또는 TODO 처리
// class EmailVerificationScreen ... 삭제/사용하지 않음
// TODO: 이메일 인증 서버 연동은 나중에 구현

// 닉네임 + user_name 입력 화면
class NicknameScreen extends StatefulWidget {
  final String email;
  final String password;
  const NicknameScreen({super.key, required this.email, required this.password});

  @override
  State<NicknameScreen> createState() => _NicknameScreenState();
}

class _NicknameScreenState extends State<NicknameScreen> {
  final userNameController = TextEditingController(); // user_name
  final nicknameController = TextEditingController();
  bool loading = false;

  Future<void> registerUser() async {
    setState(() => loading = true);
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': widget.email,
          'password': widget.password,
          'user_name': userNameController.text.trim(),
          'nickname': nicknameController.text.trim(),
        }),
      );
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        Navigator.popUntil(context, (route) => route.isFirst); // 로그인 화면으로
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('회원가입 완료')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('서버 연결 실패: $e')));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userNameController,
              decoration: const InputDecoration(labelText: '유저 이름'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nicknameController,
              decoration: const InputDecoration(labelText: '닉네임'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : registerUser,
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('회원가입 완료'),
            ),
          ],
        ),
      ),
    );
  }
}
