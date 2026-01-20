import 'package:kancha/models/warehouse_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WarehouseService {
  static final _client = Supabase.instance.client;

  static Future<List<RawMaterialWarehouseModel>> getMaterialsInWarehouse(
    String companyId,
  ) async {
    try {
      final res = await _client
          .from('raw_material_warehouse')
          .select('*, raw_material: raw_materials!raw_material_id(*)')
          .eq('company_id', companyId);
      final data = res as List;

      return data.map((e) => RawMaterialWarehouseModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Ошибка при получении данных склада сырьи $e');
    }
  }


  static Future<void> addSavings(RawMaterialWarehouseModel item) async {
    try {
      await _client.from('raw_material_warehouse').insert(item);
    } catch (e) {
      throw Exception("Error adding item to warehouse $e");
    }
  }





  static Future<List<ProductWarehouseModel>> getProductsInWarehouse(
    String companyId,
  ) async {
    try {
      final res = await _client
          .from('product_warehouse')
          .select('*, product: products!product_id(*)')
          .eq('company_id', companyId);
      final data = res as List;

      return data.map((e) => ProductWarehouseModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Ошибка при получении данных склада продуктов $e');
    }
  }
}
