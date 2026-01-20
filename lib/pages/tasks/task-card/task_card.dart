import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:kancha/models/task_model.dart';
import 'package:kancha/styles/text/styled_text.dart';

class TaskCard extends StatelessWidget {
  final String fromUser;
  final String toUser;
  final String title;
  final String description;
  final DateTime time; // Новый тип: DateTime
  final TaskStatus status; // Новый тип: enum

  const TaskCard({
    super.key,
    required this.fromUser,
    required this.toUser,
    required this.title,
    required this.description,
    required this.time,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.1)),
        color: _statusColor(status)
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            /// Верхний ряд: Слева fromUser, справа toUser
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _UserTag(label: 'Кто', name: fromUser, alignRight: false),
                _UserTag(label: 'Кому', name: toUser, alignRight: true),
              ],
            ),

            const SizedBox(height: 12),

            /// Заголовок и описание
            Align(
              alignment: Alignment.centerLeft,
              child: StyledText(content: title, color: 0xFF000000, family: 'Sofia Sans', weight: 900, size: 20,)
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: StyledText(content: description, color: 0xFF000000,)
            ),

            const SizedBox(height: 12),

            /// Нижний ряд: время и статус
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    HugeIcon(icon: HugeIcons.strokeRoundedTime04, color: Colors.grey[400],),
                    SizedBox(width: 5,),
                    StyledText(content: DateFormat('HH:mm').format(time), color: 0xFF000000,)
                  ],
                ),
                // Container(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 12,
                //     vertical: 6,
                //   ),
                //   decoration: BoxDecoration(
                //     color: _statusColor(status),
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                // ),
                StyledText(content: statusToString(status), color: 0xFF000000)
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Цвет по статусу
  Color _statusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.done:
        return Colors.green;
      case TaskStatus.pending:
        return Colors.orange;
      case TaskStatus.toDo:
        return Colors.red;
    }
  }
}

class _UserTag extends StatelessWidget {
  final String label;
  final String name;
  final bool alignRight;

  const _UserTag({
    required this.label,
    required this.name,
    required this.alignRight,
  });

  @override
  Widget build(BuildContext context) {
    final content = RichText(
      text: TextSpan(
        text: '$label: ',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Colors.grey[600],
          fontSize: 14,
          fontStyle: FontStyle.italic,
          fontFamily: 'Anonymous Pro'
        ),
        children: [
          TextSpan(
            text: name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Martian Mono',
              fontStyle: FontStyle.normal
            ),
          ),
        ],
      ),
    );

    return alignRight
        ? Align(alignment: Alignment.centerRight, child: content)
        : Align(alignment: Alignment.centerLeft, child: content);
  }
}
