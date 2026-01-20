import 'package:flutter/material.dart';
import 'package:kancha/models/job_model.dart';
import 'package:kancha/pages/warehouse/raw_material_checkbox.dart';
import 'package:kancha/providers/job_provider.dart';
import 'package:kancha/providers/raw_material_provider.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:provider/provider.dart';

class AddJobWidget extends StatefulWidget {
  const AddJobWidget({super.key});

  @override
  State<AddJobWidget> createState() => _AddJobWidgetState();
}

class _AddJobWidgetState extends State<AddJobWidget> {
  String title = '';
  String description = '';
  int price = 0;
  String companyId = '3fce6ee2-3ad4-4a5f-8f4f-a78cfc3f95be';
  List? rawMaterialsId;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<RawMaterialProvider>().fetchRawMaterials(companyId);
    });
  }

  void _handleMaterialsChange(List<Map<String, dynamic>> materials) {
    setState(() {
      rawMaterialsId = materials;
    });
  }

  Future<void> _saveJob() async {
    if (title.isEmpty || description.isEmpty || price == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: StyledText(content: "Пожалуйста, заполните все поля"),
        ),
      );
      return;
    }

    try {
      final newJob = JobModel(
        title: title,
        description: description,
        price: price,
        companyId: companyId,
        rawMaterialsId: rawMaterialsId,
      );

      await context.read<JobProvider>().addNewJob(newJob);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Закрыть диалог
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(
        const SnackBar(
          content: StyledText(content: "Работа успешно добавлена"),
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
      title: const Center(child: StyledText(content: 'Новая работа')),
      content: DefaultTextStyle(
        style: const TextStyle(fontFamily: 'Manrope'),
        child: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Работа'),
                TextField(
                  onChanged: (value) => title = value,
                  decoration: const InputDecoration(hintText: 'Новая работа'),
                ),
                const SizedBox(height: 12),

                _buildLabel('Описание:'),
                TextField(
                  onChanged: (value) => description = value,
                  decoration: const InputDecoration(
                    hintText: 'Краткое описание работе',
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 12),

                _buildLabel('Цена:'),
                TextField(
                  onChanged: _valueParse,
                  decoration: const InputDecoration(hintText: 'Цена за работу'),
                ),
                const SizedBox(height: 12),

                _buildLabel('Сырьи:'),
                SizedBox(
                  height: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child:
                            rawMaterialProvider.error != null
                                ? Center(child: Text('Произошла ошибка!'))
                                : RawMaterialCheckbox(
                                  rawMaterials:
                                      rawMaterialProvider.rawMaterials,
                                  onChanged: _handleMaterialsChange,
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: StyledText(content: 'отмена'),
        ),
        ElevatedButton(
          onPressed: _saveJob,
          child: StyledText(content: 'Сохранить'),
        ),
      ],
    );
  }

  void _valueParse(String value) {
    try {
      int? num = int.tryParse(value);
      if (num != null) {
        price = num;
      }
    } catch (e) {
      throw Exception("Error in parsing price: $e");
    }
  }

  Widget _buildLabel(String text) {
    return StyledText(content: text);
  }
}
