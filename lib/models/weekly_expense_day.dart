import 'expense_category.dart';

class WeeklyExpenseDay {
  const WeeklyExpenseDay({
    required this.label,
    required this.dateLabel,
    required this.categories,
  });

  final String label;
  final String dateLabel;
  final List<ExpenseCategory> categories;

  double get total =>
      categories.fold<double>(0, (sum, category) => sum + category.amount);
}
