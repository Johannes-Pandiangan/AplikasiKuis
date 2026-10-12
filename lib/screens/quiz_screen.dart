import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/custom_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final currentQ = provider.activeQuestions[provider.currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Kuis ${provider.currentCategory}"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _showExitDialog(context),
        ),
      ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            Text(
              "Pertanyaan ${provider.currentQuestionIndex + 1} / ${provider.activeQuestions.length}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Text(
                  currentQ.questionText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
                ...List.generate(currentQ.options.length, (index) {
                  // Mengecek apakah opsi ini adalah jawaban yang sudah dipilih sebelumnya
                  bool isSelected = currentQ.selectedAnswerIndex == index;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: CustomButton(
                      text: currentQ.options[index],
                      color: isSelected ? Colors.green : null,
                      onPressed: () => provider.selectAnswer(index),
                    ),
                  );
                }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tombol Kembali hanya muncul jika bukan pertanyaan pertama
                provider.currentQuestionIndex > 0
                    ? ElevatedButton(
                  onPressed: () => provider.previousQuestion(),
                  child: const Text("Kembali"),
                )
                    : const SizedBox.shrink(),

                // Tombol Selanjutnya / Selesai
                ElevatedButton(
                  // Tombol dinonaktifkan (null) jika pengguna belum memilih jawaban
                  onPressed: currentQ.selectedAnswerIndex != null
                      ? () {
                    if (provider.currentQuestionIndex == provider.activeQuestions.length - 1) {
                      provider.calculateAndSaveScore();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ResultScreen()));
                    } else {
                      provider.nextQuestion();
                    }
                  }
                      : null,
                  child: Text(
                    provider.currentQuestionIndex == provider.activeQuestions.length - 1 ? "Selesai" : "Selanjutnya",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Keluar Kuis?"),
        content: const Text("Progres Anda pada kuis ini akan hilang."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Batal")),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text("Keluar", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}