import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final currentQuestion = quizProvider.questions[quizProvider.currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kuis Pemrograman Mobile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Pertanyaan ${quizProvider.currentQuestionIndex + 1} / ${quizProvider.questions.length}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Text(
                  currentQuestion.questionText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ...List.generate(currentQuestion.options.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: CustomButton(
                  text: currentQuestion.options[index],
                  onPressed: () {
                    bool isLastQuestion = quizProvider.currentQuestionIndex == quizProvider.questions.length - 1;

                    quizProvider.answerQuestion(index);

                    if (isLastQuestion) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const ResultScreen()),
                      );
                    }
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}