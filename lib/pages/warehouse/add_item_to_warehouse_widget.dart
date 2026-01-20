import 'package:flutter/material.dart';
import 'package:kancha/models/raw_material_model.dart';
import 'package:kancha/models/warehouse_model.dart';
import 'package:kancha/providers/raw_material_provider.dart';
import 'package:kancha/providers/warehouse_provider.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:provider/provider.dart';

class AddItemToWarehouseWidget extends StatefulWidget {
  const AddItemToWarehouseWidget({super.key});

  @override
  State<AddItemToWarehouseWidget> createState() =>
      _AddItemToWarehouseWidgetState();
}

class _AddItemToWarehouseWidgetState extends State<AddItemToWarehouseWidget> {
  RawMaterialModel? rawMaterial;
  double count = 0;
  String companyId = '3fce6ee2-3ad4-4a5f-8f4f-a78cfc3f95be';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<RawMaterialProvider>().fetchRawMaterials(companyId);
    });
  }

  Future<void> _saveItem() async {
    if (rawMaterial == null || companyId == 'id' || count == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: StyledText(content: "Пожалуйста, заполните все поля"),
        ),
      );
      return;
    }

    try {
      final newItem = RawMaterialWarehouseModel(
        count: count,
        rawMaterial: rawMaterial!,
        companyId: companyId,
      );

      await context.read<WarehouseProvider>().addNewItem(newItem);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Закрыть диалог
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(
        const SnackBar(
          content: StyledText(content: "Сырьё успешно добавлена в склад"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(
        SnackBar(content: Text("Ошибка: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final rawMaterialProvider = context.watch<RawMaterialProvider>();

    return AlertDialog(
      title: const Center(child: StyledText(content: 'Добавление в склад')),
      content: DefaultTextStyle(
        style: const TextStyle(fontFamily: 'Manrope'),
        child: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Что:'),
                DropdownButton<RawMaterialModel>(
                  isExpanded: true,
                  value: rawMaterial,
                  hint: StyledText(content: "Выбрать"),
                  items:
                      rawMaterialProvider.rawMaterials.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: StyledText(content: item.name),
                        );
                      }).toList(),
                  onChanged: (value) => setState(() => rawMaterial = value),
                ),
                const SizedBox(height: 12),

                _buildLabel('Количество:'),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      count = double.tryParse(value) ?? 1;
                    });
                  },
                  decoration: const InputDecoration(hintText: 'Введите число'),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: StyledText(content: 'Отмена'),
        ),
        ElevatedButton(
          onPressed: _saveItem,
          child: StyledText(content: 'Сохранить'),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return StyledText(content: text, weight: 700, color: 0xFF5F33E1);
  }
}
