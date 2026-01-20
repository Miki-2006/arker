import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:kancha/models/company_model.dart';
import 'package:kancha/services/company_service.dart';

class CompanyProvider with ChangeNotifier {
  final List<CompanyModel> _company = [];
  bool _loaded = false;
  String? _error;

  bool get isLoaded => _loaded;
  String? get error => _error;
  UnmodifiableListView<CompanyModel> get company =>
      UnmodifiableListView(_company);

  Future<void> fetchCompany(String id) async {
    _loaded = false;
    _error = null;
    notifyListeners();

    try {
      final fetched = await CompanyService.getCompanyInfo(id);

      _company
        ..clear()
        ..addAll(fetched);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loaded = true;
      notifyListeners();
    }
  }
}
