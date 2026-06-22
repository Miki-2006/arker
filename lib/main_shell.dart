import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:arker/core/responsive/responsive.dart';
import 'package:arker/pages/warehouse/warehouse_page.dart';
import 'package:arker/pages/home/home_page.dart';
import 'package:arker/pages/profile/profile_page.dart';
import 'package:arker/pages/tasks/task_page.dart';
import 'package:arker/widgets/navbar_widget.dart';

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

  static const _destinations = [
    _ShellDestination(label: 'Home', icon: HugeIcons.strokeRoundedHome03),
    _ShellDestination(
      label: 'Tasks',
      icon: HugeIcons.strokeRoundedCheckmarkSquare03,
    ),
    _ShellDestination(
      label: 'Warehouse',
      icon: HugeIcons.strokeRoundedWarehouse,
    ),
    _ShellDestination(
      label: 'Profile',
      icon: HugeIcons.strokeRoundedUserSquare,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      body:
          isDesktop
              ? Row(
                children: [
                  _DesktopNavigationRail(
                    currentPageIndex: currentPageIndex,
                    destinations: _destinations,
                    onIndexChanged:
                        (index) => setState(() => currentPageIndex = index),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(child: _pages[currentPageIndex]),
                ],
              )
              : _pages[currentPageIndex],
      bottomNavigationBar:
          isDesktop
              ? null
              : NavbarWidget(
                currentPageIndex: currentPageIndex,
                onIndexChanged: (index) {
                  setState(() => currentPageIndex = index);
                },
              ),
    );
  }
}

class _DesktopNavigationRail extends StatelessWidget {
  final int currentPageIndex;
  final List<_ShellDestination> destinations;
  final ValueChanged<int> onIndexChanged;

  const _DesktopNavigationRail({
    required this.currentPageIndex,
    required this.destinations,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      minExtendedWidth: 220,
      extended: true,
      selectedIndex: currentPageIndex,
      backgroundColor: Colors.white,
      indicatorColor: const Color(0xFFF4F1FD),
      selectedIconTheme: const IconThemeData(color: Color(0xFF613EEA)),
      unselectedIconTheme: const IconThemeData(color: Color(0xFF9DB2CE)),
      selectedLabelTextStyle: const TextStyle(
        color: Color(0xFF613EEA),
        fontWeight: FontWeight.w700,
        fontFamily: 'Manrope',
      ),
      unselectedLabelTextStyle: const TextStyle(
        color: Color(0xFF60708A),
        fontWeight: FontWeight.w500,
        fontFamily: 'Manrope',
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Image.asset(
          'assets/images/arkerLogo.jpg',
          width: 72,
          height: 72,
          fit: BoxFit.cover,
        ),
      ),
      destinations:
          destinations
              .map(
                (destination) => NavigationRailDestination(
                  icon: HugeIcon(
                    icon: destination.icon,
                    size: 24,
                    color: const Color(0xFF9DB2CE),
                  ),
                  selectedIcon: HugeIcon(
                    icon: destination.icon,
                    size: 24,
                    color: const Color(0xFF613EEA),
                  ),
                  label: Text(destination.label),
                ),
              )
              .toList(),
      onDestinationSelected: onIndexChanged,
    );
  }
}

class _ShellDestination {
  final String label;
  final dynamic icon;

  const _ShellDestination({required this.label, required this.icon});
}
