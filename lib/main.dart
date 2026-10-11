import 'package:aplikasikuis/providers/app_provider.dart';
import 'package:aplikasikuis/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: const KuisApp(),
    ),
  );
}

class KuisApp extends StatelessWidget {
  const KuisApp({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Kuis PM',
      // Menerapkan dual-theme (Dark and Light Mode)
      themeMode: quizProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        fontFamily: 'EduQLDHand',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        fontFamily: 'EduQLDHand',
      ),
      home: const LoginScreen(),
    );
  }
}