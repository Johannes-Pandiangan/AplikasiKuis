import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.read<QuizProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Selamat Datang"),
        actions: [
          IconButton(
            icon: Icon(
              context.watch<QuizProvider>().isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              quizProvider.toggleTheme();
            },
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 150),
              const SizedBox(height: 30),
              const Text(
                "Masukkan Nama Anda",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Nama Pengguna",
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: "Mulai Kuis",
                onPressed: () {
                  if (_nameController.text.trim().isNotEmpty) {
                    quizProvider.setUserName(_nameController.text.trim());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QuizScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Nama tidak boleh kosong!")),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}