import 'package:flutter/material.dart';
import 'package:kancha/pages/auth/login/login_page.dart';
import 'package:kancha/pages/auth/signup/signup_page.dart';
import 'package:kancha/widgets/logo_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title: LogoWidget(),
            bottom: TabBar(
              tabs: [Tab(text: 'Вход'), Tab(text: 'Регистрация')],
              dividerColor: Colors.white,
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Manrope',
              ),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2.0, // Толщина линии
                  color: Colors.blue, // Цвет линии (можно задать свой)
                ),
                insets: EdgeInsets.symmetric(
                  horizontal: -30.0,
                ), // Отступы (увеличивает длину линии)
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: TabBarView(children: [LoginPage(), SignupPage()]),
        ),
      ),
    );
  }
}
