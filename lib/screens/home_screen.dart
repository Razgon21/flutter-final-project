import 'package:flutter/material.dart';

import '../data/mock_expense_data.dart';
import '../navigation/app_routes.dart';
import '../screens/analytics_screen.dart';
import '../screens/expense_details_screen.dart';
import '../widgets/category_row.dart';
import '../widgets/charts/donut_chart.dart';
import '../widgets/pressable.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.onOpenAnalytics,
  });

  final VoidCallback? onOpenAnalytics;

  @override
  Widget build(BuildContext context) {
    final total = MockExpenseData.totalExpenses;
    final categories = MockExpenseData.categories;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 22),
        children: [
          const Text(
            'Трекер расходов',
            style: TextStyle(
              fontSize: 31,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.7,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Траты за май',
            style: TextStyle(fontSize: 22, color: Color(0xFF475467)),
          ),
          Text(
            '${total.toStringAsFixed(0)} ₽',
            style: const TextStyle(
                fontSize: 50, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Center(
            child: DonutChart(
              size: 250,
              strokeWidth: 40,
              categories: categories,
              center: const SizedBox.shrink(),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: categories
                .map((c) =>
                    _ChartLegendItem(color: c.color, label: c.name))
                .toList(),
          ),
          const SizedBox(height: 12),

          // Кнопка → Analytics (слайд вправо)
          Center(
            child: Pressable(
              onTap: () {
                if (onOpenAnalytics != null) {
                  // Если вызван из RootScreen — переключаем таб
                  onOpenAnalytics!();
                } else {
                  Navigator.of(context).push(
                    slideRightRoute(AnalyticsScreen(
                      onBackHome: () => Navigator.pop(context),
                      onOpenBudget: () {},
                    )),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E90FA),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.analytics_outlined,
                        color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Расширенная аналитика',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Список категорий → ExpenseDetailsScreen (слайд вправо)
          ...categories.map((category) => Pressable(
                onTap: () => Navigator.of(context).push(
                  slideRightRoute(
                    ExpenseDetailsScreen(
                      data: ExpenseDetailsData(
                        person: PersonInfo(
                          name: category.name,
                          subtitle: '${category.emoji} Категория расходов',
                          avatarColor: category.color,
                          initials: category.name
                              .substring(0, 1)
                              .toUpperCase(),
                        ),
                        documents: const [
                          DocumentItem(
                            title: 'Мои документы',
                            icon: Icons.description_outlined,
                          ),
                        ],
                        familyMembers: const [
                          'Нечаева Александр Сергеевич',
                          'Нечаева Александрина Александровна',
                        ],
                        notes: const [
                          NoteItem(
                            text:
                                'Ведеоконсорптация с Аной Мановой\n12.12.2025, 13:30',
                            date: '12.12.2025',
                            tag: NoteTag.past,
                          ),
                        ],
                        product: ProductItem(
                          name: 'Витамин D3, 50gat 175reg',
                          description: 'добавить в корзину',
                          amount: category.amount,
                          emoji: category.emoji,
                        ),
                      ),
                    ),
                  ),
                ),
                child: CategoryRow(
                  category: category,
                  amountText:
                      '${category.amount.toStringAsFixed(0)} ₽',
                ),
              )),
        ],
      ),
    );
  }
}

class _ChartLegendItem extends StatelessWidget {
  const _ChartLegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E7EC)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 9,
            height: 9,
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF475467),
            ),
          ),
        ],
      ),
    );
  }
}