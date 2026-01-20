import 'package:flutter/material.dart';
import 'package:kancha/models/raw_material_model.dart';
import 'package:kancha/providers/raw_material_provider.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:provider/provider.dart';

class AddRawMaterialWidget extends StatefulWidget {
  const AddRawMaterialWidget({super.key});

  @override
  State<AddRawMaterialWidget> createState() => _AddRawMaterialWidgetState();
}

class _AddRawMaterialWidgetState extends State<AddRawMaterialWidget> {
  String materialName = '';
  String description = '';
  String unitOfMeasure = '';
  double price = 0;
  String image = '';
  String id = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _saveRawMaterial() async {
    if (materialName.isEmpty ||
        description.isEmpty ||
        unitOfMeasure.isEmpty ||
        price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: StyledText(content: "Пожалуйста, заполните все поля"),
        ),
      );
      return;
    }

    try {
      final rawMaterial = RawMaterialModel(
        id: id,
        name: materialName,
        description: description,
        unitOfMeasure: unitOfMeasure,
        price: price,
        image: image,
        companyId: '3fce6ee2-3ad4-4a5f-8f4f-a78cfc3f95be',
      );

      await context.read<RawMaterialProvider>().addRawMaterial(rawMaterial);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Close the dialog after saving
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: StyledText(content: "Сырье успешно добавлено"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Ошибка при добавлении сырья: $error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: StyledText(content: 'Новое сырьё')),
      content: DefaultTextStyle(
        style: const TextStyle(fontFamily: 'Manrope'),
        child: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Материал:'),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Название материала',
                  ),
                  onChanged: (value) {
                    setState(() {
                      materialName = value;
                    });
                  },
                ),

                _buildLabel('Описание:'),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Краткое описание',
                  ),
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                ),

                _buildLabel('Единица измерения:'),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Метры, литры, килограммы и т.д.',
                  ),
                  onChanged: (value) {
                    setState(() {
                      unitOfMeasure = value;
                    });
                  },
                ),

                _buildLabel('Цена за единицу:'),
                TextField(
                  decoration: const InputDecoration(hintText: 'Цена в сомах'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    setState(() {
                      price = double.parse(value);
                    });
                  },
                ),

                _buildLabel('Фото:'),
                TextField(
                  decoration: const InputDecoration(hintText: 'Ссылка'),
                  onChanged: (value) {
                    setState(() {
                      image = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: StyledText(content: 'Отмена'),
        ),
        ElevatedButton(
          onPressed: _saveRawMaterial,
          child: StyledText(content: 'Сохранить'),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return StyledText(content: text, color: 0xFF5F33E1, weight: 700);
  }
}
