import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kancha/pages/home/balanc/balanc_history_screen.dart';
import 'package:kancha/providers/notification_provider.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class UserCardWidget extends StatefulWidget {
  final String userName;
  final VoidCallback onNotificationTap;

  const UserCardWidget({
    super.key,
    required this.userName,
    required this.onNotificationTap,
  });

  @override
  State<UserCardWidget> createState() => _UserCardWidgetState();
}

class _UserCardWidgetState extends State<UserCardWidget> {
  bool unReadNotifications = false;

  @override
  void initState() {
    super.initState();
    final notifications = context.read<NotificationProvider>().notifications;
    final results = notifications.where((map) => map.isRead == false);

    if (results.isNotEmpty) {
      unReadNotifications = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: _navigateToBalancPage,
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedSaveMoneyDollar,
              color: Colors.white,
              size: 26,
            ),
          ),
          StyledText(
            content: widget.userName,
            size: 20,
            family: 'Martian Mono',
            weight: 600,
          ),
          GestureDetector(
            onTap: widget.onNotificationTap,
            child: Stack(
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedNotification01,
                  color: Colors.white,
                  size: 26,
                ),
                if (unReadNotifications)
                  Positioned(
                    top: 0,
                    right: 2,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFF5F33E1), // цвет индикатора
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToBalancPage() {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.leftToRight,
        child: BalancHistoryScreen(),
      ),
    );
  }
}
