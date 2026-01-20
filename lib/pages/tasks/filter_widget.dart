import 'package:flutter/material.dart';
import 'package:kancha/styles/text/styled_text.dart';

enum TaskStatusFilter { all, done, pending, todo }

class FilterWidget extends StatelessWidget {
  final TaskStatusFilter selectedFilter;
  final ValueChanged<TaskStatusFilter> onFilterChanged;

  const FilterWidget({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  final Map<TaskStatusFilter, String> _labels = const {
    TaskStatusFilter.all: 'All',
    TaskStatusFilter.done: 'Done',
    TaskStatusFilter.pending: 'Pending',
    TaskStatusFilter.todo: 'To-Do',
  };

  static const Color selectedBgColor = Color(0xFF19568c);  // #5F33E1
  static const Color unselectedBgColor = Color(0xFFFFFFFF); // #EDE8FF

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _labels.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final key = _labels.keys.elementAt(index);
          final isSelected = key == selectedFilter;

          return GestureDetector(
            onTap: () => onFilterChanged(key),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? selectedBgColor : unselectedBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: StyledText(content: _labels[key]!, color: isSelected ? 0xFFFFFFFF : 0xFF19568c,)
              ),
            ),
          );
        },
      ),
    );
  }
}
