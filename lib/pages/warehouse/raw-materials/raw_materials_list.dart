import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kancha/models/raw_material_model.dart';
import 'package:kancha/providers/raw_material_provider.dart';
import 'package:kancha/pages/warehouse/add_raw_material_widget.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:provider/provider.dart';

class RawMaterialsList extends StatefulWidget {
  final Function(RawMaterialModel)? onRawMaterialTap;

  const RawMaterialsList({super.key, this.onRawMaterialTap});

  @override
  State<RawMaterialsList> createState() => _RawMaterialsListState();
}

class _RawMaterialsListState extends State<RawMaterialsList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => {
        // ignore: use_build_context_synchronously
        context.read<RawMaterialProvider>().fetchRawMaterials(
          '3fce6ee2-3ad4-4a5f-8f4f-a78cfc3f95be',
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final rawMaterialProvider = context.watch<RawMaterialProvider>();

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child:
                rawMaterialProvider.error != null
                    ? Center(
                      child: Text('Ошибка: ${rawMaterialProvider.error}'),
                    )
                    : _buildrawMaterialList(rawMaterialProvider.rawMaterials),
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
            label: StyledText(content: 'Добавить сырьё'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1260f7),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildrawMaterialList(List<RawMaterialModel> rawMaterials) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: rawMaterials.length,
      itemBuilder:
          (_, i) => GestureDetector(
            onTap: () {
              if (widget.onRawMaterialTap != null) {
                widget.onRawMaterialTap!(rawMaterials[i]);
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
                      content: rawMaterials[i].name,
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
