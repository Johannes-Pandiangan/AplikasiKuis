import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passError;
  String? _confirmPassError;

  void _register() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final pass = _passController.text.trim();
    final confirmPass = _confirmPassController.text.trim();

    setState(() {
      _nameError = name.isEmpty ? "Nama harus diisi" : null;
      _emailError = email.isEmpty ? "Email harus diisi" : null;
      _passError = pass.isEmpty ? "Password harus diisi" :
      pass.length < 8 ? "Password minimal 8 karakter" : null;
      _confirmPassError = confirmPass.isEmpty ? "Konfirmasi password harus diisi" :
      pass != confirmPass ? "Password tidak cocok" : null;
    });

    if (_nameError != null || _emailError != null || _passError != null || _confirmPassError != null) return;

    final success = context.read<AppProvider>().register(name, email, pass);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pendaftaran berhasil, silakan login.")));
      Navigator.pop(context);
    } else {
      setState(() {
        _emailError = "Email sudah terdaftar";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Akun")),
      body: SafeArea(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CustomTextField(controller: _nameController, hintText: "Nama Lengkap", icon: Icons.person, errorText: _nameError),
            CustomTextField(controller: _emailController, hintText: "Email", icon: Icons.email, errorText: _emailError),
            CustomTextField(controller: _passController, hintText: "Password", icon: Icons.lock, isPassword: true, errorText: _passError),
            CustomTextField(controller: _confirmPassController, hintText: "Konfirmasi Password", icon: Icons.lock_outline, isPassword: true, errorText: _confirmPassError),
            const SizedBox(height: 20),
            CustomButton(text: "DAFTAR", onPressed: _register),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontFamily: 'EduQLDHand', fontSize: 16),
                  children: const [
                    TextSpan(text: "Sudah punya akun? "),
                    TextSpan(
                      text: "Login",
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
    );
  }
}