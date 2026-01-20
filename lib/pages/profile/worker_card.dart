import 'package:flutter/material.dart';
import 'package:kancha/styles/text/styled_text.dart';

class WorkerCard extends StatelessWidget {
  final String firstName;
  final String secondName;
  final String workerRole;

  const WorkerCard({
    super.key,
    required this.firstName,
    required this.secondName,
    required this.workerRole,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
            radius: 24,
            backgroundColor: Colors.blue,
            child: CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/images/avatar4.png'),
            ),
          ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StyledText(content: firstName, color: 0xFF000000, family: 'Martian Mono', weight: 500, size: 16,),
                    SizedBox(width: 4,),
                    StyledText(content: secondName, color: 0xFF000000, family: 'Martian Mono', weight: 500, size: 16,)
                  ],
                ),
                StyledText(content: workerRole, color: 0xFF000000, style: 'italic',),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
