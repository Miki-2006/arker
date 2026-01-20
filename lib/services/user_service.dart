import 'package:kancha/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  static final _client = Supabase.instance.client;

  static Future<UserModel> getUser(String id) async {
    try {
      final res =
          await _client
              .from('users')
              .select('*, company: companies!company_id(*)')
              .eq('id', id)
              .limit(1)
              .single();

      return UserModel.fromJson(res);
    } catch (e) {
      throw Exception('Ошибка при получении пользователя $e');
    }
  }

  static Future<List<UserModel>> getAllUsers(String companyId) async {
    try {
      final res = await _client
          .from('users')
          .select()
          .eq('company_id', companyId);

      final data = res as List;
      return data.map((el) => UserModel.fromJson(el)).toList();
    } catch (e) {
      throw Exception('Ошибка при получении пользователя $e');
    }
  }
}
