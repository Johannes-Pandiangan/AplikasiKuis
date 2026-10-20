import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Membaca data riwayat dari provider
    final history = context.watch<AppProvider>().quizHistory;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Kuis'),
        automaticallyImplyLeading: false,
      ),
      // Pengecekan apakah data kosong
      body: history.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_toggle_off, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            const Text(
              "Belum ada riwayat kuis",
              style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Ayo mulai kuis pertamamu!",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.history)),
              title: Text(item.category, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${item.date.day}/${item.date.month}/${item.date.year} - ${item.date.hour}:${item.date.minute}"),
              trailing: Text(
                "${item.score}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
          );
        },
      ),
    );
  }
}