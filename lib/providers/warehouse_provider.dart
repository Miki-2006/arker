import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:kancha/models/warehouse_model.dart';
import 'package:kancha/services/warehouse_service.dart';

class WarehouseProvider with ChangeNotifier {
  final List<RawMaterialWarehouseModel> _list = [];
  bool _loaded = false;
  String? _error;

  bool get isLoaded => _loaded;
  String? get error => _error;
  UnmodifiableListView<RawMaterialWarehouseModel>
  get listOfMaterialsInWarehouse => UnmodifiableListView(_list);

  Future<void> loadListOfMaterialsInWarehouse(String companyId) async {
    _loaded = false;
    _error = null;
    notifyListeners();

    try {
      final fetched = await WarehouseService.getMaterialsInWarehouse(companyId);

      _list
        ..clear()
        ..addAll(fetched);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loaded = true;
      notifyListeners();
    }
  }

  Future<void> addNewItem(RawMaterialWarehouseModel item) async {
    try {
      await WarehouseService.addSavings(item);
      _list.add(item);
      notifyListeners();
    } catch (e) {
      throw Exception("Error in warehouse provider $e");
    }
  }
}

class ProductWarehouseProvider with ChangeNotifier {
  final List<ProductWarehouseModel> _list = [];
  bool _loaded = false;
  String? _error;

  bool get isLoaded => _loaded;
  String? get error => _error;
  UnmodifiableListView<ProductWarehouseModel>
  get listOfProductsInWarehouse => UnmodifiableListView(_list);

  Future<void> loadListOfProductsInWarehouse(String companyId) async {
    _loaded = false;
    _error = null;
    notifyListeners();

    try {
      final fetched = await WarehouseService.getProductsInWarehouse(companyId);

      _list
        ..clear()
        ..addAll(fetched);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loaded = true;
      notifyListeners();
    }
  }

  // Future<void> addNewItem(RawMaterialWarehouseModel item) async {
  //   try {
  //     await WarehouseService.addSavings(item);
  //     _list.add(item);
  //     notifyListeners();
  //   } catch (e) {
  //     throw Exception("Error in warehouse provider $e");
  //   }
  // }
}

