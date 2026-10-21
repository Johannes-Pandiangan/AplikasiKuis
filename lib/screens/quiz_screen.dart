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

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        _showExitDialog(context);
      },
      child: Scaffold(
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          currentQ.questionText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 40),
                        ...List.generate(currentQ.options.length, (index) {
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
                            provider.currentQuestionIndex > 0
                                ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFCA08),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              ),
                              onPressed: () => provider.previousQuestion(),
                              child: const Text("Kembali", style: TextStyle(fontWeight: FontWeight.bold)),
                            )
                                : const SizedBox.shrink(),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFCA08),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              ),
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
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
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

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Keluar Kuis?"),
        content: const Text("Progres Anda pada kuis ini akan hilang."),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFCA08),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Batal", style: TextStyle(fontWeight: FontWeight.bold))
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text("Keluar", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}