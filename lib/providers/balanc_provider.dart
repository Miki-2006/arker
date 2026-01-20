import 'package:flutter/material.dart';
import 'package:kancha/models/balanc_model.dart';
import 'package:kancha/services/balanc_service.dart';

class BalancProvider extends ChangeNotifier {
  BalancModel? _balanc;
  bool _isLoaded = false;
  String? _error;

  BalancModel? get balancOfUser => _balanc;
  bool get isLoaded => _isLoaded;
  String? get error => _error;

  Future<void> fetchBalanc(String userId) async {
    _isLoaded = false;
    _error = null;
    notifyListeners();

    try {
      final fetched = await BalancService.getBalancOfUser(userId);
      _balanc = fetched;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoaded = true;
      notifyListeners();
    }
  }
}
