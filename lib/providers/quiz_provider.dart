import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuizProvider with ChangeNotifier {
  String _userName = '';
  int _score = 0;
  int _currentQuestionIndex = 0;
  bool _isDarkMode = false;

  String get userName => _userName;
  int get score => _score;
  int get currentQuestionIndex => _currentQuestionIndex;
  bool get isDarkMode => _isDarkMode;

  List<Question> get questions => dummyQuestions;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void answerQuestion(int selectedIndex) {
    if (selectedIndex == questions[_currentQuestionIndex].correctAnswerIndex) {
      _score += 10; // Tambah skor jika benar
    }

    if (_currentQuestionIndex < questions.length - 1) {
      _currentQuestionIndex++;
    }
    notifyListeners();
  }

  bool isFinished() {
    return _currentQuestionIndex >= questions.length - 1;
  }

  void resetQuiz() {
    _score = 0;
    _currentQuestionIndex = 0;
    _userName = '';
    notifyListeners();
  }
}