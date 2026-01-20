class ProductModel {
  final String id;
  final String name;
  final String? description;
  final int price;
  final List<RawMaterialsOfProduct> rawMaterials;
  final String companyId;
  final String createdAt;
  final String? imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.rawMaterials,
    required this.companyId,
    required this.createdAt,
    this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      rawMaterials: (json['raw_materials'] as List<dynamic>).map((e) => RawMaterialsOfProduct.fromJson(e)).toList(),
      companyId: json['company_id'],
      createdAt: json['created_at'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'company_id': companyId,
      'raw_materials': rawMaterials.map((e) => e.toJson()).toList(),
      'created_at': createdAt,
      'image_url': imageUrl,
    };
  }
}

class RawMaterialsOfProduct {
  final String count;
  final String rawMaterialId;

  RawMaterialsOfProduct({required this.count, required this.rawMaterialId});

  factory RawMaterialsOfProduct.fromJson(Map<String, dynamic> json) {
    return RawMaterialsOfProduct(
      count: json['count'],
      rawMaterialId: json['raw_material_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'count': count, 'raw_material_id': rawMaterialId};
  }
}
