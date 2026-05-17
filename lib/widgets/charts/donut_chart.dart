import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../models/expense_category.dart';

class DonutChart extends StatelessWidget {
  const DonutChart({
    super.key,
    required this.categories,
    required this.center,
    this.size = 220,
    this.strokeWidth = 34,
  });

  final List<ExpenseCategory> categories;
  final Widget center;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size.square(size),
            painter: _DonutPainter(
              categories: categories,
              strokeWidth: strokeWidth,
            ),
          ),
          center,
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  const _DonutPainter({
    required this.categories,
    required this.strokeWidth,
  });

  final List<ExpenseCategory> categories;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final total = categories.fold<double>(0, (sum, c) => sum + c.amount);
    if (total <= 0) return;

    final radius = math.min(size.width, size.height) / 2 - strokeWidth / 2;
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    );
    var start = -math.pi / 2;

    for (final category in categories) {
      final sweep = (category.amount / total) * 2 * math.pi;
      final paint = Paint()
        ..color = category.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(rect, start, sweep, false, paint);
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) {
    return oldDelegate.categories != categories ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
