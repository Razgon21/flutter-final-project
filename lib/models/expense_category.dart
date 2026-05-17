import 'package:flutter/material.dart';

class ExpenseCategory {
  const ExpenseCategory({
    required this.name,
    required this.amount,
    required this.color,
    required this.emoji,
  });

  final String name;
  final double amount;
  final Color color;
  final String emoji;
}
