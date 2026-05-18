import 'package:flutter/material.dart';

import '../screens/analytics_screen.dart';
import '../screens/budget_screen.dart';
import '../screens/home_screen.dart';
import '../screens/new_expence_screen.dart';
import '../widgets/custom_bottom_menu.dart';
import 'app_routes.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _index = 0;

  void _openAnalytics() {
    Navigator.push(context, slideRightRoute(const AnalyticsScreen()));
  }

  void _openNewExpense() {
    Navigator.push(context, slideUpRoute(const NewExpenseScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeScreen(onOpenAnalytics: _openAnalytics),
      const BudgetScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: CustomBottomMenu(
        selectedIndex: _index,
        onTabSelected: (index) => setState(() => _index = index),
        onCenterPressed: _openNewExpense,
      ),
    );
  }
}
