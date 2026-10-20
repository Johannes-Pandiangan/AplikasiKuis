import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/custom_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppProvider>();

    // Menentukan pesan dan warna dinamis berdasarkan skor
    String feedbackText;
    Color feedbackColor;

    if (provider.score >= 80) {
      feedbackText = "Luar Biasa";
      feedbackColor = Colors.green;
    } else if (provider.score >= 50) {
      feedbackText = "Kerja Bagus";
      feedbackColor = Colors.orange;
    } else {
      feedbackText = "Jangan Menyerah";
      feedbackColor = Colors.red;
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$feedbackText, ${provider.currentUser?.name}!",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: feedbackColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text("Skor Akhir Anda:", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text(
                "${provider.score}",
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: "Kembali ke Beranda",
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}