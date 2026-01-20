import 'package:flutter/material.dart';
import 'package:kancha/models/product_model.dart';
import 'package:kancha/pages/warehouse/products/products_list.dart';
import 'package:kancha/providers/raw_material_provider.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:kancha/widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel product;
  final ScrollController scrollController;
  const ProductDetails({super.key, required this.product, required this.scrollController});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late ProductModel currentProduct;

  @override
  void initState() {
    super.initState();
    currentProduct = widget.product;
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<RawMaterialProvider>().fetchRawMaterialsForProduct(
        currentProduct.rawMaterials.map((rm) => rm.rawMaterialId).toList(),
      );
    });
  }

  void updateProduct(ProductModel newProduct) {
    setState(() {
      currentProduct = newProduct;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RawMaterialProvider>();

    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 12,
              children: [
                StyledText(
                  content: currentProduct.name,
                  color: 0xFF000000,
                  family: 'Sofia Sans',
                  weight: 900,
                  size: 24,
                ),
                Image.network(
                  currentProduct.imageUrl!,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                StyledText(
                  content: '${currentProduct.price} сом',
                  family: 'Noto Sans Math',
                  color: 0xFF000000,
                  weight: 600,
                ),
                StyledText(
                  content: currentProduct.description!,
                  color: 0xFF000000,
                  size: 20,
                ),
                StyledText(
                  content: 'Используемые сырьи:',
                  color: 0xFF000000,
                  size: 20,
                ),
                provider.error != null
                    ? Center(child: Text('Ошибка: ${provider.error}'))
                    : !provider.isLoaded
                    ? LoaderWidget()
                    : _buildRawMaterialsOfProduct(currentProduct.rawMaterials),
              ],
            ),
          ),
          StyledText(content: "Другие продукты:", color: 0xFF000000, size: 20),
          SizedBox(
            height: 300,
            child: ProductsList(
              onProductTap: updateProduct, // <-- передаем callback
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRawMaterialsOfProduct(List<RawMaterialsOfProduct> rawMaterials) {
    final provider = context.watch<RawMaterialProvider>();

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: provider.selectedRawMaterials.length,
      itemBuilder: (_, i) {
        final rawMaterial = provider.selectedRawMaterials[i];
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8,
          children: [
            StyledText(
              content: rawMaterial.name,
              color: 0xFF000000,
              size: 20,
              weight: 700,
            ),
            StyledText(
              content: '${rawMaterials[i].count} ${rawMaterial.unitOfMeasure}',
              color: 0xFF000000,
              size: 20,
              style: 'italic',
            ),
          ],
        );
      },
    );
  }
}
