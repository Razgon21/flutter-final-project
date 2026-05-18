import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ══════════════════════════════════════════════════════════════════════════════
// Модель данных для экрана
// ══════════════════════════════════════════════════════════════════════════════

class ExpenseDetailsData {
  const ExpenseDetailsData({
    required this.person,
    required this.documents,
    required this.familyMembers,
    required this.notes,
    required this.product,
  });

  final PersonInfo person;
  final List<DocumentItem> documents;
  final List<String> familyMembers;
  final List<NoteItem> notes;
  final ProductItem product;
}

class PersonInfo {
  const PersonInfo({
    required this.name,
    required this.subtitle,
    this.avatarColor = const Color(0xFF7B9FEB),
    this.initials = '',
  });
  final String name;
  final String subtitle;
  final Color avatarColor;
  final String initials;
}

class DocumentItem {
  const DocumentItem({required this.title, required this.icon});
  final String title;
  final IconData icon;
}

class NoteItem {
  const NoteItem({
    required this.text,
    required this.date,
    required this.tag,
  });
  final String text;
  final String date;
  final NoteTag tag;
}

enum NoteTag { upcoming, past }

class ProductItem {
  const ProductItem({
    required this.name,
    required this.description,
    required this.amount,
    required this.emoji,
  });
  final String name;
  final String description;
  final double amount;
  final String emoji;
}

// Mock данные
final _mockExpenseDetails = ExpenseDetailsData(
  person: const PersonInfo(
    name: 'Конопцина Арина',
    subtitle: 'Александровна',
    avatarColor: Color(0xFF7B9FEB),
    initials: 'КА',
  ),
  documents: const [
    DocumentItem(title: 'Мои документы', icon: Icons.description_outlined),
  ],
  familyMembers: const [
    'Нечаева Александр Сергеевич',
    'Нечаева Александрина Александровна',
  ],
  notes: const [
    NoteItem(
      text: 'Ведеоконсорптация с Аной Мановой\n12.12.2025, 13:30',
      date: '12.12.2025',
      tag: NoteTag.past,
    ),
  ],
  product: ProductItem(
    name: 'Витамин D3, 50gat 175reg',
    description: 'добавить в корзину',
    amount: 2300,
    emoji: '💊',
  ),
);

// ══════════════════════════════════════════════════════════════════════════════
// Expense Details Screen
// ══════════════════════════════════════════════════════════════════════════════

class ExpenseDetailsScreen extends StatefulWidget {
  const ExpenseDetailsScreen({
    super.key,
    this.data,
  });

  /// Можно передать кастомные данные; если null — используются mock
  final ExpenseDetailsData? data;

  @override
  State<ExpenseDetailsScreen> createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  late ExpenseDetailsData _data;

  // Активные чипы
  String _familyChip = 'Моя семья';
  NoteTag _noteFilter = NoteTag.upcoming;

  bool _copiedAmount = false;

  static const _blue = Color(0xFF1E88FF);
  static const _bgPage = Color(0xFFF7FAFF);
  static const _bgCard = Colors.white;
  static const _textMain = Color(0xFF1A1A2E);
  static const _textSub = Color(0xFF9E9EB8);
  static const _chipActive = Color(0xFF1E88FF);
  static const _chipBg = Color(0xFFE8F0FE);

  @override
  void initState() {
    super.initState();
    _data = widget.data ?? _mockExpenseDetails;
  }

  // ── helpers ───────────────────────────────────────────────────────────────

  String _fmt(double v) => v
      .toStringAsFixed(0)
      .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');

  void _copyAmount() {
    Clipboard.setData(
        ClipboardData(text: '${_fmt(_data.product.amount)} ₽'));
    setState(() => _copiedAmount = true);
    Future.delayed(const Duration(seconds: 2),
        () => setState(() => _copiedAmount = false));
  }

