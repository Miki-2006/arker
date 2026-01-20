import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:kancha/models/user_model.dart';
import 'package:kancha/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final List<UserModel> _users = []; // ← сюда кладём даты
  bool _usersFetched = false; // чтобы вызывалось один раз
  List<UserModel> get usersForTasks => _users;
  UnmodifiableListView<UserModel> get workers => UnmodifiableListView(_users);

  Future<void> fetchUser(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final fetched = await UserService.getUser(id);
      _user = fetched;
    } catch (e, stack) {
      _error = e.toString();
      debugPrint('fetchUser error: $e\n$stack');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllUsersForTask(String companyId) async {
    if (_usersFetched) return; // уже загружали
    _usersFetched = true;

    try {
      final fetched = await UserService.getAllUsers(companyId);
      _users
        ..clear()
        ..addAll(fetched);
      notifyListeners();
    } catch (e, stack) {
      _error = e.toString();
      debugPrint('fetchUsers error: $e\n$stack');
    } finally {
      _usersFetched = false;
      notifyListeners();
    }
  }

  Future<void> loadWorkers(String companyId) async {
    if (_isLoading || _usersFetched) return; // уже загружали
    _isLoading = true;

    try {
      final fetched = await UserService.getAllUsers(companyId);
      _users
        ..clear()
        ..addAll(fetched);
      _usersFetched = true;
      notifyListeners();
    } catch (e, stack) {
      _error = e.toString();
      debugPrint('fetchUsers error: $e\n$stack');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _user = null;
    notifyListeners();
  }
}
