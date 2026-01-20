
class JobModel {
  final String? id;
  final String title;
  final String description;
  final int price;
  final List? rawMaterialsId;
  final String companyId;

  JobModel({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.companyId,
    this.rawMaterialsId,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      companyId: json['company_id'],
      rawMaterialsId: json['raw_materials_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'company_id': companyId,
      if (rawMaterialsId != null) 'raw_materials_id': rawMaterialsId,
    };
  }
}
