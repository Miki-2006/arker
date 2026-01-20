import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kancha/styles/text/styled_text.dart';

class ProfileRow extends StatelessWidget {
  final String label;
  final String value;
  final List<List> icon;

  const ProfileRow({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HugeIcon(icon: icon, color: Colors.black, size: 28,),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledText(content: label, color: 0xFF000000, style: 'italic', family: 'Anonymous Pro',),
                const SizedBox(height: 4),
                StyledText(content: value, color: 0xFF000000, family: 'Noto Sans Math', weight: 900,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
