import 'package:easy_localization/easy_localization.dart';
import 'package:elaser/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_rounded),
            title: Text("home".tr()),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.shopping_bag),
            title: Text("my_orders".tr()),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.notifications),
            title: Text("notifications".tr()),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.more_horiz),
            title: Text("settings".tr()),
          ),
        ],
      ),
    );
  }
}
