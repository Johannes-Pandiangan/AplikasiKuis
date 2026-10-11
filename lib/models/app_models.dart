class UserModel {
  String name;
  String email;
  String password;

  UserModel({required this.name, required this.email, required this.password});
}

class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  int? selectedAnswerIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    this.selectedAnswerIndex,
  });
}

class QuizHistory {
  final String category;
  final DateTime date;
  final int score;

  QuizHistory({required this.category, required this.date, required this.score});
}