import 'package:flutter/material.dart';
import 'package:kancha/models/task_model.dart';
import 'package:kancha/pages/tasks/filter_widget.dart';
import 'package:kancha/pages/tasks/date-selector/date_selector.dart';
import 'package:kancha/pages/tasks/task-card/task_card.dart';
import 'package:kancha/providers/task_provider.dart';
import 'package:kancha/pages/tasks/add_task_widget.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:kancha/widgets/icons/add_button_widget.dart';
import 'package:kancha/widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  TaskStatusFilter _selectedFilter = TaskStatusFilter.all;

  // Загружаем задачи один раз
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          // ignore: use_build_context_synchronously
          context.read<TaskProvider>().loadAllTasks(),
    );
    Future.microtask(
      () =>
      // ignore: use_build_context_synchronously
      context.read<TaskProvider>().loadTasks(_selectedDate),
    ); // listen: false внутри
  }

  void _addNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return Builder(
          builder: (innerContext) {
            return AddTaskWidget();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>(); // подписка на изменения

    return Scaffold(
      floatingActionButton: AddButtonWidget(add: _addNewTask),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 50, 10, 20),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: Color(0xFFF3F3F3),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(1, 8),
                  blurRadius: 18,
                  spreadRadius: 0,
                  color: Color.fromRGBO(176, 176, 176, 0.1),
                ),
                BoxShadow(
                  offset: Offset(3, 32),
                  blurRadius: 32,
                  spreadRadius: 0,
                  color: Color.fromRGBO(176, 176, 176, 0.09),
                ),
                BoxShadow(
                  offset: Offset(6, 72),
                  blurRadius: 44,
                  spreadRadius: 0,
                  color: Color.fromRGBO(176, 176, 176, 0.05),
                ),
                BoxShadow(
                  offset: Offset(10, 129),
                  blurRadius: 52,
                  spreadRadius: 0,
                  color: Color.fromRGBO(176, 176, 176, 0.01),
                ),
                BoxShadow(
                  offset: Offset(16, 201),
                  blurRadius: 56,
                  spreadRadius: 0,
                  color: Color.fromRGBO(176, 176, 176, 0.0),
                ),
              ],
            ),
            child: Column(
              children: [
                DateSelector(
                  selectedDate: _selectedDate,
                  onDateSelected: (d) {
                    setState(() => _selectedDate = d);
                    context.read<TaskProvider>().loadTasks(d);
                  },
                  datesWithTasks: taskProvider.datesWithTasks,
                ),
                const SizedBox(height: 24),
                FilterWidget(
                  selectedFilter: _selectedFilter,
                  onFilterChanged: (f) => setState(() => _selectedFilter = f),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                taskProvider.error != null
                    ? Center(child: Text('Ошибка: ${taskProvider.error}'))
                    : !taskProvider.isLoaded
                    ? LoaderWidget()
                    : _buildTaskList(taskProvider.tasks),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(List<Task> allTasks) {
    // при желании фильтруем по дате/статусу
    final tasks =
        allTasks.where((t) {
          final sameDay =
              t.dueDate.year == _selectedDate.year &&
              t.dueDate.month == _selectedDate.month &&
              t.dueDate.day == _selectedDate.day;

          final statusOk = switch (_selectedFilter) {
            TaskStatusFilter.all => true,
            TaskStatusFilter.done => t.status == TaskStatus.done,
            TaskStatusFilter.pending => t.status == TaskStatus.pending,
            TaskStatusFilter.todo => t.status == TaskStatus.toDo,
          };

          return sameDay && statusOk;
        }).toList();

    if (tasks.isEmpty) {
      return const Center(
        child: StyledText(content: 'Нету задач', color: 0xFF5F33E1),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: tasks.length,
      itemBuilder:
          (_, i) => TaskCard(
            fromUser: tasks[i].createdBy.firstName,
            toUser: tasks[i].assignedTo.firstName,
            title: tasks[i].title,
            description: tasks[i].description,
            time: tasks[i].dueDate,
            status: tasks[i].status,
          ),
    );
  }
}
