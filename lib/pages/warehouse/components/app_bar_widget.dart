import 'package:flutter/material.dart';
import 'package:kancha/styles/text/styled_text.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  const AppBarWidget({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: StyledText(content: 'Склад', color: 0xFF000000, size: 24),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
          child: Container(
            height: 40,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
              color: Color(0xFFf3f3f3),
              
            ),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              controller: tabController,
              labelStyle: TextStyle(
                fontFamily: 'Ubuntu Condensed',
                fontSize: 20,
              ),
              indicator: BoxDecoration(
                color: Color(0xFF29466C), // фон выбранной вкладки
                borderRadius: BorderRadius.circular(22),
              ),
              labelColor: Colors.white, // цвет текста выбранной вкладки
              indicatorColor: Colors.white,
              tabs: const [
                Text('Материалы'),
                Text('Продукты'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 50);
}
