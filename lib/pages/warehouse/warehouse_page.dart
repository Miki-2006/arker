import 'package:flutter/material.dart';
import 'package:kancha/pages/warehouse/components/app_bar_widget.dart';
import 'package:kancha/pages/warehouse/products/products_screen.dart';
import 'package:kancha/pages/warehouse/raw-materials/raw_material_screen.dart';
import 'package:kancha/pages/warehouse/add_item_to_warehouse_widget.dart';
import 'package:kancha/pages/warehouse/add_raw_material_widget.dart';
import 'package:kancha/widgets/icons/add_button_widget.dart';

class WarehousePage extends StatefulWidget {
  const WarehousePage({super.key});

  @override
  State<WarehousePage> createState() => _WarehousePageState();
}

class _WarehousePageState extends State<WarehousePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  

  void _addRawMaterial() {
    showDialog(
      context: context,
      builder: (context) {
        return AddRawMaterialWidget();
      },
    );
  }

  void _addItemToWarehouse() {
    showDialog(
      context: context,
      builder: (context) {
        return AddItemToWarehouseWidget();
      },
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(tabController: _tabController),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AddButtonWidget(add: _addRawMaterial, label: 'Материал'),
          SizedBox(height: 10),
          AddButtonWidget(add: _addItemToWarehouse, label: 'Склад'),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          RawMaterialScreen(),
          ProductsScreen(),
          // Column(
          //   children: [
          //     SizedBox(height: 20),
          //     MaterialsFilterWidget(
          //       isQuantityFiltered: _isSortedByCountAsc,
          //       isPriceFiltered: _isPriceFiltered,
          //       onQuantityTap: _toggleSort,
          //       onPriceTap: () {},
          //       onAddAlertTap: () {},
          //     ),
          //     SizedBox(height: 20),
          //   ],
          // ),
        ],
      ),
    );
  }
}
