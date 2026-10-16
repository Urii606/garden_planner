import 'package:flutter/material.dart';
import 'plant_details_screen.dart';
import '../core/widgets/custom_field.dart';

class PlantsScreen extends StatelessWidget {
  const PlantsScreen({super.key});

  void _showAddPlantDialog(BuildContext context) {
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Додати нову рослину', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const CustomField(label: 'Назва рослини (напр. Томати Чері)', icon: Icons.yard_outlined),
              const CustomField(label: 'Вид / сорт (латинська назва)', icon: Icons.eco_outlined),
              const CustomField(label: 'Кількість (шт.)', icon: Icons.numbers),
              const CustomField(label: 'Дата посадки', icon: Icons.calendar_today),
              const CustomField(label: 'Ділянка (Теплиця, Клумба)', icon: Icons.grid_view),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Рослину успішно додано!')),
                  );
                },
                icon: const Icon(Icons.check),
                label: const Text('Зберегти рослину'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final plants = [
      {'name': 'Томати Чері', 'species': 'Solanum lycopersicum', 'plot': 'Теплиця', 'qty': '12 шт.'},
      {'name': 'Лаванда вузьколиста', 'species': 'Lavandula angustifolia', 'plot': 'Клумба біля входу', 'qty': '6 шт.'},
      {'name': 'Базилік зелений', 'species': 'Ocimum basilicum', 'plot': 'Грядка №2', 'qty': '8 шт.'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мої рослини'),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: plants.length,
        itemBuilder: (context, index) {
          final plant = plants[index];
          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.local_florist, color: Colors.green, size: 30),
              ),
              title: Text(plant['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text('${plant['species']!}\n${plant['plot']!} • ${plant['qty']!}'),
              isThreeLine: true,
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PlantDetailsScreen()),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPlantDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Додати рослину'),
      ),
    );
  }
}