  // ── build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgPage,
      appBar: _buildAppBar(),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          const SizedBox(height: 8),
          _buildPersonCard(),
          const SizedBox(height: 8),
          _buildDocumentsCard(),
          const SizedBox(height: 8),
          _buildFamilyCard(),
          const SizedBox(height: 8),
          _buildNotesCard(),
          const SizedBox(height: 8),
          _buildProductCard(),
        ],
      ),
    );
  }

  // ── AppBar ────────────────────────────────────────────────────────────────

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _bgCard,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.chevron_left, color: _blue, size: 28),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: const Text(
        'Expense Details',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: _textMain,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_horiz, color: _textSub),
          onPressed: _showOptionsSheet,
        ),
      ],
    );
  }

  // ── Person card ───────────────────────────────────────────────────────────

  Widget _buildPersonCard() {
    final p = _data.person;
    return _Card(
      child: Row(
        children: [
          // Аватар
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: p.avatarColor.withOpacity(0.25),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                p.initials,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: p.avatarColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(p.name,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _textMain)),
              const SizedBox(height: 2),
              Text(p.subtitle,
                  style:
                      const TextStyle(fontSize: 13, color: _textSub)),
            ],
          ),
          const Spacer(),
          Icon(Icons.chevron_right, color: _textSub.withOpacity(0.5)),
        ],
      ),
    );
  }

  // ── Documents card ────────────────────────────────────────────────────────

  Widget _buildDocumentsCard() {
    return _Card(
      child: Column(
        children: _data.documents.map((doc) {
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _showSnack('Документы'),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: _chipBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(doc.icon, color: _blue, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(doc.title,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _textMain)),
                  ),
                  Icon(Icons.chevron_right,
                      color: _textSub.withOpacity(0.5), size: 20),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Family card ───────────────────────────────────────────────────────────

  Widget _buildFamilyCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Чипы-фильтры
          Row(
            children: [
              _Chip(
                label: 'Моя семья',
                active: _familyChip == 'Моя семья',
                onTap: () => setState(() => _familyChip = 'Моя семья'),
              ),
              const SizedBox(width: 8),
              _Chip(
                label: 'добавить для семьи',
                active: _familyChip == 'add',
                isAction: true,
                onTap: () => _showAddFamilySheet(),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Список членов семьи
          ..._data.familyMembers.map(
            (name) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  const Icon(Icons.circle,
                      size: 6, color: _blue),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(name,
                        style: const TextStyle(
                            fontSize: 13, color: _textMain)),
                  ),
                  IconButton(
                    icon: Icon(Icons.close,
                        size: 16, color: _textSub.withOpacity(0.5)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => _showSnack('Удалить: $name'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Notes card ────────────────────────────────────────────────────────────

  Widget _buildNotesCard() {
    final filtered = _data.notes
        .where((n) =>
            _noteFilter == NoteTag.upcoming
                ? n.tag == NoteTag.upcoming
                : n.tag == NoteTag.past)
        .toList();

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок
          const Text('Мои записи',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _blue)),
          const SizedBox(height: 10),

          // Чипы
          Row(
            children: [
              _Chip(
                label: 'предстоящее',
                active: _noteFilter == NoteTag.upcoming,
                onTap: () =>
                    setState(() => _noteFilter = NoteTag.upcoming),
              ),
              const SizedBox(width: 8),
              _Chip(
                label: 'прошедшее',
                active: _noteFilter == NoteTag.past,
                onTap: () =>
                    setState(() => _noteFilter = NoteTag.past),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Записи
          if (filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(
                  'Нет записей',
                  style: TextStyle(
                      fontSize: 13,
                      color: _textSub.withOpacity(0.7)),
                ),
              ),
            )
          else
            ...filtered.map((note) => _buildNoteItem(note)),

          // Кнопка добавить запись
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _showAddNoteSheet(),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: _chipBg,
                    shape: BoxShape.circle,
                  ),
                  child:
                      const Icon(Icons.add, size: 16, color: _blue),
                ),
                const SizedBox(width: 8),
                const Text('Добавить запись',
                    style: TextStyle(
                        fontSize: 13,
                        color: _blue,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteItem(NoteItem note) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _bgPage,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 6, color: _blue),
          const SizedBox(width: 10),
          Expanded(
            child: Text(note.text,
                style: const TextStyle(
                    fontSize: 13, color: _textMain, height: 1.4)),
          ),
        ],
      ),
    );
  }

  // ── Product card ──────────────────────────────────────────────────────────

  Widget _buildProductCard() {
    final p = _data.product;
    return _Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Иконка товара
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(p.emoji,
                  style: const TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(width: 14),

          // Название и описание
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.name,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _textMain)),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () => _showSnack('Добавить в корзину'),
                  child: Text(p.description,
                      style: const TextStyle(
                          fontSize: 12,
                          color: _blue,
                          decoration: TextDecoration.underline)),
                ),
              ],
            ),
          ),

          // Сумма + кнопка копировать
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${_fmt(p.amount)} ₽',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _textMain),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: _copyAmount,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color:
                        _copiedAmount ? const Color(0xFF66BB6A) : _chipBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _copiedAmount
                            ? Icons.check
                            : Icons.copy_outlined,
                        size: 12,
                        color: _copiedAmount
                            ? Colors.white
                            : _blue,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _copiedAmount ? 'Скопировано' : 'копировать',
                        style: TextStyle(
                            fontSize: 11,
                            color: _copiedAmount
                                ? Colors.white
                                : _blue,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Sheets & snacks ───────────────────────────────────────────────────────

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 80),
    ));
  }

  void _showOptionsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _OptionsSheet(
        onEdit: () {
          Navigator.pop(context);
          _showSnack('Редактировать');
        },
        onDelete: () {
          Navigator.pop(context);
          Navigator.maybePop(context);
        },
      ),
    );
  }

  void _showAddFamilySheet() {
    final ctrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _SimpleInputSheet(
          title: 'Добавить члена семьи',
          hint: 'Имя и фамилия',
          controller: ctrl,
          onSave: (name) {
            _showSnack('Добавлен: $name');
          },
        ),
      ),
    );
  }

  void _showAddNoteSheet() {
    final ctrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _SimpleInputSheet(
          title: 'Новая запись',
          hint: 'Текст записи',
          controller: ctrl,
          onSave: (text) {
            _showSnack('Запись добавлена');
          },
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Shared Widgets
// ══════════════════════════════════════════════════════════════════════════════

/// Белая карточка с паддингом
class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: child,
    );
  }
}

