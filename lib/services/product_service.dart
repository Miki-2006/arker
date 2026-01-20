import 'package:kancha/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  static final _client = Supabase.instance.client;

  static Future<List<ProductModel>> getProducts(String companyId) async {
    try {
      final res = await _client.from('products').select().eq('company_id', companyId);
      final data = res as List;

      return data.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Ошибка при получении продуктов: $e');
    }
  }

  // static Future<void> addNewRawMaterial(RawMaterialModel rawMaterial) async {
  //   try {
  //     final response = await _client
  //         .from('raw_materials')
  //         .insert(rawMaterial.toJson());
  //     // ignore: avoid_print
  //     print('Inserted: $response');
  //   } catch (e) {
  //     // ignore: avoid_print
  //     print('Error adding raw material: $e');
  //     rethrow;
  //   }
  // }
}
