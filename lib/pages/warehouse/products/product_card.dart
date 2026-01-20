import 'package:flutter/material.dart';
import 'package:kancha/models/warehouse_model.dart';
import 'package:kancha/pages/warehouse/products/product_details.dart';
import 'package:kancha/styles/text/styled_text.dart';

class ProductCard extends StatelessWidget {
  final ProductWarehouseModel productInWarehouse;

  const ProductCard({super.key, required this.productInWarehouse});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.8,
                minChildSize: 0.8,
                builder: (context, scrollController) {
                  return ProductDetails(
                    product: productInWarehouse.product,
                    scrollController: scrollController,
                  );
                },
              );
            },
          ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.1)),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            Row(
              spacing: 10,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Image.network(
                    productInWarehouse.product.imageUrl!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StyledText(
                      content: productInWarehouse.product.name,
                      color: 0xFF000000,
                      family: 'Sofia Sans',
                      weight: 900,
                      size: 20,
                    ),
                    Row(
                      children: [
                        StyledText(
                          content: 'Остаток:',
                          family: 'Anonymous Pro',
                          style: 'italic',
                          color: 0xFF000000,
                        ),
                        StyledText(
                          content: productInWarehouse.count.toString(),
                          family: 'Noto Sans Math',
                          weight: 900,
                          color: 0xFF000000,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        StyledText(
                          content: 'в:',
                          family: 'Anonymous Pro',
                          style: 'italic',
                          color: 0xFF000000,
                        ),
                        StyledText(
                          content: 'шт',
                          family: 'Noto Sans Math',
                          weight: 900,
                          color: 0xFF000000,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
