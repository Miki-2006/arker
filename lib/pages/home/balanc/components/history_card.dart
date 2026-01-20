import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kancha/styles/text/styled_text.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
      elevation: 5,
      shadowColor: Color(0xFF5F33E1),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
        side: BorderSide(color: Color(0xFF5F33E1)),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(10),
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedDollarCircle,
                    size: 26,
                    color: Color(0xFF5F33E1),
                  ),
                ),
                Expanded(
                  child: StyledText(content: '+1000', family: 'Sofia Sans', color: 0xFF000000, weight: 700,)
                ),
                StyledText(content: '22-января', color: 0x66000000, style: 'italic', family: 'Anonymous Pro',)
              ],
            ),
          ],
        ),
      ),
    );
  }
}