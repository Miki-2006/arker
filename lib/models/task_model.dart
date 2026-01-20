import 'package:kancha/models/user_model.dart';

enum TaskStatus { pending, done, toDo }

String statusToString(TaskStatus status) {
  switch (status) {
    case TaskStatus.pending:
      return 'pending';
    case TaskStatus.done:
      return 'done';
    case TaskStatus.toDo:
      return 'to_do';
  }
}

TaskStatus statusFromString(String status) {
  switch (status) {
    case 'pending':
      return TaskStatus.pending;
    case 'done':
      return TaskStatus.done;
    case 'to_do':
      return TaskStatus.toDo;
    default:
      throw Exception('Unknown TaskStatus: $status');
  }
}

class Task {
  final String? id;
  final String title;
  final String description;
  final TaskStatus status;
  final UserModel assignedTo;
  final UserModel createdBy;
  final DateTime dueDate;
  final String companyId;
  final String? createdAt;
  final String? jobId;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.assignedTo,
    required this.createdBy,
    required this.dueDate,
    required this.companyId,
    this.createdAt,
    this.jobId,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      status: statusFromString(json['status']),
      assignedTo: UserModel.fromJson(json['assigned_to_user']),
      createdBy: UserModel.fromJson(json['created_by_user']),
      dueDate: DateTime.parse(json['due_date']),
      jobId: json['job_id'], // может быть null — это нормально4
      createdAt: json['created_at'],
      companyId: json['company_id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'status': statusToString(status),
      'assigned_to': assignedTo.id,
      'created_by': createdBy.id,
      'due_date': dueDate.toIso8601String(),
      if (jobId != null) 'job_id': jobId,
      'created_at': createdAt,
      'company_id': companyId
    };
  }
}
