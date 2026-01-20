import 'package:flutter/material.dart';
import 'package:kancha/models/warehouse_model.dart';
import 'package:kancha/pages/warehouse/filter_widget.dart';
import 'package:kancha/pages/warehouse/raw-materials/raw_material_card.dart';
import 'package:kancha/providers/warehouse_provider.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:kancha/widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class RawMaterialScreen extends StatefulWidget {
  const RawMaterialScreen({super.key});

  @override
  State<RawMaterialScreen> createState() => _RawMaterialScreenState();
}

class _RawMaterialScreenState extends State<RawMaterialScreen> {
  bool _isPriceFiltered = false;
  final _isSortedByCountAsc = true;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<WarehouseProvider>().loadListOfMaterialsInWarehouse(
        '3fce6ee2-3ad4-4a5f-8f4f-a78cfc3f95be',
      );
    });
  }

  void _priceToggle() {
    setState(() {
      _isPriceFiltered = !_isPriceFiltered;
    });
  }

  List<RawMaterialWarehouseModel> _getSortedMaterials(
    List<RawMaterialWarehouseModel> materials,
  ) {
    final sorted = materials.toList();
    sorted.sort(
      (a, b) => a.count.compareTo(b.count)
    );
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final warehouseProvider = context.watch<WarehouseProvider>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20,),
        FilterWidget(
          isQuantityFiltered: _isSortedByCountAsc,
          isPriceFiltered: _isPriceFiltered,
          onPriceTap: _priceToggle,
          onQuantityTap: () {},
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
                    child: _buildListOfRawMaterils(
                      _getSortedMaterials(warehouseProvider.listOfMaterialsInWarehouse),
                    ),
                  ),
        ),
      ],
    );
  }

  Widget _buildListOfRawMaterils(List allRawMaterils) {
    if (allRawMaterils.isEmpty) {
      return const Center(
        child: StyledText(content: 'Пусто', color: 0xFF5F33E1, size: 20),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 10),
      itemCount: allRawMaterils.length,
      itemBuilder:
          (_, i) => RawMaterialCard(rawMaterialInWarehouse: allRawMaterils[i]),
    );
  }
}
