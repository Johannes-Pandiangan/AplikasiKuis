class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

List<Question> dummyQuestions = [
  Question(
    questionText: "Apa ibu kota dari Indonesia?",
    options: ["Medan", "Jakarta", "Surabaya", "Bandung"],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: "Widget apa yang digunakan jika UI tidak pernah berubah?",
    options: ["StatefulWidget", "StatelessWidget", "InheritedWidget", "Container"],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: "Bahasa pemrograman apa yang digunakan oleh Flutter?",
    options: ["Java", "Kotlin", "Dart", "Swift"],
    correctAnswerIndex: 2,
  ),
];