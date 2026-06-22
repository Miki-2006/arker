import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arker/core/responsive/responsive.dart';
import 'package:arker/models/task_model.dart';
import 'package:arker/models/user_model.dart';
import 'package:arker/providers/task_provider.dart';
import 'package:arker/providers/user_provider.dart';
import 'package:arker/styles/text/styled_text.dart';

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
        title.trim().isEmpty ||
        description.trim().isEmpty ||
        selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: StyledText(
            content: "РџРѕР¶Р°Р»СѓР№СЃС‚Р°, Р·Р°РїРѕР»РЅРёС‚Рµ РІСЃРµ РїРѕР»СЏ",
          ),
        ),
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
        companyId: '3fce6ee2-3ad4-4a5f-8f4f-a78cfc3f95be',
      );

      await context.read<TaskProvider>().addNewTask(newTask);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(
        const SnackBar(
          content: StyledText(
            content: "Р—Р°РґР°С‡Р° СѓСЃРїРµС€РЅРѕ РґРѕР±Р°РІР»РµРЅР°",
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(
        SnackBar(
          content: Text("РћС€РёР±РєР°: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final users = userProvider.usersForTasks.map((user) => user).toList();
    final isDesktop = Responsive.isDesktop(context);

    return AlertDialog(
      title: const Center(
        child: StyledText(content: 'РќРѕРІР°СЏ Р·Р°РґР°С‡Р°'),
      ),
      content: DefaultTextStyle(
        style: const TextStyle(fontFamily: 'Manrope'),
        child: SizedBox(
          width: isDesktop ? 720 : 500,
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 20,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                SizedBox(
                  width: isDesktop ? 340 : double.infinity,
                  child: _buildUserField(
                    label: 'РљС‚Рѕ:',
                    value: fromUser,
                    users: users,
                    onChanged: (value) => setState(() => fromUser = value),
                  ),
                ),
                SizedBox(
                  width: isDesktop ? 340 : double.infinity,
                  child: _buildUserField(
                    label: 'РљРѕРјСѓ:',
                    value: toUser,
                    users: users,
                    onChanged: (value) => setState(() => toUser = value),
                  ),
                ),
                SizedBox(
                  width: isDesktop ? 340 : double.infinity,
                  child: _buildTextField(
                    label: 'Р—Р°РіРѕР»РѕРІРѕРє:',
                    hintText: 'Р’РІРµРґРёС‚Рµ Р·Р°РіРѕР»РѕРІРѕРє',
                    onChanged: (value) => title = value,
                  ),
                ),
                SizedBox(
                  width: isDesktop ? 340 : double.infinity,
                  child: _buildDateField(),
                ),
                SizedBox(
                  width: double.infinity,
                  child: _buildTextField(
                    label: 'РћРїРёСЃР°РЅРёРµ:',
                    hintText: 'Р’РІРµРґРёС‚Рµ РѕРїРёСЃР°РЅРёРµ',
                    maxLines: 3,
                    onChanged: (value) => description = value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: StyledText(content: 'РћС‚РјРµРЅР°'),
        ),
        ElevatedButton(
          onPressed: _saveTask,
          child: StyledText(content: 'РЎРѕС…СЂР°РЅРёС‚СЊ'),
        ),
      ],
    );
  }

  Widget _buildUserField({
    required String label,
    required UserModel? value,
    required List<UserModel> users,
    required ValueChanged<UserModel?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        DropdownButton<UserModel>(
          isExpanded: true,
          value: value,
          hint: StyledText(content: "Р’С‹Р±СЂР°С‚СЊ"),
          items:
              users.map((user) {
                return DropdownMenuItem(
                  value: user,
                  child: StyledText(content: user.firstName),
                );
              }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required ValueChanged<String> onChanged,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(hintText: hintText),
          maxLines: maxLines,
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Р”Р°С‚Р° Рё РІСЂРµРјСЏ:'),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
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
            child: StyledText(
              content:
                  selectedDateTime == null
                      ? 'Р’С‹Р±СЂР°С‚СЊ РґР°С‚Сѓ'
                      : '${selectedDateTime!.toLocal()}'.split('.')[0],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return StyledText(content: text, color: 0xFF5F33E1, weight: 700);
  }
}
