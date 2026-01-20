import 'package:kancha/models/product_model.dart';
import 'package:kancha/models/raw_material_model.dart';

class RawMaterialWarehouseModel {
  final String? id;
  final RawMaterialModel rawMaterial;
  final double count;
  final String companyId;

  RawMaterialWarehouseModel({
    this.id,
    required this.count,
    required this.rawMaterial,
    required this.companyId,
  });

  factory RawMaterialWarehouseModel.fromJson(Map<String, dynamic> json) {
    return RawMaterialWarehouseModel(
      id: json['id'],
      rawMaterial: RawMaterialModel.fromJson(json['raw_material']),
      count: (json['count'] as num).toDouble(),
      companyId: json['company_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'raw_material_id': rawMaterial.id,
      'count': count,
      'company_id': companyId,
    };
  }
}

class ProductWarehouseModel {
  final String? id;
  final ProductModel product;
  final double count;
  final String companyId;

  ProductWarehouseModel({
    this.id,
    required this.count,
    required this.product,
    required this.companyId,
  });

  factory ProductWarehouseModel.fromJson(Map<String, dynamic> json) {
    return ProductWarehouseModel(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
      count: (json['count'] as num).toDouble(),
      companyId: json['company_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': product.id,
      'count': count,
      'company_id': companyId,
    };
  }
}