import 'package:flutter/material.dart';
import 'package:kancha/models/warehouse_model.dart';
import 'package:kancha/pages/warehouse/raw-materials/raw_material_details.dart';
import 'package:kancha/styles/text/styled_text.dart';

class RawMaterialCard extends StatelessWidget {
  final RawMaterialWarehouseModel rawMaterialInWarehouse;

  const RawMaterialCard({super.key, required this.rawMaterialInWarehouse});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => showModalBottomSheet(
            enableDrag: true,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            context: context,
            builder: (context) {
              return RawMaterialDetails(
                rawMaterial: rawMaterialInWarehouse.rawMaterial,
              );
            },
          ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.1)),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          spacing: 10,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Image.network(
              rawMaterialInWarehouse.rawMaterial.image!,
              height: 100,
              width: 100,
              fit: BoxFit.contain,
            ),),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledText(
                  content: rawMaterialInWarehouse.rawMaterial.name,
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
                      content: rawMaterialInWarehouse.count.toString(),
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
                      content: rawMaterialInWarehouse.rawMaterial.unitOfMeasure,
                      family: 'Noto Sans Math',
                      weight: 900,
                      color: 0xFF000000,
                    ),
                  ],
                ),
                Row(
                  children: [
                    StyledText(
                      content: 'цена:',
                      family: 'Anonymous Pro',
                      style: 'italic',
                      color: 0xFF000000,
                    ),
                    StyledText(
                      content: rawMaterialInWarehouse.rawMaterial.price.toString(),
                      family: 'Noto Sans Math',
                      weight: 900,
                      color: 0xFF000000,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
