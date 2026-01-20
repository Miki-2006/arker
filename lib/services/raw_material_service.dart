import 'package:kancha/models/raw_material_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RawMaterialService {
  static final _client = Supabase.instance.client;

  static Future<List<RawMaterialModel>> getRawMaterials(
    String companyId,
  ) async {
    try {
      final res = await _client
          .from('raw_materials')
          .select()
          .eq('company_id', companyId);
      final data = res as List;

      return data.map((e) => RawMaterialModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Ошибка при получении данных сырья: $e');
    }
  }

  static Future<RawMaterialModel> getRawMaterial(String id) async {
    try {
      final res =
          await _client.from('raw_materials').select().eq('id', id).single();
      final data = res;
      return RawMaterialModel.fromJson(data);
    } catch (e) {
      throw Exception('Ошибка при получении данных определённого сырья: $e');
    }
  }

  static Future<void> addNewRawMaterial(RawMaterialModel rawMaterial) async {
    try {
      final response = await _client
          .from('raw_materials')
          .insert(rawMaterial.toJson());
      // ignore: avoid_print
      print('Inserted: $response');
    } catch (e) {
      // ignore: avoid_print
      print('Error adding raw material: $e');
      rethrow;
    }
  }
}
