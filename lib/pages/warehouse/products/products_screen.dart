import 'package:flutter/material.dart';
import 'package:kancha/models/warehouse_model.dart';
import 'package:kancha/pages/warehouse/filter_widget.dart';
import 'package:kancha/pages/warehouse/products/product_card.dart';
import 'package:kancha/providers/warehouse_provider.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:kancha/widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _isPriceFiltered = false;
  final _isSortedByCount = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<ProductWarehouseProvider>().loadListOfProductsInWarehouse(
        '3fce6ee2-3ad4-4a5f-8f4f-a78cfc3f95be',
      );
    });
  }

  void _priceToggle() {
    setState(() {
      _isPriceFiltered = !_isPriceFiltered;
    });
  }

  List<ProductWarehouseModel> _getSortedProducts(
    List<ProductWarehouseModel> products,
  ) {
    final sorted = products.toList();
    sorted.sort((a, b) => a.count.compareTo(b.count));
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final warehouseProvider = context.watch<ProductWarehouseProvider>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20,),
        FilterWidget(
          isQuantityFiltered: _isSortedByCount,
          isPriceFiltered: _isPriceFiltered,
          onQuantityTap: () {},
          onPriceTap: _priceToggle,
          onAddAlertTap: () {},
        ),
        Expanded(
          child:
              warehouseProvider.error != null
                  ? Center(child: Text('Ошибка: ${warehouseProvider.error}'))
                  : !warehouseProvider.isLoaded
                  ? LoaderWidget()
                  : Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    child: _buildListOfProducts(
                      _getSortedProducts(
                        warehouseProvider.listOfProductsInWarehouse,
                      ),
                    ),
                  ),
        ),
      ],
    );
  }

  Widget _buildListOfProducts(List allproducts) {
    if (allproducts.isEmpty) {
      return const Center(
        child: StyledText(content: 'Пусто', color: 0xFF5F33E1, size: 20),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 10),
      itemCount: allproducts.length,
      itemBuilder: (_, i) => ProductCard(productInWarehouse: allproducts[i]),
    );
  }
}
