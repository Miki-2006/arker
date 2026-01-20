import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:kancha/models/notification_model.dart';
import 'package:kancha/services/notification_service.dart';

class NotificationProvider with ChangeNotifier {
  final List<NotificationModel> _notifications = [];
  bool _loaded = false;
  String? _error;

  bool get isLoaded => _loaded;
  String? get error => _error;
  UnmodifiableListView<NotificationModel> get notifications =>
      UnmodifiableListView(
        _notifications..sort((a, b) {
          final sorted = (a.isRead ? 1 : 0).compareTo(b.isRead ? 1 : 0);
          if (sorted == 0) {
            return DateTime.parse(
              b.createdAt,
            ).compareTo(DateTime.parse(a.createdAt));
          }
          return sorted;
        }),
      );

  Future<void> loadNotifications(String userId) async {
    _loaded = false;
    _error = null;
    notifyListeners();

    try {
      final fetched = await NotificationService.getNotifications(userId);

      _notifications
        ..clear()
        ..addAll(fetched);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loaded = true;
      notifyListeners();
    }
  }

  Future<void> changeReadStatus(String notificationId, String userId) async {
    _loaded = false;
    _error = null;
    notifyListeners();

    try {
      final updated = await NotificationService.changeReadStatus(
        notificationId,
      );
      if (notificationId == updated.id && updated.isRead) {
        loadNotifications(userId);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _loaded = true;
      notifyListeners();
    }
  }
}
