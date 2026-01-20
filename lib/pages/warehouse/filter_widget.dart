import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kancha/styles/text/styled_text.dart';

class FilterWidget extends StatelessWidget {
  final bool isQuantityFiltered;
  final bool isPriceFiltered;
  final VoidCallback onQuantityTap;
  final VoidCallback onPriceTap;
  final VoidCallback onAddAlertTap;

  const FilterWidget({
    super.key,
    required this.isQuantityFiltered,
    required this.isPriceFiltered,
    required this.onQuantityTap,
    required this.onPriceTap,
    required this.onAddAlertTap,
  });

  static const Color selectedBgColor = Color(0xFF5F33E1);
  static const Color unselectedBgColor = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 3,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return _buildFilterButton(
                icon: HugeIcons.strokeRoundedArrangeByNumbers19,
                label: 'По количеству',
                isActive: isQuantityFiltered,
                onTap: onQuantityTap,
              );
            case 1:
              return _buildFilterButton(
                icon: HugeIcons.strokeRoundedSaveMoneyDollar,
                label: 'По цене',
                isActive: isPriceFiltered,
                onTap: onPriceTap,
              );
            case 2:
              return _buildAddAlertButton();
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildFilterButton({
    required List<List<dynamic>> icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF125ff7) : unselectedBgColor,
          borderRadius: BorderRadius.circular(10),
          border: BoxBorder.all(color: isActive ? Color(0xFF125ff7) : Colors.black)
        ),
        child: Row(
          children: [
            HugeIcon(
              icon: icon,
              size: 20,
              color: isActive ? Colors.white : Colors.black,
            ),
            const SizedBox(width: 8),
            StyledText(content: label, color: isActive ? 0xFFFFFFFF : 0xFF000000)
          ],
        ),
      ),
    );
  }

  Widget _buildAddAlertButton() {
    return GestureDetector(
      onTap: onAddAlertTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: unselectedBgColor,
          borderRadius: BorderRadius.circular(10),
          border: BoxBorder.all(color: Colors.black)
        ),
        child: const Row(
          children: [
            HugeIcon(icon: HugeIcons.strokeRoundedFilterAdd, size: 20, color: Colors.black,),
            SizedBox(width: 8),
            StyledText(content: 'Создать', color: 0xFF000000,)
          ],
        ),
      ),
    );
  }
}
