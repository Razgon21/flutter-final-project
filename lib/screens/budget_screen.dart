import 'package:flutter/material.dart';
import '../data/mock_expense_data.dart';
import '../widgets/pressable.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  late DateTime _currentMonth;
  int? _selectedDay;

  static const _bgColor = Color(0xFFF7FAFF);

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
  }

  void _prevMonth() => setState(
      () => _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1));

  void _nextMonth() => setState(
      () => _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1));

  int get _daysInMonth =>
      DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;

  String get _monthLabel {
    const months = [
      'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
      'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь',
    ];
    final now = DateTime.now();
    if (_currentMonth.year == now.year && _currentMonth.month == now.month) {
      return 'Текущий месяц';
    }
    return '${months[_currentMonth.month - 1]} ${_currentMonth.year}';
  }

  @override
  Widget build(BuildContext context) {
    final spent = MockExpenseData.totalExpenses;
    final budget = MockExpenseData.monthlyBudget;
    final ratio = (spent / budget).clamp(0.0, 1.0);
    final percent = (ratio * 100).round();

    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 16, 18, 4),
                      child: Text(
                        'Планирование\nбюджета',
                        style: TextStyle(
                          fontSize: 31,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.7,
                          height: 1.15,
                        ),
                      ),
                    ),
                    _HeroSection(),
                    _BudgetProgressSection(
                      spent: spent,
                      budget: budget,
                      ratio: ratio,
                      percent: percent,
                    ),
                    _CalendarSection(
                      currentMonth: _currentMonth,
                      monthLabel: _monthLabel,
                      daysInMonth: _daysInMonth,
                      selectedDay: _selectedDay,
                      onPrev: _prevMonth,
                      onNext: _nextMonth,
                      onDayTap: (day) => setState(() => _selectedDay = day),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            _SetBudgetButton(),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Column(
        children: [
          SizedBox(
            width: 110,
            height: 90,
            child: _WalletIllustration(),
          ),
          const SizedBox(height: 16),
          const Text(
            'Установите бюджет и отслеживайте\nсвои расходы',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF888899),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _WalletPainter());
  }
}

class _WalletPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(8, 18, w - 10, h - 20), const Radius.circular(12)),
      shadowPaint,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(4, 14, w - 8, h - 18), const Radius.circular(10)),
      Paint()..color = const Color(0xFFC4873A),
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(4, 14, w - 8, 26), const Radius.circular(10)),
      Paint()..color = const Color(0xFFD4973E),
    );

    void drawCoin(double cx, double cy, double r) {
      canvas.drawCircle(Offset(cx, cy), r, Paint()..color = const Color(0xFFFFCA28));
      canvas.drawCircle(
        Offset(cx, cy),
        r,
        Paint()
          ..color = const Color(0xFFFFB300)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2,
      );
    }

    drawCoin(w * 0.18, h * 0.82, 9);
    drawCoin(w * 0.08, h * 0.70, 7);

    final billPaint = Paint()..color = const Color(0xFF66BB6A);
    final billBorder = Paint()
      ..color = const Color(0xFF43A047)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    for (int i = 0; i < 3; i++) {
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.35 + i * 4.0, h * 0.10 - i * 4.0, w * 0.50, h * 0.38),
        const Radius.circular(4),
      );
      canvas.drawRRect(rect, billPaint);
      canvas.drawRRect(rect, billBorder);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BudgetProgressSection extends StatelessWidget {
  const _BudgetProgressSection({
    required this.spent,
    required this.budget,
    required this.ratio,
    required this.percent,
  });

  final double spent;
  final double budget;
  final double ratio;
  final int percent;

  String _fmt(double v) => v.toStringAsFixed(0).replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]} ',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Потрачено из бюджета',
                style: TextStyle(fontSize: 13, color: Color(0xFF9E9EB8)),
              ),
              Text(
                '${_fmt(budget)} ₽',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 7,
              backgroundColor: const Color(0xFFE8EAF6),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2E90FA)),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_fmt(spent)} ₽',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              Text(
                '$percent% использовано',
                style: const TextStyle(fontSize: 13, color: Color(0xFF9E9EB8)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CalendarSection extends StatelessWidget {
  const _CalendarSection({
    required this.currentMonth,
    required this.monthLabel,
    required this.daysInMonth,
    required this.selectedDay,
    required this.onPrev,
    required this.onNext,
    required this.onDayTap,
  });

  final DateTime currentMonth;
  final String monthLabel;
  final int daysInMonth;
  final int? selectedDay;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final ValueChanged<int> onDayTap;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final isCurrentMonth =
        currentMonth.year == today.year && currentMonth.month == today.month;

    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Pressable(
                onTap: onPrev,
                child: const Icon(Icons.chevron_left, size: 24, color: Color(0xFF9E9EB8)),
              ),
              Text(
                monthLabel,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF555566),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Pressable(
                onTap: onNext,
                child: const Icon(Icons.chevron_right, size: 24, color: Color(0xFF9E9EB8)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 1,
            ),
            itemCount: daysInMonth,
            itemBuilder: (context, index) {
              final day = index + 1;
              final isToday = isCurrentMonth && day == today.day;
              final isSelected = selectedDay == day;

              Color bgColor = Colors.transparent;
              Color textColor = const Color(0xFF333344);

              if (isSelected) {
                bgColor = const Color(0xFF2E90FA);
                textColor = Colors.white;
              } else if (isToday) {
                bgColor = const Color(0xFFE3F0FF);
                textColor = const Color(0xFF2E90FA);
              }

              return Pressable(
                scale: 0.85,
                onTap: () => onDayTap(day),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text(
                    '$day',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          (isSelected || isToday) ? FontWeight.w600 : FontWeight.w400,
                      color: textColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SetBudgetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      child: Pressable(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Функция в разработке'),
              backgroundColor: Color(0xFF2E90FA),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFF2E90FA),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: const Text(
            'Установить бюджет',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
