import 'package:flutter/material.dart';
import '../core/widgets/custom_field.dart';
import 'main_navigation_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Відновлення пароля'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Введіть ваш Email для отримання інструкції з відновлення пароля:'),
            SizedBox(height: 12),
            CustomField(label: 'Email', icon: Icons.email_outlined),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Скасувати'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Інструкції надіслано на пошту!')),
              );
            },
            child: const Text('Надіслати'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.eco, size: 72, color: Colors.green),
              const SizedBox(height: 12),
              const Text(
                'Garden Planner',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              if (!isLogin)
                const CustomField(label: "Ім'я та прізвище", icon: Icons.person_outline),
              const CustomField(label: 'Електронна пошта', icon: Icons.email_outlined),
              const CustomField(label: 'Пароль', icon: Icons.lock_outline, isPassword: true),
              if (isLogin)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _showForgotPasswordDialog,
                    child: const Text('Забули пароль?'),
                  ),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                ),
                child: Text(isLogin ? 'Увійти' : 'Зареєструватися'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => setState(() => isLogin = !isLogin),
                child: Text(
                  isLogin ? 'Немає акаунту? Зареєструватися' : 'Вже є акаунт? Увійти',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}