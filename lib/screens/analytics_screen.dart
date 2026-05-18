import 'package:flutter/material.dart';

import '../data/mock_expense_data.dart';
import '../widgets/category_row.dart';
import '../widgets/charts/bar_chart.dart';
import '../widgets/charts/ring_progress.dart';
import '../widgets/pressable.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  _AnalyticsPeriod _period = _AnalyticsPeriod.month;
  int? _selectedWeekIndex = 6;
  int? _selectedMonthWeekIndex = 3;

  int get _safeWeekIndex => (_selectedWeekIndex ?? 6).clamp(
        0,
        MockExpenseData.weekDays.length - 1,
      );
  int get _safeMonthWeekIndex => (_selectedMonthWeekIndex ?? 3).clamp(
        0,
        MockExpenseData.monthWeeks.length - 1,
      );

  @override
  Widget build(BuildContext context) {
    final weekDay = MockExpenseData.dayAt(_safeWeekIndex);
    final monthWeek = MockExpenseData.monthWeekAt(_safeMonthWeekIndex);
    final total =
        _period == _AnalyticsPeriod.month ? monthWeek.total : weekDay.total;
    final periodBudget = _period == _AnalyticsPeriod.month
        ? MockExpenseData.monthlyBudget / 4
        : MockExpenseData.monthlyBudget / 30;
    final ratio = (total / periodBudget).clamp(0.0, 1.0);
    final topFive = _period == _AnalyticsPeriod.month
        ? MockExpenseData.topFiveForMonthWeek(_safeMonthWeekIndex)
        : MockExpenseData.topFiveForDay(_safeWeekIndex);
    final chartValues = _period == _AnalyticsPeriod.month
        ? MockExpenseData.monthTrend
        : MockExpenseData.weekTrend;
    final subtitleDate = _period == _AnalyticsPeriod.month
        ? monthWeek.dateLabel
        : weekDay.dateLabel;
    final chartLabels = _period == _AnalyticsPeriod.month
        ? MockExpenseData.monthLabels
        : MockExpenseData.weekLabels;
    final chartSelectedIndex =
        _period == _AnalyticsPeriod.month ? _safeMonthWeekIndex : _safeWeekIndex;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 22),
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: widget.onBackHome,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: const Color(0xFFE4E7EC)),
                  ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Color(0xFF667085),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Аналитика',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x12000000),
                  blurRadius: 16,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Траты',
                        style: TextStyle(color: Color(0xFF667085)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${total.toStringAsFixed(0)} ₽',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E90FA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Месячный бюджет',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RingProgress(
                  progress: ratio,
                  label: '${(ratio * 100).toStringAsFixed(0)}%',
                  subtitle: 'Потрачено',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _SegmentControl(
            selected: _period,
            onChanged: (period) => setState(() => _period = period),
          ),
          const SizedBox(height: 14),
          Text(
            subtitleDate,
            style: TextStyle(
              color: Color(0xFF667085),
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          BarChart(
            values: chartValues,
            labels: chartLabels,
            selectedIndex: chartSelectedIndex,
            onBarTap: (index) {
              setState(() {
                if (_period == _AnalyticsPeriod.week) {
                  _selectedWeekIndex = index;
                } else {
                  _selectedMonthWeekIndex = index;
                }
              });
            },
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                _period == _AnalyticsPeriod.month
                    ? 'Категории за неделю'
                    : 'Категории за день',
                style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Text(
                '${total.toStringAsFixed(0)} ₽',
                style: const TextStyle(
                  color: Color(0xFF2E90FA),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...topFive.map((category) {
            return CategoryRow(
              category: category,
              amountText: '${category.amount.toStringAsFixed(0)} ₽',
              showPercentage: true,
              total: total,
            );
          }),
        ],
      ),
    );
  }
}

enum _AnalyticsPeriod { week, month }

class _SegmentControl extends StatelessWidget {
  const _SegmentControl({required this.selected, required this.onChanged});

  final _AnalyticsPeriod selected;
  final ValueChanged<_AnalyticsPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE4E7EC)),
      ),
      child: Row(
        children: [
          _SegmentLabel(
            text: 'Неделя',
            selected: selected == _AnalyticsPeriod.week,
            onTap: () => onChanged(_AnalyticsPeriod.week),
          ),
          _SegmentLabel(
            text: 'Месяц',
            selected: selected == _AnalyticsPeriod.month,
            onTap: () => onChanged(_AnalyticsPeriod.month),
          ),
        ],
      ),
    );
  }
}

class _SegmentLabel extends StatelessWidget {
  const _SegmentLabel({required this.text, required this.selected, required this.onTap});

  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Pressable(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFEDF5FF) : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected
                  ? const Color(0xFF2E90FA)
                  : const Color(0xFF667085),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
