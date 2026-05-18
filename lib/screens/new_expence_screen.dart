import 'package:flutter/material.dart';

class NewExpenseScreen extends StatefulWidget {
  const NewExpenseScreen({super.key});

  @override
  State<NewExpenseScreen> createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  final TextEditingController _amountController =
      TextEditingController(text: '2 300');
  final TextEditingController _noteController =
      TextEditingController(text: 'Еженедельные продукты');
  DateTime _selectedDate = DateTime(2024, 4, 18);
  String _selectedCategory = 'Продукты';

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Продукты', 'emoji': '🛒'},
    {'name': 'Транспорт', 'emoji': '🚗'},
    {'name': 'Здоровье', 'emoji': '💊'},
    {'name': 'Развлечения', 'emoji': '🎬'},
    {'name': 'Рестораны', 'emoji': '🍽️'},
  ];

  String get _currentCategoryEmoji {
    return _categories.firstWhere(
      (c) => c['name'] == _selectedCategory,
      orElse: () => {'emoji': '🛒'},
    )['emoji'] as String;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF2E90FA)),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  String _formatDate(DateTime date) {
    const months = [
      'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
      'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  void _showCategoryPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ..._categories.map((cat) => ListTile(
                  leading: Text(cat['emoji'] as String,
                      style: const TextStyle(fontSize: 24)),
                  title: Text(cat['name'] as String),
                  trailing: _selectedCategory == cat['name']
                      ? const Icon(Icons.check, color: Color(0xFF2E90FA))
                      : null,
                  onTap: () {
                    setState(() => _selectedCategory = cat['name'] as String);
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.chevron_left,
                            size: 28,
                            color: Color(0xFF2E90FA),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Новый расход',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                        ),
                        const SizedBox(width: 28),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange.shade100,
                          ),
                          child: const Center(
                            child: Text('🛍️',
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Продукты',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                        ),
                        const Icon(Icons.chevron_right,
                            color: Color(0xFFB0B8C8)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Сумма'),
                  _buildInputField(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 16, color: Color(0xFF1A1A2E)),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        const Text('₽',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF1A1A2E),
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildLabel('Дата'),
                  GestureDetector(
                    onTap: _pickDate,
                    child: _buildInputField(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _formatDate(_selectedDate),
                              style: const TextStyle(
                                  fontSize: 16, color: Color(0xFF1A1A2E)),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F0FE),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.calendar_today,
                                size: 18, color: Color(0xFF2E90FA)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildLabel('Категория'),
                  GestureDetector(
                    onTap: _showCategoryPicker,
                    child: _buildInputField(
                      child: Row(
                        children: [
                          Text(_currentCategoryEmoji,
                              style: const TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(_selectedCategory,
                                style: const TextStyle(
                                    fontSize: 16, color: Color(0xFF1A1A2E))),
                          ),
                          const Icon(Icons.keyboard_arrow_down,
                              color: Color(0xFF2E90FA), size: 24),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildLabel('Заметка (необязательно)'),
                  _buildInputField(
                    child: TextField(
                      controller: _noteController,
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xFF1A1A2E)),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Добавить заметку...',
                        hintStyle: TextStyle(color: Color(0xFFB0B8C8)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Расход добавлен!'),
                            backgroundColor: Color(0xFF2E90FA),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E90FA),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Добавить расход',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xFF8A95A5),
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  Widget _buildInputField({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8EDF3), width: 1),
      ),
      child: child,
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
