import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class AddButtonWidget extends StatelessWidget {
  final VoidCallback add;
  final String? label;

  const AddButtonWidget({super.key, required this.add, this.label});

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(label!, style: TextStyle(color: Color(0xFF5F33E1), fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(width: 5),
          FloatingActionButton(
            onPressed: add,
            backgroundColor: Colors.white,
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedAddSquare,
              size: 34,
              color: Color(0xFF5F33E1),
            ),
          ),
        ],
      );
    }
    return FloatingActionButton(
      onPressed: add,
      backgroundColor: Colors.white,
      child: HugeIcon(
        icon: HugeIcons.strokeRoundedAddSquare,
        size: 34,
        color: Colors.black,
      ),
    );
  }
}
