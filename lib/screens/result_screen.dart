import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.read<QuizProvider>();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Kerja Bagus, ${quizProvider.userName}!",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                "Skor Akhir Anda:",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                "${quizProvider.score}",
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: "Main Lagi",
                onPressed: () {
                  quizProvider.resetQuiz();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}