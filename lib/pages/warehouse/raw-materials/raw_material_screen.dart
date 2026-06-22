import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arker/core/responsive/responsive.dart';
import 'package:arker/models/warehouse_model.dart';
import 'package:arker/pages/warehouse/filter_widget.dart';
import 'package:arker/pages/warehouse/raw-materials/raw_material_card.dart';
import 'package:arker/pages/warehouse/raw-materials/raw_material_details.dart';
import 'package:arker/providers/warehouse_provider.dart';
import 'package:arker/styles/text/styled_text.dart';
import 'package:arker/widgets/loader_widget.dart';

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
      context.read<WarehouseProvider>().loadListOfMaterialsInWarehouse(
        '3fce6ee2-3ad4-4a5f-8f4f-a78cfc3f95be',
      );
    });
  }

  void _priceToggle() {
    setState(() => _isPriceFiltered = !_isPriceFiltered);
  }

  List<RawMaterialWarehouseModel> _getSortedMaterials(
    List<RawMaterialWarehouseModel> materials,
  ) {
    final sorted = materials.toList();
    sorted.sort((a, b) => a.count.compareTo(b.count));
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final warehouseProvider = context.watch<WarehouseProvider>();

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
              isQuantityFiltered: _isSortedByCountAsc,
              isPriceFiltered: _isPriceFiltered,
              onPriceTap: _priceToggle,
              onQuantityTap: () {},
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
                        child: _buildListOfRawMaterils(
                          _getSortedMaterials(
                            warehouseProvider.listOfMaterialsInWarehouse,
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListOfRawMaterils(List<RawMaterialWarehouseModel> materials) {
    if (materials.isEmpty) {
      return const Center(
        child: StyledText(content: 'РџСѓСЃС‚Рѕ', color: 0xFF5F33E1, size: 20),
      );
    }

    if (Responsive.isDesktop(context)) {
      return _RawMaterialsDataTable(materials: materials);
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 10),
      itemCount: materials.length,
      itemBuilder:
          (_, index) =>
              RawMaterialCard(rawMaterialInWarehouse: materials[index]),
    );
  }
}

class _RawMaterialsDataTable extends StatelessWidget {
  final List<RawMaterialWarehouseModel> materials;

  const _RawMaterialsDataTable({required this.materials});

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
                DataColumn(label: Text('РњР°С‚РµСЂРёР°Р»')),
                DataColumn(label: Text('РћРїРёСЃР°РЅРёРµ')),
                DataColumn(label: Text('РћСЃС‚Р°С‚РѕРє'), numeric: true),
                DataColumn(label: Text('Р•Рґ. РёР·Рј.')),
                DataColumn(label: Text('Р¦РµРЅР°'), numeric: true),
              ],
              rows:
                  materials.map((item) {
                    final material = item.rawMaterial;
                    return DataRow(
                      onSelectChanged:
                          (_) => showModalBottomSheet(
                            enableDrag: true,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            context: context,
                            builder:
                                (context) =>
                                    RawMaterialDetails(rawMaterial: material),
                          ),
                      cells: [
                        DataCell(Text(material.name)),
                        DataCell(
                          SizedBox(
                            width: 360,
                            child: Text(
                              material.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        DataCell(Text(item.count.toString())),
                        DataCell(Text(material.unitOfMeasure)),
                        DataCell(Text(material.price.toString())),
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
