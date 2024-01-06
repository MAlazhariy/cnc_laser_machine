import 'package:elaser/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Selector<DashboardProvider, int>(
      selector: (context, dashboardProvider) => dashboardProvider.index,
      shouldRebuild: (p, c) => p != c,
      builder: (context, index, _){
        return Scaffold(
          body: Provider.of<DashboardProvider>(context, listen: false).currentScreen,
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: index,
            onTap: (i) => Provider.of<DashboardProvider>(context, listen: false).updateIndex(i),
            items: Provider.of<DashboardProvider>(context, listen: false).salomonItems,
          ),
        );
      },
    );
  }
}
