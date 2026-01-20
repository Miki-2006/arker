import 'package:kancha/models/balanc_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BalancService {
  static final _client = Supabase.instance.client;

  static Future<BalancModel> getBalancOfUser(String userId) async {
    try {
      final res =
          await _client.from('balanc').select().eq('user_id', userId).single();

      return BalancModel.fromJson(res);
    } catch (e) {
      throw Exception('Ошибка при получении баланса пользователя $e');
    }
  }
}
