import 'package:flutter/material.dart';
import 'package:kancha/pages/tasks/date-selector/date_card.dart';

class DateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final int days;
  final Set<DateTime> datesWithTasks;

  const DateSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.days = 30,
    this.datesWithTasks = const {},
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth / 5 - 12;
    final dates = List.generate(
      days,
      (i) => DateTime.now().add(Duration(days: i)),
    );

    return SizedBox(
      height: 85,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        itemCount: dates.length,
        itemBuilder: (_, i) {
          final date = dates[i];
          final isHaveTask = datesWithTasks.any(
            (d) =>
                d.year == date.year &&
                d.month == date.month &&
                d.day == date.day,
          );

          return DateCard(
            width: cardWidth,
            date: date,
            isSelected: _isSameDay(date, selectedDate),
            isHaveTask: isHaveTask, // <- передаем
            onTap: () => onDateSelected(date),
          );
        },
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

/// Внутренняя «карточка» одной даты.
