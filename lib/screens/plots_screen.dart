import 'package:flutter/material.dart';
import '../core/widgets/custom_field.dart';

class PlotsScreen extends StatelessWidget {
  const PlotsScreen({super.key});

  void _showAddPlotDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Створити нову ділянку', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const CustomField(label: 'Назва ділянки (напр. Теплиця)', icon: Icons.grid_view),
            const CustomField(label: 'Опис / розмір (напр. 3x6м)', icon: Icons.description_outlined),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ділянку успішно створено!')),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
              ),
              child: const Text('Зберегти ділянку'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final plots = [
      {'name': 'Теплиця', 'desc': 'Розмір: 3х6м • Помідори, огірки', 'count': '18 рослин'},
      {'name': 'Клумба біля входу', 'desc': 'Сонячна сторона • Троянди й лаванда', 'count': '9 рослин'},
      {'name': 'Грядка №2', 'desc': 'Пряні трави та зелень', 'count': '14 рослин'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Садові ділянки'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: plots.length,
        itemBuilder: (context, index) {
          final plot = plots[index];
          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.grid_view, color: Colors.green),
              ),
              title: Text(plot['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text(plot['desc']!),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Дію "$value" виконано')),
                  );
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'Редагувати', child: Text('Редагувати')),
                  const PopupMenuItem(value: 'Видалити', child: Text('Видалити', style: TextStyle(color: Colors.red))),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPlotDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Додати ділянку'),
      ),
    );
  }
}