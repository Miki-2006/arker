class BalancModel {
  final String? id;
  final String userId;
  final double amount;
  final String details;

  BalancModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.details,
  });

  factory BalancModel.fromJson(Map<String, dynamic> json) {
    return BalancModel(
      id: json['id'],
      userId: json['user_id'],
      amount: json['amount'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'user_id': userId, 'amount': amount, 'details': details};
  }
}
