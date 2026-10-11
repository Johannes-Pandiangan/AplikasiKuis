import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppProvider>().currentUser;
    final isDark = context.watch<AppProvider>().isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => context.read<AppProvider>().toggleTheme(),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          const SizedBox(height: 16),
          Text(
            user?.name ?? 'Nama Pengguna',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            user?.email ?? 'email@domain.com',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const Divider(height: 40, thickness: 1),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Ganti Username'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {}, // Tampilan saja
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Ganti Password'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {}, // Tampilan saja
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            icon: const Icon(Icons.logout),
            label: const Text('Keluar'),
            onPressed: () {
              context.read<AppProvider>().logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
              );
            },
          )
        ],
      ),
    );
  }
}