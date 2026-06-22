import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:arker/core/responsive/responsive.dart';
import 'package:arker/models/task_model.dart';
import 'package:arker/pages/tasks/add_task_widget.dart';
import 'package:arker/pages/tasks/date-selector/date_selector.dart';
import 'package:arker/pages/tasks/filter_widget.dart';
import 'package:arker/pages/tasks/task-card/task_card.dart';
import 'package:arker/providers/task_provider.dart';
import 'package:arker/styles/text/styled_text.dart';
import 'package:arker/widgets/icons/add_button_widget.dart';
import 'package:arker/widgets/loader_widget.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  TaskStatusFilter _selectedFilter = TaskStatusFilter.all;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TaskProvider>().loadAllTasks());
    Future.microtask(
      () => context.read<TaskProvider>().loadTasks(_selectedDate),
    );
  }

  void _addNewTask() {
    showDialog(context: context, builder: (context) => const AddTaskWidget());
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      floatingActionButton: AddButtonWidget(add: _addNewTask),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 1280 : double.infinity,
          ),
          child: Column(
            children: [
              _TaskToolbar(
                selectedDate: _selectedDate,
                selectedFilter: _selectedFilter,
                datesWithTasks: taskProvider.datesWithTasks,
                onDateSelected: (date) {
                  setState(() => _selectedDate = date);
                  context.read<TaskProvider>().loadTasks(date);
                },
                onFilterChanged:
                    (filter) => setState(() => _selectedFilter = filter),
              ),
              Expanded(
                child:
                    taskProvider.error != null
                        ? Center(
                          child: Text('РћС€РёР±РєР°: ${taskProvider.error}'),
                        )
                        : !taskProvider.isLoaded
                        ? LoaderWidget()
                        : _buildTaskList(taskProvider.tasks),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskList(List<Task> allTasks) {
    final tasks = _filteredTasks(allTasks);

    if (tasks.isEmpty) {
      return const Center(
        child: StyledText(content: 'РќРµС‚Сѓ Р·Р°РґР°С‡', color: 0xFF5F33E1),
      );
    }

    if (Responsive.isDesktop(context)) {
      return _TaskDataTable(tasks: tasks);
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: tasks.length,
      itemBuilder:
          (_, index) => TaskCard(
            fromUser: tasks[index].createdBy.firstName,
            toUser: tasks[index].assignedTo.firstName,
            title: tasks[index].title,
            description: tasks[index].description,
            time: tasks[index].dueDate,
            status: tasks[index].status,
          ),
    );
  }

  List<Task> _filteredTasks(List<Task> allTasks) {
    return allTasks.where((task) {
      final sameDay =
          task.dueDate.year == _selectedDate.year &&
          task.dueDate.month == _selectedDate.month &&
          task.dueDate.day == _selectedDate.day;

      final statusOk = switch (_selectedFilter) {
        TaskStatusFilter.all => true,
        TaskStatusFilter.done => task.status == TaskStatus.done,
        TaskStatusFilter.pending => task.status == TaskStatus.pending,
        TaskStatusFilter.todo => task.status == TaskStatus.toDo,
      };

      return sameDay && statusOk;
    }).toList();
  }
}

class _TaskToolbar extends StatelessWidget {
  final DateTime selectedDate;
  final TaskStatusFilter selectedFilter;
  final Set<DateTime> datesWithTasks;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<TaskStatusFilter> onFilterChanged;

  const _TaskToolbar({
    required this.selectedDate,
    required this.selectedFilter,
    required this.datesWithTasks,
    required this.onDateSelected,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      margin: EdgeInsets.fromLTRB(
        isDesktop ? 32 : 10,
        isDesktop ? 24 : 50,
        isDesktop ? 32 : 10,
        20,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 24 : 10,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: const [
          BoxShadow(
            offset: Offset(1, 8),
            blurRadius: 18,
            color: Color.fromRGBO(176, 176, 176, 0.1),
          ),
          BoxShadow(
            offset: Offset(3, 32),
            blurRadius: 32,
            color: Color.fromRGBO(176, 176, 176, 0.09),
          ),
        ],
      ),
      child: Column(
        children: [
          DateSelector(
            selectedDate: selectedDate,
            onDateSelected: onDateSelected,
            datesWithTasks: datesWithTasks,
          ),
          const SizedBox(height: 24),
          FilterWidget(
            selectedFilter: selectedFilter,
            onFilterChanged: onFilterChanged,
          ),
        ],
      ),
    );
  }
}

class _TaskDataTable extends StatelessWidget {
  final List<Task> tasks;

  const _TaskDataTable({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 24),
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 980),
            child: SingleChildScrollView(
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(
                  const Color(0xFFF4F6FA),
                ),
                columnSpacing: 32,
                dataRowMinHeight: 58,
                dataRowMaxHeight: 76,
                columns: const [
                  DataColumn(label: Text('Р—Р°РґР°С‡Р°')),
                  DataColumn(label: Text('РљС‚Рѕ')),
                  DataColumn(label: Text('РљРѕРјСѓ')),
                  DataColumn(label: Text('Р’СЂРµРјСЏ')),
                  DataColumn(label: Text('РЎС‚Р°С‚СѓСЃ')),
                ],
                rows:
                    tasks.map((task) {
                      return DataRow(
                        cells: [
                          DataCell(
                            SizedBox(
                              width: 360,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Manrope',
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    task.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontFamily: 'Manrope',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          DataCell(Text(task.createdBy.firstName)),
                          DataCell(Text(task.assignedTo.firstName)),
                          DataCell(
                            Text(DateFormat('HH:mm').format(task.dueDate)),
                          ),
                          DataCell(_StatusBadge(status: task.status)),
                        ],
                      );
                    }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final TaskStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      TaskStatus.done => Colors.green,
      TaskStatus.pending => Colors.orange,
      TaskStatus.toDo => Colors.red,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        statusToString(status),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontFamily: 'Manrope',
        ),
      ),
    );
  }
}
