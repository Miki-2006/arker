import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class NavbarWidget extends StatefulWidget {
  final int currentPageIndex;
  final ValueChanged<int> onIndexChanged;

  const NavbarWidget({
    super.key,
    required this.currentPageIndex,
    required this.onIndexChanged,
  });

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 20,
      selectedIconTheme: IconThemeData(color: Color(0xFF613EEA)),
      unselectedIconTheme: IconThemeData(color: Color(0xFF9DB2CE)),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon:
              widget.currentPageIndex == 0
                  ? Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF4F1FD),
                          borderRadius: BorderRadius.all(Radius.circular(44)),
                          // shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedHome03,
                          size: 28,
                          color: Color(0xFF613EEA),
                        ),
                      ),
                      SizedBox(height: 2.5),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF613EEA),
                          shape: BoxShape.circle,
                        ),
                        width: 5,
                        height: 5,
                      ),
                    ],
                  )
                  : HugeIcon(
                    icon: HugeIcons.strokeRoundedHome03,
                    size: 28,
                    color: Color(0xFF9DB2CE),
                  ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon:
              widget.currentPageIndex == 1
                  ? Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF4F1FD),
                          borderRadius: BorderRadius.all(Radius.circular(44)),
                          // shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedCheckmarkSquare03,
                          size: 28,
                          color: Color(0xFF613EEA),
                        ),
                      ),
                      SizedBox(height: 2.5),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF613EEA),
                          shape: BoxShape.circle,
                        ),
                        width: 5,
                        height: 5,
                      ),
                    ],
                  )
                  : HugeIcon(
                    icon: HugeIcons.strokeRoundedCheckmarkSquare03,
                    size: 28,
                    color: Color(0xFF9DB2CE),
                  ),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          icon:
              widget.currentPageIndex == 2
                  ? Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF4F1FD),
                          borderRadius: BorderRadius.all(Radius.circular(44)),
                          // shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedWarehouse,
                          size: 28,
                          color: Color(0xFF613EEA),
                        ),
                      ),
                      SizedBox(height: 2.5),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF613EEA),
                          shape: BoxShape.circle,
                        ),
                        width: 5,
                        height: 5,
                      ),
                    ],
                  )
                  : HugeIcon(
                    icon: HugeIcons.strokeRoundedWarehouse,
                    size: 28,
                    color: Color(0xFF9DB2CE),
                  ),
          label: 'Warehouse',
        ),
        BottomNavigationBarItem(
          icon:
              widget.currentPageIndex == 3
                  ? Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF4F1FD),
                          borderRadius: BorderRadius.all(Radius.circular(44)),
                          // shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedUserSquare,
                          size: 28,
                          color: Color(0xFF613EEA),
                        ),
                      ),
                      SizedBox(height: 2.5),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF613EEA),
                          shape: BoxShape.circle,
                        ),
                        width: 5,
                        height: 5,
                      ),
                    ],
                  )
                  : HugeIcon(
                    icon: HugeIcons.strokeRoundedUserSquare,
                    size: 28,
                    color: Color(0xFF9DB2CE),
                  ),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.currentPageIndex,
      onTap: widget.onIndexChanged,
    );
  }
}
