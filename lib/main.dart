import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';
import 'screens/login_screen.dart';

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
    final appProvider = context.watch<AppProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Kuis PM',
      themeMode: appProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
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