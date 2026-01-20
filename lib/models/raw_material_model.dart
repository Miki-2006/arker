class RawMaterialModel {
  final String? id;
  final String name;
  final String description;
  final String unitOfMeasure;
  final double price;
  final String? image;
  final String companyId;

  RawMaterialModel({
    this.id,
    required this.name,
    required this.description,
    required this.unitOfMeasure,
    required this.price,
    required this.companyId,
    this.image,
  });

  factory RawMaterialModel.fromJson(Map<String, dynamic> json) {
    return RawMaterialModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      unitOfMeasure: json['unit_of_measure'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      companyId: json['company_id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'unit_of_measure': unitOfMeasure,
      'price': price,
      'image': image,
      'company_id': companyId
    };
  }
}
