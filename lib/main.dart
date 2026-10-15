import 'package:flutter/material.dart';

void main() {
  runApp(const GardenPlannerApp());
}

// ==========================================
// 1. ГОЛОВНИЙ КЛАС ТА ТЕМА (замість index.css)
// ==========================================
class GardenPlannerApp extends StatelessWidget {
  const GardenPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Garden Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Кольори з вашого CSS (--primary: #2e7d32, --surface: #fbfdf8)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          surface: const Color(0xFFFBFDF8),
          surfaceContainerHighest: const Color(0xFFF0F5ED),
        ),
        scaffoldBackgroundColor: const Color(0xFFFBFDF8),
        fontFamily: 'Roboto',
      ),
      home: const AuthScreen(),
    );
  }
}

// ==========================================
// 2. СПІЛЬНІ ВІДЖЕТИ (Components)
// ==========================================
class CustomField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final IconData? trailing;
  final bool isPassword;
  final int maxLines;

  const CustomField({
    super.key,
    required this.label,
    this.icon,
    this.trailing,
    this.isPassword = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        obscureText: isPassword,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          suffixIcon: trailing != null ? Icon(trailing) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}

// ==========================================
// 3. ЕКРАН АВТОРИЗАЦІЇ (AuthScreen)
// ==========================================
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4A9D4E), Color(0xFF1D6724)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.psychology_outlined, color: Colors.white, size: 46),
                ),
                const SizedBox(height: 16),
                const Text('Garden Planner', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                const Text('Ваш сад. Ваш ритм.', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 32),
                
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: true, label: Text('Вхід')),
                    ButtonSegment(value: false, label: Text('Реєстрація')),
                  ],
                  selected: {isLogin},
                  onSelectionChanged: (val) => setState(() => isLogin = val.first),
                ),
                const SizedBox(height: 24),

                if (!isLogin) const CustomField(label: "Ім'я", icon: Icons.person_outline),
                const CustomField(label: "Електронна пошта", icon: Icons.mail_outline),
                const CustomField(label: "Пароль", icon: Icons.lock_outline, trailing: Icons.visibility, isPassword: true),

                if (isLogin)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: () {}, child: const Text('Забули пароль?')),
                  ),

                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MainShell()),
                    );
                  },
                  child: Text(isLogin ? 'Увійти' : 'Зареєструватися'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 4. ГОЛОВНА ОБОЛОНКА З НАВІГАЦІЄЮ (App Shell)
// ==========================================
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const PlotsScreen(),
    const PlantsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Головна'),
          NavigationDestination(icon: Icon(Icons.grid_view), label: 'Ділянки'),
          NavigationDestination(icon: Icon(Icons.yard_outlined), selectedIcon: Icon(Icons.yard), label: 'Рослини'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Профіль'),
        ],
      ),
    );
  }
}

// ==========================================
// 5. ДАШБОРД (Dashboard)
// ==========================================
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Set<int> _completedTasks = {};

  final tasks = [
    {"title": "Полити томати", "place": "Томати Чері · Теплиця", "type": "Полив", "icon": Icons.water_drop},
    {"title": "Обрізати троянди", "place": "Роза флорибунда · Клумба", "type": "Обрізка", "icon": Icons.content_cut},
    {"title": "Зібрати зелень", "place": "Базилік · Грядка №2", "type": "Збір", "icon": Icons.eco},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garden Planner', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: const [
          CircleAvatar(backgroundColor: Color(0xFFD6EAD2), child: Text('ОК', style: TextStyle(color: Color(0xFF235D27)))),
          SizedBox(width: 16),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Greeting Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFE7F4E4), Color(0xFFF3F8EF)]),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Вівторок, 14 травня', style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    const Text('Доброго ранку, Олено', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Icon(Icons.eco, size: 40, color: Colors.green),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Tasks
          const Text('Завдання на сьогодні', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                borderRadius: BorderRadius.circular(16)
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12)),
                  child: Icon(task['icon'] as IconData, color: theme.colorScheme.primary),
                ),
                title: Text(task['title'] as String, style: TextStyle(decoration: isDone ? TextDecoration.lineThrough : null, fontWeight: FontWeight.bold)),
                subtitle: Text(task['place'] as String),
                trailing: Checkbox(
                  value: isDone,
                  onChanged: (val) {
                    setState(() {
                      if (val == true) _completedTasks.add(index);
                      else _completedTasks.remove(index);
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

// ==========================================
// 6. ДІЛЯНКИ (PlotsScreen)
// ==========================================
class PlotsScreen extends StatelessWidget {
  const PlotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Садові ділянки'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('3 ДІЛЯНКИ', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 12),
          _buildPlotCard(Icons.house_siding, 'Теплиця', '12 м² · Томати, огірки', '18 рослин'),
          _buildPlotCard(Icons.local_florist, 'Клумба біля входу', 'Сонячна сторона', '9 рослин'),
          _buildPlotCard(Icons.grass, 'Грядка №2', '6 м² · Пряні трави', '14 рослин'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showPlotSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPlotCard(IconData icon, String title, String desc, String count) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, size: 32, color: Colors.green.shade700),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$desc\n$count'),
        isThreeLine: true,
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }
}

// ==========================================
// 7. РОСЛИНИ (PlantsScreen)
// ==========================================
class PlantsScreen extends StatelessWidget {
  const PlantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мої рослини'),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                FilterChip(label: const Text('Усі ділянки'), selected: true, onSelected: (v) {}),
                const SizedBox(width: 8),
                FilterChip(label: const Text('Теплиця'), selected: false, onSelected: (v) {}),
                const SizedBox(width: 8),
                FilterChip(label: const Text('Клумба біля входу'), selected: false, onSelected: (v) {}),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildPlantCard(context, 'Томати Чері', 'Solanum lycopersicum', 'Теплиця', '12 шт.'),
                _buildPlantCard(context, 'Лаванда вузьколиста', 'Lavandula', 'Клумба', '6 шт.'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlantFormScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPlantCard(BuildContext context, String title, String subtitle, String plot, String count) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.local_florist, color: Colors.green),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$subtitle\n$plot · $count'),
        trailing: const Icon(Icons.chevron_right),
        isThreeLine: true,
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlantDetailsScreen())),
      ),
    );
  }
}

