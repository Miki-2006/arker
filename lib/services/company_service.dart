import 'package:kancha/models/company_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompanyService {
  static final _client = Supabase.instance.client;

  static Future<List<CompanyModel>> getCompanyInfo(String id) async {
    try {
      final res = await _client
          .from('companies')
          .select()
          .eq('id', id);

      final data = res as List;

      return data
          .map((el) => CompanyModel.fromJson(el as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("Error fetching company: $e");
    }
  }
}
