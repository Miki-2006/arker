import 'package:flutter/material.dart';
import 'package:kancha/models/raw_material_model.dart';
import 'package:kancha/pages/warehouse/raw-materials/raw_materials_list.dart';
import 'package:kancha/styles/text/styled_text.dart';

class RawMaterialDetails extends StatefulWidget {
  final RawMaterialModel rawMaterial;

  const RawMaterialDetails({super.key, required this.rawMaterial});

  @override
  State<RawMaterialDetails> createState() => _RawMaterialDetailsState();
}

class _RawMaterialDetailsState extends State<RawMaterialDetails> {
  late RawMaterialModel currentRawMaterial;

  @override
  void initState() {
    super.initState();
    currentRawMaterial = widget.rawMaterial;
  }

  void updateRawMaterial(RawMaterialModel newRawMaterial) {
    setState(() {
      currentRawMaterial = newRawMaterial;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 12,
              children: [
                StyledText(
                  content: currentRawMaterial.name,
                  color: 0xFF000000,
                  family: 'Sofia Sans',
                  weight: 900,
                  size: 24,
                ),
                Image.network(
                  currentRawMaterial.image!,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StyledText(
                      content: '${currentRawMaterial.price} сом',
                      family: 'Noto Sans Math',
                      color: 0xFF000000,
                      weight: 600,
                    ),
                    StyledText(
                      content: 'за ${currentRawMaterial.unitOfMeasure}',
                      family: 'Noto Sans Math',
                      color: 0xFF000000,
                      weight: 600,
                    ),
                  ],
                ),
                StyledText(
                  content: currentRawMaterial.description,
                  color: 0xFF000000,
                  size: 20,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          StyledText(content: "Другие сырьи:", color: 0xFF000000, size: 20),
          SizedBox(height: 300, child: RawMaterialsList(
            onRawMaterialTap: updateRawMaterial
          )),
        ],
      ),
    );
  }
}
