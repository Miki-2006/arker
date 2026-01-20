import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kancha/models/notification_model.dart';
import 'package:kancha/pages/home/notifications/components/notification_card.dart';
import 'package:kancha/providers/notification_provider.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:kancha/widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      // ignore: use_build_context_synchronously
      () => context.read<NotificationProvider>().loadNotifications('0906e2b5-4f7c-49c9-93c4-b83626af023f'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notificationProvider = context.watch<NotificationProvider>();

    return Scaffold(
      appBar: AppBar(
        title: StyledText(content: 'Уведомления', color: 0xFF000000, size: 24),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedSquareArrowLeft01,
            color: Colors.black,
            size: 34,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[200]),
        child:
            notificationProvider.error != null
                ? Center(child: Text('Ошибка: ${notificationProvider.error}'))
                : !notificationProvider.isLoaded
                ? LoaderWidget()
                : _buildNotificationList(notificationProvider.notifications),
      ),
    );
  }

  Widget _buildNotificationList(List<NotificationModel> allNotifications) {
    final notifications = allNotifications.toList();

    if (notifications.isEmpty) {
      return Center(
        child: StyledText(content: 'Нету уведомлений', color: 0xFF5F33E1, size: 20,)
      );
    }

    return ListView.builder(
      itemBuilder:
          (_, i) => NotificationCard(
            id: notifications[i].id,
            title: notifications[i].title,
            createdAt: notifications[i].createdAt,
            detail: notifications[i].detail,
            isRead: notifications[i].isRead,
          ),
      itemCount: notifications.length,
      padding: EdgeInsets.only(top: 10),
    );
  }
}
