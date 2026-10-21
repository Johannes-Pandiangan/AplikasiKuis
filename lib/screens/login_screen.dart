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

  String? _emailError;
  String? _passError;

  void _login() {
    final email = _emailController.text.trim();
    final pass = _passController.text.trim();

    setState(() {
      _emailError = email.isEmpty ? "Email harus diisi" : null;
      _passError = pass.isEmpty ? "Password harus diisi" : null;
    });

    if (_emailError != null || _passError != null) return;

    final success = context.read<AppProvider>().login(email, pass);
    if (success) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
    } else {
      setState(() {
        _emailError = "Email salah";
        _passError = "Password salah";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 120),
              const SizedBox(height: 20),
              const Text("Masuk ke Akun Anda", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              CustomTextField(
                controller: _emailController,
                hintText: "Email",
                icon: Icons.email,
                errorText: _emailError,
              ),
              CustomTextField(
                controller: _passController,
                hintText: "Password",
                icon: Icons.lock,
                isPassword: true,
                errorText: _passError,
              ),
              const SizedBox(height: 20),
              CustomButton(text: "LOGIN", onPressed: _login),
              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontFamily: 'EduQLDHand', fontSize: 16),
                    children: const [
                      TextSpan(text: "Belum punya akun? "),
                      TextSpan(
                        text: "Daftar di sini",
                        style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}