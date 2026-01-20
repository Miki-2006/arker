import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kancha/models/product_model.dart';
import 'package:kancha/pages/warehouse/add_raw_material_widget.dart';
import 'package:kancha/providers/product_provider.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:provider/provider.dart';

class ProductsList extends StatefulWidget {
  final Function(ProductModel)? onProductTap;

  const ProductsList({super.key, this.onProductTap});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<ProductProvider>().fetchProducts(
        '3fce6ee2-3ad4-4a5f-8f4f-a78cfc3f95be',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child:
                productProvider.error != null
                    ? Center(child: Text('Ошибка: ${productProvider.error}'))
                    : _buildProductsList(productProvider.products),
          ),
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) =>
                        AddRawMaterialWidget(), // 👈 твоя форма добавления
              );
            },
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedAddCircle,
              color: Colors.white,
            ),
            label: StyledText(content: 'Добавить продукт'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1260f7),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsList(List<ProductModel> products) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: products.length,
      itemBuilder:
          (_, i) => GestureDetector(
            onTap: () {
              if (widget.onProductTap != null) {
                widget.onProductTap!(products[i]);
              }
            },
            child: Card(
              color: Color(0xFF1260f7),
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 20,
                  horizontal: 12,
                ),
                child: Row(
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedMaterialAndTexture,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    StyledText(
                      content: products[i].name,
                      family: 'Sofia Sans',
                      weight: 600,
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
