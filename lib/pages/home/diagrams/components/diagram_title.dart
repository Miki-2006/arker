import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kancha/styles/text/styled_text.dart';

class DiagramTitle extends StatelessWidget {
  final List<int> dropdownList;
  final int? value;
  final ValueChanged<int?> onValueChanged;

  const DiagramTitle({
    super.key,
    this.value,
    required this.dropdownList,
    required this.onValueChanged,
  });

  String dropdownValue(int v) {
    switch (v) {
      case 31:
        return 'месяц';
      case 365:
        return 'год';
      default:
        return 'неделя';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StyledText(
              content: 'Заработок',
              color: 0xFF9291A5,
              family: 'Anonymous Pro',
              style: 'italic',
            ),
            StyledText(
              content: '\$12.7k',
              color: 0xFF1E1B39,
              family: 'Noto Sans Math',
              weight: 900,
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            color: Color(0xFFf8f8ff),
            borderRadius: BorderRadius.all(Radius.circular(11))
          ),
          child: DropdownButton<int>(
            value: value,
            items:
                dropdownList.map<DropdownMenuItem<int>>((int v) {
                  return DropdownMenuItem<int>(
                    value: v,
                    child: Text(dropdownValue(v)),
                  );
                }).toList(),
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedArrowDown01,
              color: Color(0xFF615e83),
            ),
            isDense: true,
            underline: Container(),
            style: TextStyle(color: Color(0xFF615e83)),
            onChanged: onValueChanged,
          ),
        ),
      ],
    );
  }
}
