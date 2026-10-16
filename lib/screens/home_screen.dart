import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<int> _completedTasks = {};

  final List<Map<String, dynamic>> tasks = [
    {
      "title": "Полити томати",
      "place": "Томати Чері · Теплиця",
      "type": "Полив",
      "icon": Icons.water_drop,
    },
    {
      "title": "Обрізати троянди",
      "place": "Роза флорибунда · Клумба",
      "type": "Обрізка",
      "icon": Icons.content_cut,
    },
    {
      "title": "Зібрати зелень",
      "place": "Базилік · Грядка №2",
      "type": "Збір",
      "icon": Icons.eco,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garden Planner', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: const [
          CircleAvatar(
            backgroundColor: Color(0xFFD6EAD2),
            child: Text('ОК', style: TextStyle(color: Color(0xFF235D27))),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE7F4E4), Color(0xFFF3F8EF)],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Вівторок, 14 травня',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Доброго ранку, Олено',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Icon(Icons.eco, size: 40, color: Colors.green),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Завдання на сьогодні',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...List.generate(tasks.length, (index) {
            final task = tasks[index];
            final isDone = _completedTasks.contains(index);
            return Card(
              elevation: 0,
              color: isDone ? Colors.grey.shade100 : Colors.white,
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(task['icon'] as IconData, color: theme.colorScheme.primary),
                ),
                title: Text(
                  task['title'] as String,
                  style: TextStyle(
                    decoration: isDone ? TextDecoration.lineThrough : null,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(task['place'] as String),
                trailing: Checkbox(
                  value: isDone,
                  onChanged: (val) {
                    setState(() {
                      if (val == true) {
                        _completedTasks.add(index);
                      } else {
                        _completedTasks.remove(index);
                      }
                    });
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}