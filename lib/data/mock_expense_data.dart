import 'package:flutter/material.dart';

import '../models/expense_category.dart';
import '../models/weekly_expense_day.dart';

class MockExpenseData {
  static const double monthlyBudget = 72000;

  static const List<ExpenseCategory> categories = [
    ExpenseCategory(
      name: 'Жилье',
      amount: 36000,
      color: Color(0xFF5C6BC0),
      emoji: '🏠',
    ),
    ExpenseCategory(
      name: 'Продукты',
      amount: 18400,
      color: Color(0xFF66BB6A),
      emoji: '🛒',
    ),
    ExpenseCategory(
      name: 'Рестораны',
      amount: 10800,
      color: Color(0xFFFF7043),
      emoji: '🍽️',
    ),
    ExpenseCategory(
      name: 'Шоппинг',
      amount: 8200,
      color: Color(0xFFEC407A),
      emoji: '🛍️',
    ),
    ExpenseCategory(
      name: 'Транспорт',
      amount: 7800,
      color: Color(0xFF42A5F5),
      emoji: '🚇',
    ),
    ExpenseCategory(
      name: 'Развлечения',
      amount: 6400,
      color: Color(0xFFFFCA28),
      emoji: '🎬',
    ),
    ExpenseCategory(
      name: 'Здоровье',
      amount: 4400,
      color: Color(0xFF26A69A),
      emoji: '💊',
    ),
    ExpenseCategory(
      name: 'Прочее',
      amount: 4200,
      color: Color(0xFF8D6E63),
      emoji: '📦',
    ),
    ExpenseCategory(
      name: 'Связь и интернет',
      amount: 2600,
      color: Color(0xFF26C6DA),
      emoji: '📶',
    ),
    ExpenseCategory(
      name: 'Подписки',
      amount: 1900,
      color: Color(0xFFAB47BC),
      emoji: '🎧',
    ),
  ];

