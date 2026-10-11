import 'package:flutter/material.dart';
import '../models/app_models.dart';

class AppProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  // Data dummy user
  final List<UserModel> _registeredUsers = [
    UserModel(name: "Johannes Pandiangan", email: "johannes@gmail.com", password: "jopan123"),
  ];

  bool login(String email, String password) {
    try {
      _currentUser = _registeredUsers.firstWhere(
            (user) => user.email == email && user.password == password,
      );
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  bool register(String name, String email, String password) {
    if (_registeredUsers.any((user) => user.email == email)) {
      return false; // Email sudah terdaftar
    }
    _registeredUsers.add(UserModel(name: name, email: email, password: password));
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  //kuis dan riwayat
  int _currentQuestionIndex = 0;
  int _score = 0;
  String _currentCategory = '';
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  String get currentCategory => _currentCategory;

  // Data dummy riwayat kuis
  List<QuizHistory> quizHistory = [
    QuizHistory(category: "Bahasa Indonesia", date: DateTime.now().subtract(const Duration(days: 1)), score: 90),
    QuizHistory(category: "Umum", date: DateTime.now().subtract(const Duration(days: 2)), score: 80),
  ];

  // Data dummy 10 soal Matematika
  List<Question> mathQuestions = [
    Question(questionText: "Berapa hasil dari 5 + 7?", options: ["10", "11", "12", "13"], correctAnswerIndex: 2),
    Question(questionText: "Berapa hasil dari 15 - 8?", options: ["5", "6", "7", "8"], correctAnswerIndex: 2),
    Question(questionText: "Berapa hasil dari 6 x 7?", options: ["42", "46", "48", "49"], correctAnswerIndex: 0),
    Question(questionText: "Berapa hasil dari 64 : 8?", options: ["6", "7", "8", "9"], correctAnswerIndex: 2),
    Question(questionText: "Berapa hasil dari 12 + 15?", options: ["25", "27", "29", "31"], correctAnswerIndex: 1),
    Question(questionText: "Berapa hasil dari 9 x 9?", options: ["81", "72", "90", "88"], correctAnswerIndex: 0),
    Question(questionText: "Berapa hasil dari 100 - 45?", options: ["45", "50", "55", "60"], correctAnswerIndex: 2),
    Question(questionText: "Berapa hasil dari 36 : 6?", options: ["4", "5", "6", "7"], correctAnswerIndex: 2),
    Question(questionText: "Berapa hasil dari 3 x 15?", options: ["35", "40", "45", "50"], correctAnswerIndex: 2),
    Question(questionText: "Berapa hasil dari 50 + 25 - 10?", options: ["60", "65", "70", "75"], correctAnswerIndex: 1),
  ];

  List<Question> get activeQuestions => mathQuestions;

  void startQuiz(String category) {
    _currentCategory = category;
    _currentQuestionIndex = 0;
    _score = 0;
    // Reset jawaban sebelumnya
    for (var q in mathQuestions) {
      q.selectedAnswerIndex = null;
    }
    notifyListeners();
  }

  void selectAnswer(int optionIndex) {
    activeQuestions[_currentQuestionIndex].selectedAnswerIndex = optionIndex;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < activeQuestions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  void calculateAndSaveScore() {
    _score = 0;
    for (var q in activeQuestions) {
      if (q.selectedAnswerIndex == q.correctAnswerIndex) {
        _score += 10;
      }
    }
    // Tambahkan ke riwayat
    quizHistory.insert(0, QuizHistory(category: _currentCategory, date: DateTime.now(), score: _score));
    notifyListeners();
  }
}