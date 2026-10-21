import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk topik
    final List<Map<String, dynamic>> topics = [
      {'name': 'Matematika', 'icon': Icons.calculate, 'color': Colors.blue},
      {'name': 'Umum', 'icon': Icons.public, 'color': Colors.orange},
      {'name': 'Olahraga', 'icon': Icons.sports_soccer, 'color': Colors.green},
      {'name': 'Bahasa Indonesia', 'icon': Icons.menu_book, 'color': Colors.red},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Topik Kuis'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: topics.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (topics[index]['name'] == 'Matematika') {
                  context.read<AppProvider>().startQuiz('Matematika');
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Topik ini masih dikembangkan')),
                  );
                }
              },
              child: Card(
                color: topics[index]['color'],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(topics[index]['icon'], size: 50, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(
                      topics[index]['name'],
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      ),
    );
  }
}