class CompanyModel {
  final String id;
  final String name;
  final String description;
  final String? logo;

  CompanyModel({
    required this.id,
    required this.name,
    required this.description,
    this.logo,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      if (logo != null) 'logo': logo,
    };
  }
}