  static const List<WeeklyExpenseDay> weekDays = [
    WeeklyExpenseDay(
      label: 'Пн',
      dateLabel: '12 мая',
      categories: [
        ExpenseCategory(
          name: 'Продукты',
          amount: 2350,
          color: Color(0xFF66BB6A),
          emoji: '🛒',
        ),
        ExpenseCategory(
          name: 'Транспорт',
          amount: 620,
          color: Color(0xFF42A5F5),
          emoji: '🚇',
        ),
        ExpenseCategory(
          name: 'Рестораны',
          amount: 780,
          color: Color(0xFFFF7043),
          emoji: '🍽️',
        ),
        ExpenseCategory(
          name: 'Подписки',
          amount: 320,
          color: Color(0xFFAB47BC),
          emoji: '🎧',
        ),
      ],
    ),
    WeeklyExpenseDay(
      label: 'Вт',
      dateLabel: '13 мая',
      categories: [
        ExpenseCategory(
          name: 'Продукты',
          amount: 1850,
          color: Color(0xFF66BB6A),
          emoji: '🛒',
        ),
        ExpenseCategory(
          name: 'Шоппинг',
          amount: 2400,
          color: Color(0xFFEC407A),
          emoji: '🛍️',
        ),
        ExpenseCategory(
          name: 'Транспорт',
          amount: 560,
          color: Color(0xFF42A5F5),
          emoji: '🚇',
        ),
      ],
    ),
    WeeklyExpenseDay(
      label: 'Ср',
      dateLabel: '14 мая',
      categories: [
        ExpenseCategory(
          name: 'Жилье',
          amount: 5200,
          color: Color(0xFF5C6BC0),
          emoji: '🏠',
        ),
        ExpenseCategory(
          name: 'Продукты',
          amount: 1620,
          color: Color(0xFF66BB6A),
          emoji: '🛒',
        ),
        ExpenseCategory(
          name: 'Транспорт',
          amount: 450,
          color: Color(0xFF42A5F5),
          emoji: '🚇',
        ),
      ],
    ),
    WeeklyExpenseDay(
      label: 'Чт',
      dateLabel: '15 мая',
      categories: [
        ExpenseCategory(
          name: 'Рестораны',
          amount: 2650,
          color: Color(0xFFFF7043),
          emoji: '🍽️',
        ),
        ExpenseCategory(
          name: 'Развлечения',
          amount: 1900,
          color: Color(0xFFFFCA28),
          emoji: '🎬',
        ),
        ExpenseCategory(
          name: 'Такси',
          amount: 920,
          color: Color(0xFF42A5F5),
          emoji: '🚕',
        ),
      ],
    ),
    WeeklyExpenseDay(
      label: 'Пт',
      dateLabel: '16 мая',
      categories: [
        ExpenseCategory(
          name: 'Шоппинг',
          amount: 4200,
          color: Color(0xFFEC407A),
          emoji: '🛍️',
        ),
        ExpenseCategory(
          name: 'Рестораны',
          amount: 1700,
          color: Color(0xFFFF7043),
          emoji: '🍽️',
        ),
        ExpenseCategory(
          name: 'Транспорт',
          amount: 580,
          color: Color(0xFF42A5F5),
          emoji: '🚇',
        ),
      ],
    ),
    WeeklyExpenseDay(
      label: 'Сб',
      dateLabel: '17 мая',
      categories: [
        ExpenseCategory(
          name: 'Развлечения',
          amount: 3100,
          color: Color(0xFFFFCA28),
          emoji: '🎬',
        ),
        ExpenseCategory(
          name: 'Рестораны',
          amount: 2450,
          color: Color(0xFFFF7043),
          emoji: '🍽️',
        ),
        ExpenseCategory(
          name: 'Продукты',
          amount: 980,
          color: Color(0xFF66BB6A),
          emoji: '🛒',
        ),
      ],
    ),
    WeeklyExpenseDay(
      label: 'Вс',
      dateLabel: '18 мая',
      categories: [
        ExpenseCategory(
          name: 'Продукты',
          amount: 2100,
          color: Color(0xFF66BB6A),
          emoji: '🛒',
        ),
        ExpenseCategory(
          name: 'Здоровье',
          amount: 1950,
          color: Color(0xFF26A69A),
          emoji: '💊',
        ),
        ExpenseCategory(
          name: 'Рестораны',
          amount: 1250,
          color: Color(0xFFFF7043),
          emoji: '🍽️',
        ),
      ],
    ),
  ];

