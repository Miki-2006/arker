import 'package:flutter/material.dart';
import 'package:kancha/pages/home/balanc/balanc_widget.dart';
import 'package:kancha/pages/home/diagrams/salary_diagram.dart';
import 'package:kancha/pages/home/notifications/notifications_screen.dart';
import 'package:kancha/pages/home/user_card_widget.dart';
import 'package:kancha/providers/balanc_provider.dart';
import 'package:kancha/providers/user_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'Пользователь';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<UserProvider>().fetchUser(
        '0906e2b5-4f7c-49c9-93c4-b83626af023f',
      );
    });
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<BalancProvider>().fetchBalanc(
        '0906e2b5-4f7c-49c9-93c4-b83626af023f',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final balanc = context.watch<BalancProvider>().balancOfUser;

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1372F0), Color(0xFF6FADFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 148, 194, 253),
                  spreadRadius: 20,
                  blurRadius: 20,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                UserCardWidget(
                  userName: user?.firstName ?? userName,
                  onNotificationTap: _onNotificationTap,
                ),
                BalancWidget(balanc: balanc),
              ],
            ),
          ),
          SalaryDiagram(),
        ],
      ),
    );
  }

  void _onNotificationTap() {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const NotificationsScreen(),
      ),
    );
  }
}
