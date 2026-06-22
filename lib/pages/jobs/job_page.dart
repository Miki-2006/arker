import 'package:flutter/material.dart';
import 'package:arker/models/job_model.dart';
import 'package:arker/pages/jobs/job_card.dart';
import 'package:arker/providers/job_provider.dart';
import 'package:arker/pages/jobs/add_job_widget.dart';
import 'package:arker/styles/text/styled_text.dart';
import 'package:arker/widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key});

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => {
        // ignore: use_build_context_synchronously
        context.read<JobProvider>().fetchJobs(
          '11a1f7ad-8316-485d-b304-0e9e93a37714',
        ),
      },
    );
  }

  void _addNewJob() {
    showDialog(
      context: context,
      builder: (context) {
        return Builder(
          builder: (innerContext) {
            return AddJobWidget();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final jobsProvider = context.watch<JobProvider>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewJob,
        backgroundColor: Color(0xFFfdcb00),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.only(top: 15),
        child: Expanded(
          child:
              jobsProvider.error != null
                  ? Center(child: Text('Ошибка: ${jobsProvider.error}'))
                  : !jobsProvider.isLoaded
                  ? LoaderWidget()
                  : _buildJobsList(jobsProvider.jobs),
        ),
      ),
    );
  }

  Widget _buildJobsList(List<JobModel> jobs) {
    if (jobs.isEmpty) {
      return const Center(child: StyledText(content: 'Нету работ', color: 0xFF5F33E1, size: 20,));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: jobs.length,
      itemBuilder:
          (_, i) => JobCard(
            title: jobs[i].title,
            description: jobs[i].description,
            price: jobs[i].price,
          ),
    );
  }
}
