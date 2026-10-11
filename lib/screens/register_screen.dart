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

  void _register() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final pass = _passController.text.trim();
    final confirmPass = _confirmPassController.text.trim();

    if (name.isEmpty || email.isEmpty || pass.isEmpty || confirmPass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Semua kolom harus diisi!")));
      return;
    }
    if (pass.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password minimal 8 karakter!")));
      return;
    }
    if (pass != confirmPass) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Konfirmasi password tidak cocok!")));
      return;
    }

    final success = context.read<AppProvider>().register(name, email, pass);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pendaftaran berhasil, silakan login.")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email sudah digunakan!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Akun")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CustomTextField(controller: _nameController, hintText: "Nama Lengkap", icon: Icons.person),
            CustomTextField(controller: _emailController, hintText: "Email", icon: Icons.email),
            CustomTextField(controller: _passController, hintText: "Password", icon: Icons.lock, isPassword: true),
            CustomTextField(controller: _confirmPassController, hintText: "Konfirmasi Password", icon: Icons.lock_outline, isPassword: true),
            const SizedBox(height: 20),
            CustomButton(text: "DAFTAR", onPressed: _register),
          ],
        ),
      ),
    );
  }
}