import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:kancha/models/raw_material_model.dart';
import 'package:kancha/services/raw_material_service.dart';

class RawMaterialProvider with ChangeNotifier {
  final List<RawMaterialModel> _rawMaterials = [];
  final List<RawMaterialModel> _selectedRawMaterials =
      []; // материалы для конкретного продукта
  bool _loaded = false;
  String? _error;

  bool get isLoaded => _loaded;
  String? get error => _error;
  UnmodifiableListView<RawMaterialModel> get rawMaterials =>
      UnmodifiableListView(_rawMaterials);

  UnmodifiableListView<RawMaterialModel> get selectedRawMaterials =>
      UnmodifiableListView(_selectedRawMaterials);

  Future<void> fetchRawMaterials(String companyId) async {
    _loaded = false;
    _error = null;
    notifyListeners();

    try {
      final fetched = await RawMaterialService.getRawMaterials(companyId);
      _rawMaterials
        ..clear()
        ..addAll(fetched);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loaded = true;
      notifyListeners();
    }
  }

  Future<void> fetchRawMaterialsForProduct(List<String> ids) async {
    _error = null;
    _loaded = false;
    _selectedRawMaterials.clear();
    notifyListeners();

    try {
      for (final id in ids) {
        final fetched = await RawMaterialService.getRawMaterial(id);
        _selectedRawMaterials.add(fetched);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _loaded = true;
      notifyListeners();
    }
  }

  Future<void> addRawMaterial(RawMaterialModel rawMaterial) async {
    try {
      await RawMaterialService.addNewRawMaterial(rawMaterial);
      await fetchRawMaterials(rawMaterial.companyId); // обновляем общий список
    } catch (e) {
      throw Exception('Failed to add raw material: $e');
    }
  }
}
