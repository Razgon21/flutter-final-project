import 'package:flutter/material.dart';

// ─────────────────────────────────────────
//  Entry point (для быстрого запуска)
// ─────────────────────────────────────────
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Details',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A90E2)),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        useMaterial3: true,
      ),
      home: const ExpenseDetailsScreen(),
    );
  }
}

// ─────────────────────────────────────────
//  Модели данных
// ─────────────────────────────────────────
class FamilyMember {
  final String name;
  final String? avatarEmoji;
  FamilyMember({required this.name, this.avatarEmoji});
}

class NoteItem {
  final String title;
  final String? subtitle;
  final String? imageEmoji;
  final bool isPast;
  NoteItem({
    required this.title,
    this.subtitle,
    this.imageEmoji,
    this.isPast = false,
  });
}

class ExpenseItem {
  final String name;
  final String? imageEmoji;
  final double amount;
  final String? actionLabel;
  ExpenseItem({
    required this.name,
    this.imageEmoji,
    required this.amount,
    this.actionLabel,
  });
}

// ─────────────────────────────────────────
//  Главный экран
// ─────────────────────────────────────────
class ExpenseDetailsScreen extends StatefulWidget {
  const ExpenseDetailsScreen({super.key});

  @override
  State<ExpenseDetailsScreen> createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  int _selectedTab = 0;

  // Фильтры
  String _familyFilter = 'Моя семья';
  String _notesFilter = 'предстоящие';

  final List<FamilyMember> _familyMembers = [
    FamilyMember(name: 'Нечаева Александр Сергеевич', avatarEmoji: '👨'),
    FamilyMember(name: 'Нечаева Александрина Александрона', avatarEmoji: '👩'),
  ];

  final List<NoteItem> _upcomingNotes = [
    NoteItem(
      title: 'Видеоконсультация с Аной Ивановой',
      subtitle: '12.12.2025, 13:30',
      imageEmoji: '🎥',
      isPast: false,
    ),
    NoteItem(
      title: 'Запись к стоматологу',
      subtitle: '15.12.2025, 10:00',
      imageEmoji: '🦷',
      isPast: false,
    ),
  ];

  final List<NoteItem> _pastNotes = [
    NoteItem(
      title: 'Консультация терапевта',
      subtitle: '01.11.2025, 09:00',
      imageEmoji: '🏥',
      isPast: true,
    ),
  ];

  final List<ExpenseItem> _expenses = [
    ExpenseItem(
      name: 'Витамин D3, Solgar 175mg',
      imageEmoji: '💊',
      amount: 2300,
      actionLabel: 'добавить в корзину',
    ),
    ExpenseItem(
      name: 'Омега-3 Premium',
      imageEmoji: '🐟',
      amount: 1850,
      actionLabel: 'добавить в корзину',
    ),
    ExpenseItem(
      name: 'Магний B6',
      imageEmoji: '🧴',
      amount: 980,
      actionLabel: 'добавить в корзину',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileCard(),
                  const SizedBox(height: 12),
                  _buildDocumentsCard(),
                  const SizedBox(height: 12),
                  _buildFamilyCard(),
                  const SizedBox(height: 12),
                  _buildNotesCard(),
                  const SizedBox(height: 12),
                  _buildExpensesCard(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  // ── AppBar ──────────────────────────────
  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: const Icon(
                  Icons.chevron_left,
                  size: 28,
                  color: Color(0xFF4A90E2),
                ),
              ),
              const Expanded(
                child: Text(
                  'Expense Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.more_horiz,
                  size: 24,
                  color: Color(0xFF4A90E2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Карточка профиля ───────────────────
  Widget _buildProfileCard() {
    return _card(
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE8EDF3),
              border: Border.all(color: const Color(0xFF4A90E2), width: 2),
            ),
            child: const ClipOval(
              child: Center(
                child: Text('👤', style: TextStyle(fontSize: 26)),
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Коноплина Арина',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                Text(
                  'Александровна',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Клиент с 2023 года',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8A95A5),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Активна',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF388E3C),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Документы ─────────────────────────
  Widget _buildDocumentsCard() {
    return _card(
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.description_outlined,
              color: Color(0xFF4A90E2),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Мои документы',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Color(0xFFB0B8C8),
          ),
        ],
      ),
    );
  }

  // ── Семья ─────────────────────────────
  Widget _buildFamilyCard() {
    final filters = ['Моя семья', 'добавить для семьи'];
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Фильтры
          Row(
            children: filters.map((f) {
              final isActive = _familyFilter == f;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _familyFilter = f),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF4A90E2)
                          : const Color(0xFFF0F3F8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      f,
                      style: TextStyle(
                        fontSize: 13,
                        color: isActive ? Colors.white : const Color(0xFF6B7891),
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          if (_familyFilter == 'Моя семья')
            ..._familyMembers.map((m) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.circle,
                          size: 6, color: Color(0xFF4A90E2)),
                      const SizedBox(width: 8),
                      Text(
                        m.name,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                    ],
                  ),
                ))
          else
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const Icon(Icons.person_add_outlined,
                      color: Color(0xFF4A90E2), size: 36),
                  const SizedBox(height: 6),
                  const Text(
                    'Добавьте членов семьи',
                    style: TextStyle(color: Color(0xFF8A95A5), fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ── Записи ────────────────────────────
  Widget _buildNotesCard() {
    final filters = ['предстоящие', 'прошедшие'];
    final notes =
        _notesFilter == 'предстоящие' ? _upcomingNotes : _pastNotes;

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Мои записи',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A90E2),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: filters.map((f) {
              final isActive = _notesFilter == f;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _notesFilter = f),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF4A90E2)
                          : const Color(0xFFF0F3F8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      f,
                      style: TextStyle(
                        fontSize: 13,
                        color:
                            isActive ? Colors.white : const Color(0xFF6B7891),
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          ...notes.map((n) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.circle,
                        size: 6, color: Color(0xFF4A90E2)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            n.title,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                          if (n.subtitle != null)
                            Text(
                              n.subtitle!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF8A95A5),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          if (notes.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Нет записей',
                  style: TextStyle(color: Color(0xFF8A95A5), fontSize: 13),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── Траты ─────────────────────────────
  Widget _buildExpensesCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _expenses.map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F3F8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      e.imageEmoji ?? '📦',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      if (e.actionLabel != null)
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            e.actionLabel!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF4A90E2),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  '${e.amount.toStringAsFixed(0)} ₽',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Bottom Navigation ──────────────────
  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                label: 'Главная',
                index: 0,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4A90E2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 26),
                ),
              ),
              _buildNavItemTwoLines(
                icon: Icons.calendar_month_rounded,
                line1: 'Планирование',
                line2: 'бюджета',
                index: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Helpers ────────────────────────────
  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8EDF3)),
      ),
      child: child,
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = _selectedTab == index;
    final color =
        isSelected ? const Color(0xFF4A90E2) : const Color(0xFFB0B8C8);
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight:
                  isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItemTwoLines({
    required IconData icon,
    required String line1,
    required String line2,
    required int index,
  }) {
    final isSelected = _selectedTab == index;
    final color =
        isSelected ? const Color(0xFF4A90E2) : const Color(0xFFB0B8C8);
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 3),
          Text(
            line1,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight:
                  isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            line2,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight:
                  isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}