import 'package:flutter/material.dart';

import '../screens/analytics_screen.dart';
import '../screens/home_screen.dart';
import '../screens/budget_screen.dart';
import '../screens/new_expence_screen.dart';
import '../widgets/custom_bottom_menu.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _index = 0;

  void _goHome() => setState(() => _index = 0);
  void _goAnalytics() => setState(() => _index = 1);

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeScreen(
        onOpenAnalytics: _goAnalytics,
      ),
      AnalyticsScreen(
        onBackHome: _goHome,
        onOpenBudget: () => _pushBudget(context),
      ),
    ];

    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: CustomBottomMenu(
        selectedIndex: _index,
        onTabSelected: (index) => setState(() => _index = index),
        onCenterPressed: () => _pushNewExpense(context),
      ),
    );
  }

  void _pushBudget(BuildContext context) {
    Navigator.of(context).push(_slideUpRoute(const BudgetScreen()));
  }

  void _pushNewExpense(BuildContext context) {
    Navigator.of(context).push(_slideUpRoute(const NewExpenseScreen()));
  }
}

PageRoute _slideUpRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionDuration: const Duration(milliseconds: 320),
    reverseTransitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder: (_, animation, __, child) {
      final tween = Tween(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOutCubic));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}