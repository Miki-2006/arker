import 'package:flutter/material.dart';
import 'package:kancha/styles/text/styled_text.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String description;
  final int price;
  final List? rawMaterialsId;

  const JobCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    this.rawMaterialsId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            /// Верхний ряд: Слева fromUser, справа toUser
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StyledText(content: title,),
                Text(" - "),
                StyledText(content: price.toString())
              ],
            )
          ],
        ),
      ),
    );
  }
}
