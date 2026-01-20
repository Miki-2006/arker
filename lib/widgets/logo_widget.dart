import 'package:flutter/material.dart';
import 'package:kancha/styles/text/styled_text.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Image.asset(
            "assets/images/arkerLogo.jpg",
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
          StyledText(content: 'ARKER', weight: 900, size: 26, style: 'italic',),
        ],
      ),
    );
  }
}
