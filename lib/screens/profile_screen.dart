import 'package:flutter/material.dart';
import '../core/widgets/custom_field.dart';
import 'auth_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мій профіль'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFD6EAD2),
                  child: Text('О', style: TextStyle(fontSize: 32, color: Color(0xFF235D27), fontWeight: FontWeight.bold)),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.green.shade700,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Оновлення фото профілю')),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Center(child: Text('Олена', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
          const Center(child: Text('olena3458@gmail.com', style: TextStyle(color: Colors.grey))),
          const SizedBox(height: 28),

          const Text('Особисті дані (FR7)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          const CustomField(label: "Ім'я", icon: Icons.person_outline),
          const SizedBox(height: 12),

          const Text('Зміна пароля', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          const CustomField(label: "Поточний пароль", icon: Icons.lock_outline, isPassword: true),
          const CustomField(label: "Новий пароль", icon: Icons.lock_reset, isPassword: true),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Дані профілю збережено!')),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Colors.green.shade700,
              foregroundColor: Colors.white,
            ),
            child: const Text('Зберегти зміни'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AuthScreen()),
            ),
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text('Вийти з акаунту', style: TextStyle(color: Colors.red)),
            style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
          ),
        ],
      ),
    );
  }
}