// ==========================================
// 8. ДЕТАЛІ РОСЛИНИ (PlantDetailsScreen)
// ==========================================
class PlantDetailsScreen extends StatelessWidget {
  const PlantDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://images.unsplash.com/photo-1692039743847-be242d0e1fa4?w=900',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text('Томати Чері', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const Text('Solanum lycopersicum', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
                const SizedBox(height: 24),
                
                const Text('Заплановані роботи', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const ListTile(
                  leading: Icon(Icons.water_drop, color: Colors.blue),
                  title: Text('Полив'),
                  subtitle: Text('Завтра · 08:00'),
                ),
                const SizedBox(height: 24),
                
                ElevatedButton.icon(
                  onPressed: () => showTaskSheet(context),
                  icon: const Icon(Icons.event),
                  label: const Text('Запланувати роботу'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 9. ФОРМА ДОДАВАННЯ РОСЛИНИ (PlantFormScreen)
// ==========================================
class PlantFormScreen extends StatelessWidget {
  const PlantFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Додати рослину'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Зберегти'))],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade100,
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_a_photo, size: 32),
                SizedBox(height: 8),
                Text('Завантажити фото', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const CustomField(label: 'Назва рослини'),
          const CustomField(label: 'Вид / сорт'),
          const Row(
            children: [
              Expanded(child: CustomField(label: 'Кількість')),
              SizedBox(width: 16),
              Expanded(child: CustomField(label: 'Дата', trailing: Icons.calendar_today)),
            ],
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 10. ПРОФІЛЬ (ProfileScreen)
// ==========================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мій профіль'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFD6EAD2),
              child: Text('ОК', style: TextStyle(fontSize: 32, color: Color(0xFF235D27), fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 16),
          const Center(child: Text('Олена Коваль', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          const Center(child: Text('olena.koval@gmail.com', style: TextStyle(color: Colors.grey))),
          const SizedBox(height: 32),
          
          const CustomField(label: "Ім'я", icon: Icons.person_outline),
          const CustomField(label: "Новий пароль", icon: Icons.lock_outline, isPassword: true),
          
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AuthScreen())),
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text('Вийти з акаунту', style: TextStyle(color: Colors.red)),
            style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 11. BOTTOM SHEETS (Спливаючі вікна)
// ==========================================
void showPlotSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Нова ділянка', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const CustomField(label: 'Назва ділянки'),
          const CustomField(label: 'Опис', maxLines: 3),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
            child: const Text('Зберегти'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

void showTaskSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Запланувати роботу', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(label: const Text('Полив'), selected: true, onSelected: (v){}),
              ChoiceChip(label: const Text('Обрізка'), selected: false, onSelected: (v){}),
              ChoiceChip(label: const Text('Підживлення'), selected: false, onSelected: (v){}),
            ],
          ),
          const SizedBox(height: 16),
          const CustomField(label: 'Дата виконання', trailing: Icons.calendar_today),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
            child: const Text('Створити завдання'),
          ),
        ],
      ),
    ),
  );
}