/// Чип (активный/неактивный)
class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.active,
    required this.onTap,
    this.isAction = false,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;
  final bool isAction;

  static const _blue = Color(0xFF1E88FF);
  static const _chipBg = Color(0xFFE8F0FE);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: active ? _blue : _chipBg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isAction) ...[
              Icon(Icons.add,
                  size: 13, color: active ? Colors.white : _blue),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: active ? Colors.white : _blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Bottom Sheets
// ══════════════════════════════════════════════════════════════════════════════

class _OptionsSheet extends StatelessWidget {
  const _OptionsSheet({
    required this.onEdit,
    required this.onDelete,
  });
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 20),
          _OptionTile(
            icon: Icons.edit_outlined,
            label: 'Редактировать',
            color: const Color(0xFF1A1A2E),
            onTap: onEdit,
          ),
          const Divider(height: 1),
          _OptionTile(
            icon: Icons.delete_outline,
            label: 'Удалить расход',
            color: const Color(0xFFEF5350),
            onTap: onDelete,
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color),
      title: Text(label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: color)),
      contentPadding: EdgeInsets.zero,
    );
  }
}

class _SimpleInputSheet extends StatelessWidget {
  const _SimpleInputSheet({
    required this.title,
    required this.hint,
    required this.controller,
    required this.onSave,
  });
  final String title;
  final String hint;
  final TextEditingController controller;
  final ValueChanged<String> onSave;

  static const _blue = Color(0xFF1E88FF);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 16),
          Text(title,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E))),
          const SizedBox(height: 16),
          TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: const Color(0xFFF7FAFF),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: _blue, width: 1.5)),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  onSave(controller.text.trim());
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _blue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Сохранить',
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}