  static const List<WeeklyExpenseDay> monthWeeks = [
    WeeklyExpenseDay(
      label: '1 нед',
      dateLabel: '1-7 мая',
      categories: [
        ExpenseCategory(
          name: 'Жилье',
          amount: 9000,
          color: Color(0xFF5C6BC0),
          emoji: '🏠',
        ),
        ExpenseCategory(
          name: 'Продукты',
          amount: 5100,
          color: Color(0xFF66BB6A),
          emoji: '🛒',
        ),
        ExpenseCategory(
          name: 'Транспорт',
          amount: 2100,
          color: Color(0xFF42A5F5),
          emoji: '🚇',
        ),
        ExpenseCategory(
          name: 'Рестораны',
          amount: 2600,
          color: Color(0xFFFF7043),
          emoji: '🍽️',
        ),
        ExpenseCategory(
          name: 'Прочее',
          amount: 4000,
          color: Color(0xFF8D6E63),
          emoji: '📦',
        ),
      ],
    ),
    WeeklyExpenseDay(
      label: '2 нед',
      dateLabel: '8-14 мая',
      categories: [
        ExpenseCategory(
          name: 'Жилье',
          amount: 9000,
          color: Color(0xFF5C6BC0),
          emoji: '🏠',
        ),
        ExpenseCategory(
          name: 'Продукты',
          amount: 4300,
          color: Color(0xFF66BB6A),
          emoji: '🛒',
        ),
        ExpenseCategory(
          name: 'Шоппинг',
          amount: 2900,
          color: Color(0xFFEC407A),
          emoji: '🛍️',
        ),
        ExpenseCategory(
          name: 'Рестораны',
          amount: 3300,
          color: Color(0xFFFF7043),
          emoji: '🍽️',
        ),
        ExpenseCategory(
          name: 'Развлечения',
          amount: 2200,
          color: Color(0xFFFFCA28),
          emoji: '🎬',
        ),
        ExpenseCategory(
          name: 'Связь и интернет',
          amount: 3150,
          color: Color(0xFF26C6DA),
          emoji: '📶',
        ),
      ],
    ),
    WeeklyExpenseDay(
      label: '3 нед',
      dateLabel: '15-21 мая',
      categories: [
        ExpenseCategory(
          name: 'Жилье',
          amount: 9000,
          color: Color(0xFF5C6BC0),
          emoji: '🏠',
        ),
        ExpenseCategory(
          name: 'Продукты',
          amount: 4700,
          color: Color(0xFF66BB6A),
          emoji: '🛒',
        ),
        ExpenseCategory(
          name: 'Рестораны',
          amount: 2800,
          color: Color(0xFFFF7043),
          emoji: '🍽️',
        ),
        ExpenseCategory(
          name: 'Шоппинг',
          amount: 3100,
          color: Color(0xFFEC407A),
          emoji: '🛍️',
        ),
        ExpenseCategory(
          name: 'Транспорт',
          amount: 2100,
          color: Color(0xFF42A5F5),
          emoji: '🚇',
        ),
        ExpenseCategory(
          name: 'Развлечения',
          amount: 1900,
          color: Color(0xFFFFCA28),
          emoji: '🎬',
        ),
        ExpenseCategory(
          name: 'Здоровье',
          amount: 3100,
          color: Color(0xFF26A69A),
          emoji: '💊',
        ),
      ],
    ),
    WeeklyExpenseDay(
      label: '4 нед',
      dateLabel: '22-31 мая',
      categories: [
        ExpenseCategory(
          name: 'Жилье',
          amount: 9000,
          color: Color(0xFF5C6BC0),
          emoji: '🏠',
        ),
        ExpenseCategory(
          name: 'Продукты',
          amount: 4300,
          color: Color(0xFF66BB6A),
          emoji: '🛒',
        ),
        ExpenseCategory(
          name: 'Рестораны',
          amount: 2100,
          color: Color(0xFFFF7043),
          emoji: '🍽️',
        ),
        ExpenseCategory(
          name: 'Шоппинг',
          amount: 2200,
          color: Color(0xFFEC407A),
          emoji: '🛍️',
        ),
        ExpenseCategory(
          name: 'Транспорт',
          amount: 1600,
          color: Color(0xFF42A5F5),
          emoji: '🚇',
        ),
        ExpenseCategory(
          name: 'Развлечения',
          amount: 2300,
          color: Color(0xFFFFCA28),
          emoji: '🎬',
        ),
        ExpenseCategory(
          name: 'Здоровье',
          amount: 1300,
          color: Color(0xFF26A69A),
          emoji: '💊',
        ),
        ExpenseCategory(
          name: 'Подписки',
          amount: 1900,
          color: Color(0xFFAB47BC),
          emoji: '🎧',
        ),
        ExpenseCategory(
          name: 'Прочее',
          amount: 1650,
          color: Color(0xFF8D6E63),
          emoji: '📦',
        ),
      ],
    ),
  ];

  static double get totalExpenses =>
      categories.fold<double>(0, (sum, category) => sum + category.amount);

  static List<ExpenseCategory> get topFive {
    final sorted = [...categories]
      ..sort((left, right) => right.amount.compareTo(left.amount));
    return sorted.take(5).toList();
  }

  static List<double> get weekTrend =>
      weekDays.map((day) => day.total).toList(growable: false);

