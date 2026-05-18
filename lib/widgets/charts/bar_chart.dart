import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  const BarChart({
    super.key,
    required this.values,
    this.labels,
    this.selectedIndex,
    this.onBarTap,
  });

  final List<double> values;
  final List<String>? labels;
  final int? selectedIndex;
  final ValueChanged<int>? onBarTap;

  @override
  Widget build(BuildContext context) {
    final max = values.fold<double>(0, (m, v) => v > m ? v : m);
    return Container(
      height: 134,
      padding: const EdgeInsets.fromLTRB(6, 10, 6, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE4E7EC)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(values.length, (index) {
          final value = values[index];
          final selected = selectedIndex == null
              ? index == values.length - 2
              : index == selectedIndex;
          final barHeight = max == 0 ? 0.0 : (value / max) * 70 + 12;
          final label = labels != null && labels!.length > index
              ? labels![index]
              : '${index + 1}';
          return Expanded(
            child: GestureDetector(
              onTap: onBarTap == null ? null : () => onBarTap!(index),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOut,
                    width: 14,
                    height: barHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: selected
                          ? const Color(0xFF2E90FA)
                          : const Color(0xFFDAECFF),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: TextStyle(
                      color: selected
                          ? const Color(0xFF2E90FA)
                          : const Color(0xFF98A2B3),
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
