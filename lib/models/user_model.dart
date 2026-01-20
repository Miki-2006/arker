import 'package:kancha/models/company_model.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String password;
  final String email;
  final String phone;
  final String companyId;
  final CompanyModel? company;
  final String role;
  final String workerRole;
  final String createdAt;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.companyId,
    required this.email,
    required this.phone,
    required this.role,
    required this.workerRole,
    required this.password,
    required this.createdAt,
    this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      password: json['password'],
      email: json['email'],
      phone: json['phone'],
      companyId: json['company_id'],
      company:
          json['company'] != null
              ? CompanyModel.fromJson(json['company'])
              : null,
      role: json['role'],
      workerRole: json['worker_role'],
      createdAt: json['created_at']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'company_id': companyId,
      'email': email,
      'phone': phone,
      'role': role,
      'worker_role': workerRole,
      'created_at': createdAt
    };
  }
}
