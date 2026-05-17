import 'package:flutter/material.dart';

class CustomBottomMenu extends StatelessWidget {
  const CustomBottomMenu({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.onCenterPressed,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onCenterPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 6, 16, 14),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _TabItem(
              title: 'Главная',
              icon: Icons.home_filled,
              selected: selectedIndex == 0,
              onTap: () => onTabSelected(0),
            ),
            GestureDetector(
              onTap: onCenterPressed,
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 76,
                height: 60,
                alignment: Alignment.center,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E90FA),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
            _TabItem(
              title: 'Планирование бюджета',
              icon: Icons.calendar_month_rounded,
              selected: false,
              enabled: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.title,
    required this.icon,
    required this.selected,
    this.onTap,
    this.enabled = true,
  });

  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final color = !enabled
        ? const Color(0xFFB5BFCB)
        : selected
            ? const Color(0xFF2E90FA)
            : const Color(0xFF98A2B3);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: enabled ? 84 : 110,
        height: enabled ? 56 : 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 3),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: enabled ? 1 : 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: enabled ? 12 : 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
