import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/mock_expense_data.dart';
import '../models/expense_category.dart';

class NewExpenseScreen extends StatefulWidget {
  const NewExpenseScreen({super.key});

  @override
  State<NewExpenseScreen> createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  static const _blue = Color(0xFF1E88FF);
  static const _bgPage = Color(0xFFF7FAFF);
  static const _textMain = Color(0xFF1A1A2E);
  static const _textSub = Color(0xFF9E9EB8);

  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();

  ExpenseCategory? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  bool _saved = false;

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme:
              const ColorScheme.light(primary: _blue),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _submit() {
    if (_amountCtrl.text.isEmpty || _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            const Text('Заполните сумму и категорию'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        margin:
            const EdgeInsets.fromLTRB(16, 0, 16, 80),
      ));
      return;
    }
    setState(() => _saved = true);
    Future.delayed(const Duration(milliseconds: 800),
        () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgPage,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.chevron_left, color: _blue, size: 28),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'New Expense',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _textMain),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                const SizedBox(height: 8),

                // ── Категория ──────────────────────────────────────────
                _buildCategorySelector(),
                const SizedBox(height: 8),

                // ── Сумма ──────────────────────────────────────────────
                _buildSection(
                  label: 'Amount',
                  child: TextField(
                    controller: _amountCtrl,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: _textMain),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '0',
                      hintStyle:
                          TextStyle(color: _textSub, fontSize: 22),
                      suffixText: '₽',
                      suffixStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: _textMain),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // ── Дата ───────────────────────────────────────────────
                _buildSection(
                  label: 'Date',
                  child: GestureDetector(
                    onTap: _pickDate,
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _fmt(_selectedDate),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _textMain),
                        ),
                        const Icon(
                            Icons.calendar_today_outlined,
                            color: _blue,
                            size: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // ── Заметка ────────────────────────────────────────────
                _buildSection(
                  label: 'Note (Optional)',
                  child: TextField(
                    controller: _noteCtrl,
                    style: const TextStyle(
                        fontSize: 15, color: _textMain),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Weekly groceries',
                      hintStyle: TextStyle(color: _textSub),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Кнопка ────────────────────────────────────────────────────
          Container(
            color: Colors.white,
            padding:
                const EdgeInsets.fromLTRB(20, 12, 20, 28),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _saved ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _saved
                      ? const Color(0xFF66BB6A)
                      : _blue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _saved
                      ? const Row(
                          key: ValueKey('saved'),
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, size: 20),
                            SizedBox(width: 8),
                            Text('Добавлено!',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                        FontWeight.w600)),
                          ],
                        )
                      : const Text(
                          'Add Expense',
                          key: ValueKey('add'),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
      {required String label, required Widget child}) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12, color: _textSub)),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    final cats = MockExpenseData.categories;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedCategory?.name ?? 'Category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _selectedCategory != null
                      ? _textMain
                      : _textSub,
                ),
              ),
              const Icon(Icons.expand_more, color: _textSub),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: cats.map((cat) {
              final active = _selectedCategory == cat;
              return GestureDetector(
                onTap: () =>
                    setState(() => _selectedCategory = cat),
                child: AnimatedContainer(
                  duration:
                      const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: active
                        ? cat.color.withOpacity(0.15)
                        : const Color(0xFFF0F4FF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: active
                          ? cat.color
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(cat.emoji,
                          style:
                              const TextStyle(fontSize: 14)),
                      const SizedBox(width: 5),
                      Text(cat.name,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: active
                                  ? cat.color
                                  : const Color(
                                      0xFF555588))),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}