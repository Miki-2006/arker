import 'package:flutter/foundation.dart';
import 'package:kancha/models/task_model.dart';
import 'package:kancha/services/task_service.dart';
import 'dart:collection';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  bool _loaded = false;
  String? _error;

  bool get isLoaded => _loaded;
  String? get error => _error;
  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  final Set<DateTime> _datesWithTasks = {}; // ← сюда кладём даты
  bool _datesFetched = false; // чтобы вызывалось один раз
  Set<DateTime> get datesWithTasks => _datesWithTasks;

  Future<void> loadTasks(DateTime date) async {
    _loaded = false;
    _error = null;
    notifyListeners();

    try {
      final fetched = await TaskService.getTasks(date);

      _tasks
        ..clear()
        ..addAll(fetched);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loaded = true;
      notifyListeners();
    }
  }

  Future<void> loadAllTasks({int horizonDays = 30}) async {
    if (_datesFetched) return; // уже загружали
    _datesFetched = true; // блокируем повтор до конца метода

    try {
      final today = DateTime.now();
      final until = today.add(Duration(days: horizonDays));

      final fetchedDates = await TaskService.getAllTasks(
        from: today,
        to: until,
      );

      _datesWithTasks
        ..clear()
        ..addAll(fetchedDates);

      notifyListeners(); // сообщаем UI
    } catch (e, s) {
      debugPrintStack(label: 'loadAllTasks: $e', stackTrace: s);
      _datesFetched = false; // позволяем повторить позже
    }
  }

  Future<void> addNewTask(Task newTask) async {
    try {
      await TaskService.addTask(newTask);
      _tasks.add(newTask);
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print('Error in TaskProvider.addNewTask: $e');
      rethrow;
    }
  }
}
