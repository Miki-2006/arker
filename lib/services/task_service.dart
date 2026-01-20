import 'package:kancha/models/task_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskService {
  static final _client = Supabase.instance.client;

  static Future<List<Task>> getTasks(DateTime date) async {
    try {
      final res = await _client
          .from('tasks')
          .select(
            '*, assigned_to_user:users!assigned_to(*), created_by_user:users!created_by(*)',
          )
          .eq('due_date', date.toIso8601String());

      // ignore: avoid_print
      final data = res as List;

      return data.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching tasks: $e');
      rethrow;
    }
  }

  /// Возвращает все due_date в интервале [from] – [to] (включительно).
  static Future<Set<DateTime>> getAllTasks({
    required DateTime from,
    required DateTime to,
  }) async {
    final rows = await Supabase.instance.client
        .from('tasks')
        .select('due_date')
        .gte('due_date', _iso(from))
        .lte('due_date', _iso(to));

    return rows
        .map<DateTime>((r) => DateTime.parse(r['due_date'] as String))
        .toSet();
  }

  static String _iso(DateTime d) => d.toIso8601String().substring(0, 10);

  static Future<void> addTask(Task newTask) async {
    try {
      final response = await _client.from('tasks').insert(newTask.toJson());
      // ignore: avoid_print
      print('Inserted: $response');
    } catch (e) {
      // ignore: avoid_print
      print('Error adding task: $e');
      rethrow;
    }
  }
}
