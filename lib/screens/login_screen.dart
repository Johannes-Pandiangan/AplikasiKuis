import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'register_screen.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _login() {
    final email = _emailController.text.trim();
    final pass = _passController.text.trim();

    if (email.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email dan Password harus diisi!")));
      return;
    }

    final success = context.read<AppProvider>().login(email, pass);
    if (success) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email atau Password salah!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 120),
              const SizedBox(height: 20),
              const Text("Masuk ke Akun Anda", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              CustomTextField(controller: _emailController, hintText: "Email", icon: Icons.email),
              CustomTextField(controller: _passController, hintText: "Password", icon: Icons.lock, isPassword: true),
              const SizedBox(height: 20),
              CustomButton(text: "LOGIN", onPressed: _login),
              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                child: const Text("Belum punya akun? Daftar di sini"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}