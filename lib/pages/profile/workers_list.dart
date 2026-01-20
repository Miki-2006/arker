import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kancha/models/user_model.dart';
import 'package:kancha/pages/profile/add_worker_dialog.dart';
import 'package:kancha/pages/profile/worker_card.dart';
import 'package:kancha/providers/user_provider.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:kancha/widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class WorkersList extends StatefulWidget {
  const WorkersList({super.key});

  @override
  State<WorkersList> createState() => _WorkersListState();
}

class _WorkersListState extends State<WorkersList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      // ignore: use_build_context_synchronously
      () => context.read<UserProvider>().loadWorkers(
        '3fce6ee2-3ad4-4a5f-8f4f-a78cfc3f95be',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child:
                userProvider.error != null
                    ? Center(child: Text('Ошибка: ${userProvider.error}'))
                    : userProvider.isLoading
                    ? LoaderWidget()
                    : _buildWorkerList(userProvider.workers),
          ),
          SizedBox(height: 10,),
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => AddWorkerDialog(), // 👈 твоя форма добавления
              );
            },
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedUserAdd02,
              color: Colors.white,
              size: 28,
            ),
            label: StyledText(content: 'Новый сотрудник'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF5F33E1),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkerList(List<UserModel> workers) {
    if (workers.isEmpty) {
      return Center(
        child: StyledText(content: 'Нету сотрудников', color: 0xFF5F33E1, size: 20,),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: workers.length,
      itemBuilder:
          (_, i) => WorkerCard(
            firstName: workers[i].firstName,
            secondName: workers[i].lastName,
            workerRole: workers[i].workerRole,
          ),
    );
  }
}