  static List<String> get weekLabels =>
      weekDays.map((day) => day.label).toList(growable: false);

  static List<double> get monthTrend =>
      monthWeeks.map((week) => week.total).toList(growable: false);

  static List<String> get monthLabels =>
      monthWeeks.map((week) => week.label).toList(growable: false);

  static WeeklyExpenseDay dayAt(int index) {
    final safeIndex = index.clamp(0, weekDays.length - 1);
    return weekDays[safeIndex];
  }

  static List<ExpenseCategory> topFiveForDay(int index) {
    final sorted = [...dayAt(index).categories]
      ..sort((left, right) => right.amount.compareTo(left.amount));
    return sorted.take(5).toList();
  }

  static WeeklyExpenseDay monthWeekAt(int index) {
    final safeIndex = index.clamp(0, monthWeeks.length - 1);
    return monthWeeks[safeIndex];
  }

  static List<ExpenseCategory> topFiveForMonthWeek(int index) {
    final sorted = [...monthWeekAt(index).categories]
      ..sort((left, right) => right.amount.compareTo(left.amount));
    return sorted.take(5).toList();
  }

  static double get spentRatio => totalExpenses / monthlyBudget;

  // Добавить после существующих полей — расходы по дням для BudgetScreen
  static final Map<int, Map<String, double>> dailyExpenses = {
    1: {'Продукты': 1200, 'Транспорт': 300},
    2: {'Рестораны': 2100, 'Транспорт': 250},
    3: {'Продукты': 850, 'Здоровье': 1500},
    4: {'Жилье': 36000},
    5: {'Продукты': 1100, 'Развлечения': 900},
    6: {'Шоппинг': 3200, 'Транспорт': 400},
    7: {'Продукты': 750, 'Рестораны': 1800},
    8: {'Подписки': 599, 'Связь и интернет': 650},
    9: {'Продукты': 1350, 'Транспорт': 280},
    10: {'Рестораны': 2400, 'Развлечения': 1200},
    11: {'Продукты': 920, 'Здоровье': 800},
    12: {'Шоппинг': 2100, 'Транспорт': 350},
    13: {'Продукты': 680, 'Рестораны': 1600},
    14: {'Развлечения': 1500, 'Транспорт': 420},
    15: {'Продукты': 1100, 'Прочее': 600},
    16: {'Рестораны': 1900, 'Связь и интернет': 900},
    17: {'Продукты': 1050, 'Транспорт': 300},
    18: {'Шоппинг': 1800, 'Здоровье': 700},
    19: {'Продукты': 870, 'Развлечения': 800},
    20: {'Рестораны': 2200, 'Транспорт': 380},
    21: {'Продукты': 1200, 'Прочее': 900},
    22: {'Шоппинг': 1100, 'Транспорт': 260},
    23: {'Продукты': 950, 'Подписки': 299},
    24: {'Рестораны': 1700, 'Развлечения': 1100},
    25: {'Продукты': 800, 'Здоровье': 600},
    26: {'Транспорт': 320, 'Прочее': 450},
    27: {'Продукты': 1100, 'Рестораны': 1400},
    28: {'Шоппинг': 2000, 'Транспорт': 300},
    29: {'Продукты': 750, 'Развлечения': 650},
    30: {'Рестораны': 1200, 'Прочее': 400},
    31: {'Продукты': 900, 'Транспорт': 280},
  };

static double spentForRange(int fromDay, int toDay) {
  double total = 0;
  for (int d = fromDay; d <= toDay; d++) {
    final day = dailyExpenses[d];
    if (day != null) total += day.values.fold(0, (a, b) => a + b);
  }
  return total;
}

static Map<String, double> categorySpentForRange(int fromDay, int toDay) {
  final result = <String, double>{};
  for (int d = fromDay; d <= toDay; d++) {
    dailyExpenses[d]?.forEach((cat, amount) {
      result[cat] = (result[cat] ?? 0) + amount;
    });
  }
  return result;
}

}
