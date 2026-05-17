import 'package:flutter/material.dart';

import '../screens/analytics_screen.dart';
import '../screens/home_screen.dart';
import '../widgets/custom_bottom_menu.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeScreen(
        onOpenAnalytics: () => setState(() => _index = 1),
      ),
      AnalyticsScreen(
        onBackHome: () => setState(() => _index = 0),
      ),
    ];

    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: CustomBottomMenu(
        selectedIndex: _index,
        onTabSelected: (index) => setState(() => _index = index),
        onCenterPressed: () {},
      ),
    );
  }
}
