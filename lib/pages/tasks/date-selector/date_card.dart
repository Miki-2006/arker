import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kancha/styles/text/styled_text.dart';

class DateCard extends StatelessWidget {
  final double width;
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isHaveTask;

  const DateCard({
    super.key,
    required this.width,
    required this.date,
    required this.isSelected,
    required this.onTap,
    this.isHaveTask = false,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: BoxBorder.all(color: Colors.white, width: 2),
              color: isSelected ? Color(0xFF1689ef) : Colors.transparent,
              boxShadow: [
                BoxShadow(
                  offset: Offset(1, 8),
                  blurRadius: 18,
                  spreadRadius: 0,
                  color: Color.fromRGBO(176, 176, 176, 0.1),
                ),
                BoxShadow(
                  offset: Offset(3, 32),
                  blurRadius: 32,
                  spreadRadius: 0,
                  color: Color.fromRGBO(176, 176, 176, 0.09),
                ),
                BoxShadow(
                  offset: Offset(6, 72),
                  blurRadius: 44,
                  spreadRadius: 0,
                  color: Color.fromRGBO(176, 176, 176, 0.05),
                ),
                BoxShadow(
                  offset: Offset(10, 129),
                  blurRadius: 52,
                  spreadRadius: 0,
                  color: Color.fromRGBO(176, 176, 176, 0.01),
                ),
                BoxShadow(
                  offset: Offset(16, 201),
                  blurRadius: 56,
                  spreadRadius: 0,
                  color: Color.fromRGBO(176, 176, 176, 0.0),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledText(
                  content: DateFormat.MMM().format(date),
                  weight: 600,
                  color: isSelected ? 0xFFFFFFFF : 0xFF1689ef,
                ),
                StyledText(content: '${date.day}', color: isSelected ? 0xFFFFFFFF : 0xFF1689ef),
                const SizedBox(height: 6),
                StyledText(
                  content: DateFormat.E().format(date),
                  color: isSelected ? 0xFFFFFFFF : 0xFF1689ef,
                ),
              ],
            ),
          ),
          if (isHaveTask)
            Positioned(
              top: 5,
              right: 11,
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.deepOrange, // цвет индикатора
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
