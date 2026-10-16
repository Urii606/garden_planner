import 'package:flutter/material.dart';
import '../core/widgets/custom_field.dart';

class PlantDetailsScreen extends StatelessWidget {
  const PlantDetailsScreen({super.key});

  void showTaskSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Запланувати роботу', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('для: Томати Чері', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(label: const Text('Полив'), selected: true, onSelected: (v) {}),
                ChoiceChip(label: const Text('Обрізка'), selected: false, onSelected: (v) {}),
                ChoiceChip(label: const Text('Збір врожаю'), selected: false, onSelected: (v) {}),
                ChoiceChip(label: const Text('Підживлення'), selected: false, onSelected: (v) {}),
              ],
            ),
            const SizedBox(height: 16),
            const CustomField(label: 'Дата виконання (дедлайн)', trailing: Icons.calendar_today),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Завдання додано до розкладу!')),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
              ),
              child: const Text('Створити завдання'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Картка рослини'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Рослину видалено')),
              );
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://images.unsplash.com/photo-1592841200221-a6898f307baa?w=800',
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 200,
                    color: Colors.green.shade100,
                    child: const Icon(Icons.local_florist, size: 80, color: Colors.green),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Виберіть нове фото з галереї')),
                    );
                  },
                  icon: const Icon(Icons.photo_camera),
                  label: const Text('Оновити фото'),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text('Томати Чері', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const Text('Solanum lycopersicum · Теплиця (12 шт.)', style: TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
          const Text('Посаджено: 12 квітня 2026 р.', style: TextStyle(fontSize: 13, color: Colors.black87)),
          const Divider(height: 32),

          const Text('Заплановані роботи (FR5)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const ListTile(
            leading: Icon(Icons.water_drop, color: Colors.blue),
            title: Text('Полив'),
            subtitle: Text('Завтра · 08:00'),
          ),
          const ListTile(
            leading: Icon(Icons.eco, color: Colors.green),
            title: Text('Підживлення'),
            subtitle: Text('Понеділок, 20 жовтня'),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => showTaskSheet(context),
            icon: const Icon(Icons.add_task),
            label: const Text('Запланувати роботу'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Colors.green.shade700,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}