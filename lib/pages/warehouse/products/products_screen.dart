import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arker/core/responsive/responsive.dart';
import 'package:arker/models/warehouse_model.dart';
import 'package:arker/pages/warehouse/filter_widget.dart';
import 'package:arker/pages/warehouse/products/product_card.dart';
import 'package:arker/pages/warehouse/products/product_details.dart';
import 'package:arker/providers/warehouse_provider.dart';
import 'package:arker/styles/text/styled_text.dart';
import 'package:arker/widgets/loader_widget.dart';

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
      context.read<ProductWarehouseProvider>().loadListOfProductsInWarehouse(
        '3fce6ee2-3ad4-4a5f-8f4f-a78cfc3f95be',
      );
    });
  }

  void _priceToggle() {
    setState(() => _isPriceFiltered = !_isPriceFiltered);
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

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: Responsive.isDesktop(context) ? 1280 : double.infinity,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
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
                      ? Center(
                        child: Text('РћС€РёР±РєР°: ${warehouseProvider.error}'),
                      )
                      : !warehouseProvider.isLoaded
                      ? LoaderWidget()
                      : Padding(
                        padding: const EdgeInsets.symmetric(
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
        ),
      ),
    );
  }

  Widget _buildListOfProducts(List<ProductWarehouseModel> products) {
    if (products.isEmpty) {
      return const Center(
        child: StyledText(content: 'РџСѓСЃС‚Рѕ', color: 0xFF5F33E1, size: 20),
      );
    }

    if (Responsive.isDesktop(context)) {
      return _ProductsDataTable(products: products);
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 10),
      itemCount: products.length,
      itemBuilder:
          (_, index) => ProductCard(productInWarehouse: products[index]),
    );
  }
}

class _ProductsDataTable extends StatelessWidget {
  final List<ProductWarehouseModel> products;

  const _ProductsDataTable({required this.products});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 980),
          child: SingleChildScrollView(
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(const Color(0xFFF4F6FA)),
              columnSpacing: 32,
              columns: const [
                DataColumn(label: Text('РџСЂРѕРґСѓРєС‚')),
                DataColumn(label: Text('РћРїРёСЃР°РЅРёРµ')),
                DataColumn(label: Text('РћСЃС‚Р°С‚РѕРє'), numeric: true),
                DataColumn(label: Text('Р•Рґ. РёР·Рј.')),
                DataColumn(label: Text('Р¦РµРЅР°'), numeric: true),
              ],
              rows:
                  products.map((item) {
                    final product = item.product;
                    return DataRow(
                      onSelectChanged:
                          (_) => showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return DraggableScrollableSheet(
                                expand: false,
                                initialChildSize: 0.8,
                                minChildSize: 0.8,
                                builder: (context, scrollController) {
                                  return ProductDetails(
                                    product: product,
                                    scrollController: scrollController,
                                  );
                                },
                              );
                            },
                          ),
                      cells: [
                        DataCell(Text(product.name)),
                        DataCell(
                          SizedBox(
                            width: 360,
                            child: Text(
                              product.description ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        DataCell(Text(item.count.toString())),
                        const DataCell(Text('С€С‚')),
                        DataCell(Text(product.price.toString())),
                      ],
                    );
                  }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
