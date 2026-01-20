import 'package:flutter/material.dart';
import 'package:kancha/models/raw_material_model.dart';
import 'package:kancha/styles/text/styled_text.dart';

class RawMaterialCheckbox extends StatefulWidget {
  final List<RawMaterialModel> rawMaterials;
  final Function(List<Map<String, dynamic>>) onChanged;

  const RawMaterialCheckbox({
    super.key,
    required this.rawMaterials,
    required this.onChanged,
  });

  @override
  State<RawMaterialCheckbox> createState() => _RawMaterialCheckboxState();
}

class _RawMaterialCheckboxState extends State<RawMaterialCheckbox> {
  late List<bool> isCheckedList;
  late List<String> quantityList;

  @override
  void initState() {
    super.initState();
    isCheckedList = List<bool>.filled(widget.rawMaterials.length, false);
    quantityList = List<String>.filled(widget.rawMaterials.length, '');
  }

  void _updateSelection() {
    final selected = <Map<String, dynamic>>[];

    for (int i = 0; i < widget.rawMaterials.length; i++) {
      if (isCheckedList[i] && quantityList[i].isNotEmpty) {
        selected.add({
          'id': widget.rawMaterials[i].id,
          'quantity': quantityList[i],
        });
      }
    }

    widget.onChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.rawMaterials.length,
      itemBuilder: (_, i) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              title: StyledText(content: widget.rawMaterials[i].name),
              value: isCheckedList[i],
              onChanged:
                  (value) => {
                    setState(() {
                      isCheckedList[i] = value ?? false;
                    }),
                    _updateSelection(),
                  },
            ),
            if (isCheckedList[i])
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Количество'),
                  onChanged: (val) {
                    setState(() {
                      quantityList[i] = val;
                    });
                    _updateSelection();
                  },
                ),
              ),
            const Divider(),
          ],
        );
      },
    );
  }
}
