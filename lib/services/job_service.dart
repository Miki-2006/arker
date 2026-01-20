import 'package:kancha/models/job_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class JobService {
  static final _client = Supabase.instance.client;

  static Future<List<JobModel>> getJobs(String companyId) async {
    try {
      final res = await _client
          .from('jobs')
          .select()
          .eq('company_id', companyId);

      final data = res as List;

      return data
          .map((el) => JobModel.fromJson(el as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("Error fetching jobs by companyId: $e");
    }
  }

  static Future<void> addJob(JobModel newJob) async {
    try {
      await _client.from('jobs').insert(newJob.toJson());
      // ignore: avoid_print
      print("Job was inserted!");
    } catch (e) {
      throw Exception("Error adding job: $e");
    }
  }
}
