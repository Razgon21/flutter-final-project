import 'package:flutter/material.dart';
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

  void _openNewExpense() {
    Navigator.of(context).push(slideUpRoute(const NewExpenseScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          HomeScreen(),
          BudgetScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomMenu(
        selectedIndex: _index,
        onTabSelected: (index) => setState(() => _index = index),
        onCenterPressed: _openNewExpense,
      ),
    );
  }
}
