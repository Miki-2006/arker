import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kancha/models/notification_model.dart';
import 'package:kancha/pages/home/notifications/components/notification_detail.dart';
import 'package:kancha/styles/text/styled_text.dart';

class NotificationCard extends StatelessWidget {
  final String id;
  final String title;
  final String createdAt;
  final Detail detail;
  final bool isRead;

  const NotificationCard({
    super.key,
    required this.id,
    required this.title,
    required this.createdAt,
    required this.detail,
    required this.isRead,
  });

  String _differOfDates(String time) {
    DateTime now = DateTime.now();
    DateTime notificationCreatedTime = DateTime.parse(time);
    String text;

    int differ = notificationCreatedTime.difference(now).inMinutes;
    if (differ < -60) {
      differ = notificationCreatedTime.difference(now).inHours;
      text = '${differ.abs()}ч назад';
      return text;
    }
    text = '${differ.abs()}м назад';
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
      elevation: 5,
      shadowColor: isRead ? Colors.white : Color(0xFF5F33E1),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
        side: BorderSide(color: isRead ? Colors.white : Color(0xFF5F33E1)),
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
                    icon:
                        detail.table == 'others'
                            ? HugeIcons.strokeRoundedNotificationBubble
                            : detail.table == 'warehouse'
                            ? HugeIcons.strokeRoundedWarehouse
                            : HugeIcons.strokeRoundedCheckmarkSquare03,
                    size: 26,
                    color: isRead ? Colors.black : Color(0xFF5F33E1),
                  ),
                ),
                Expanded(
                  child: StyledText(content: title, family: 'Sofia Sans', color: 0xFF000000, weight: 700,)
                ),
                isRead
                    ? Text('')
                    : StyledText(content: _differOfDates(createdAt), color: 0x66000000, style: 'italic', family: 'Anonymous Pro',)
              ],
            ),
            NotificationDetail(notificationId: id, isRead: isRead,),
          ],
        ),
      ),
    );
  }
}
