import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:kancha/models/product_model.dart';
import 'package:kancha/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  final List<ProductModel> _products = [];
  bool _loaded = false;
  String? _error;

  bool get isLoaded => _loaded;
  String? get error => _error;
  UnmodifiableListView<ProductModel> get products =>
      UnmodifiableListView(_products);

  Future<void> fetchProducts(String companyId) async {
    _loaded = false;
    _error = null;
    notifyListeners();

    try {
      final fetched = await ProductService.getProducts(companyId);

      _products
        ..clear()
        ..addAll(fetched);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loaded = true;
      notifyListeners();
    }
  }

  // Future<void> addRawMaterial(RawMaterialModel rawMaterial) async {
  //   try {
  //     await RawMaterialService.addNewRawMaterial(rawMaterial);
  //     await fetchRawMaterials(); // Refresh the list after adding
  //   } catch (e) {
  //     throw Exception('Failed to add raw material: $e');
  //   }
  // }
}
