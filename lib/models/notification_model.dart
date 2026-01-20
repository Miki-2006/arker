class Detail {
  final String table;
  final String id;

  Detail({required this.table, required this.id});

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      id: json['id'],
      table: json['table']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'table': table,
    };
  }
}

class NotificationModel {
  final String id;
  final String title;
  final String userId;
  final Detail detail;
  final bool isRead;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.userId,
    required this.detail,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      userId: json['user_id'],
      detail: Detail.fromJson(json['detail']),
      isRead: json['is_read'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'user_id': userId,
      'detail': detail,
      'is_read': isRead,
      'created_at': createdAt,
    };
  }
}
