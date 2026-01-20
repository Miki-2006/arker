import 'package:flutter/material.dart';
import 'package:kancha/pages/warehouse/warehouse_page.dart';
import 'package:kancha/pages/home/home_page.dart';
import 'package:kancha/pages/profile/profile_page.dart';
import 'package:kancha/pages/tasks/task_page.dart';
import 'package:kancha/widgets/navbar_widget.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int currentPageIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    TaskPage(),
    WarehousePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _pages[currentPageIndex],
      ),
      bottomNavigationBar: NavbarWidget(
        currentPageIndex: currentPageIndex,
        onIndexChanged: (index) {
          setState(() => currentPageIndex = index);
        },
      ),
    );
  }
}
