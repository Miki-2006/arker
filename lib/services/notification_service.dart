import 'package:kancha/models/notification_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  static final _client = Supabase.instance.client;

  static Future<List<NotificationModel>> getNotifications(String userId) async {
    try {
      final res = await _client
          .from('notifications')
          .select()
          .eq('user_id', userId);

      final data = res as List;

      return data
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching notifications: $e');
      rethrow;
    }
  }

  static Future<NotificationModel> changeReadStatus(
    String notificationId,
  ) async {
    try {
      final res =
          await _client
              .from('notifications')
              .update({'is_read': true})
              .eq('id', notificationId)
              .select()
              .single();

      final data = res as Map;

      return NotificationModel.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      // ignore: avoid_print
      print('Error in changing status of notification: $e');
      rethrow;
    }
  }
}
