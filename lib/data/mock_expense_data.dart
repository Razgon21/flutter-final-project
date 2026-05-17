import 'package:flutter/material.dart';

import '../models/expense_category.dart';

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

  static const List<double> weekTrend = [
    2.8,
    3.1,
    2.6,
    3.7,
    3.3,
    4.1,
    3.5,
  ];

  static const List<double> monthTrend = [
    1.2,
    1.8,
    1.3,
    1.6,
    1.9,
    2.3,
    2.8,
    2.5,
  ];

  static double get totalExpenses =>
      categories.fold<double>(0, (sum, category) => sum + category.amount);

  static List<ExpenseCategory> get topFive {
    final sorted = [...categories]
      ..sort((left, right) => right.amount.compareTo(left.amount));
    return sorted.take(5).toList();
  }

  static double get spentRatio => totalExpenses / monthlyBudget;
}
