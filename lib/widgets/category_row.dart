import 'package:flutter/material.dart';

import '../models/expense_category.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({
    super.key,
    required this.category,
    required this.amountText,
    this.showPercentage = false,
    this.total = 1,
  });

  final ExpenseCategory category;
  final String amountText;
  final bool showPercentage;
  final double total;

  @override
  Widget build(BuildContext context) {
    final percent = total == 0 ? 0 : ((category.amount / total) * 100).round();

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE4E7EC)),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: category.color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              category.emoji,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              category.name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          if (showPercentage) ...[
            Text(
              '$percent%',
              style: const TextStyle(
                color: Color(0xFF98A2B3),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Text(
            amountText,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
