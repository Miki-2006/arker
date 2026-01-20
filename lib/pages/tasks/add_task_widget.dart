import 'package:flutter/material.dart';
import 'package:kancha/models/task_model.dart';
import 'package:kancha/models/user_model.dart';
import 'package:kancha/providers/task_provider.dart';
import 'package:kancha/providers/user_provider.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:provider/provider.dart';

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({super.key});

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  UserModel? fromUser;
  UserModel? toUser;
  String title = '';
  String description = '';
  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<UserProvider>().fetchAllUsersForTask(
        '11a1f7ad-8316-485d-b304-0e9e93a37714',
      );
    });
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null) return;

    final time = await showTimePicker(
      // ignore: use_build_context_synchronously
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    setState(() {
      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _saveTask() async {
    if (fromUser == null ||
        toUser == null ||
        title.trim().isEmpty || description.trim().isEmpty ||
        selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: StyledText(content: "Пожалуйста, заполните все поля")),
      );
      return;
    }

    try {
      final newTask = Task(
        title: title.trim(),
        description: description.trim(),
        status: TaskStatus.toDo,
        assignedTo: toUser!,
        createdBy: fromUser!,
        dueDate: selectedDateTime!,
        companyId: '3fce6ee2-3ad4-4a5f-8f4f-a78cfc3f95be'
      );

      await context.read<TaskProvider>().addNewTask(newTask);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Закрыть диалог
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(
        const SnackBar(
          content: StyledText(content: "Задача успешно добавлена"),
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
    final userProvider = context.watch<UserProvider>();
    final users = userProvider.usersForTasks.map((u) => u).toList();

    return AlertDialog(
      title: const Center(
        child: StyledText(content: 'Новая задача')
      ),
      content: DefaultTextStyle(
        style: const TextStyle(fontFamily: 'Manrope'),
        child: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Кто:'),
                DropdownButton<UserModel>(
                  isExpanded: true,
                  value: fromUser,
                  hint: StyledText(content: "Выбрать"),
                  items:
                      users.map((user) {
                        return DropdownMenuItem(
                          value: user,
                          child: StyledText(content: user.firstName),
                        );
                      }).toList(),
                  onChanged: (value) => setState(() => fromUser = value),
                ),
                const SizedBox(height: 12),

                _buildLabel('Кому:'),
                DropdownButton<UserModel>(
                  isExpanded: true,
                  value: toUser,
                  hint: StyledText(content: "Выбрать"),
                  items:
                      users.map((user) {
                        return DropdownMenuItem(
                          value: user,
                          child: StyledText(content: user.firstName),
                        );
                      }).toList(),
                  onChanged: (value) => setState(() => toUser = value),
                ),
                const SizedBox(height: 12),

                _buildLabel('Заголовок:'),
                TextField(
                  onChanged: (value) => title = value,
                  decoration: const InputDecoration(
                    hintText: 'Введите заголовок',
                  ),
                ),
                const SizedBox(height: 12),

                _buildLabel('Описание:'),
                TextField(
                  onChanged: (value) => description = value,
                  decoration: const InputDecoration(
                    hintText: 'Введите описание',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),

                _buildLabel('Дата и время:'),
                TextButton(
                  onPressed: _selectDateTime,
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  child: StyledText(content: selectedDateTime == null
                        ? 'Выбрать дату'
                        : '${selectedDateTime!.toLocal()}'.split('.')[0])
                ),
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
        ElevatedButton(onPressed: _saveTask, child: StyledText(content: 'Сохранить')),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return StyledText(content: text, color: 0xFF5F33E1, weight: 700,);
  }
}
