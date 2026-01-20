import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:kancha/models/job_model.dart';
import 'package:kancha/services/job_service.dart';

class JobProvider with ChangeNotifier {
  final List<JobModel> _jobs = [];
  bool _loaded = false;
  String? _error;

  bool get isLoaded => _loaded;
  String? get error => _error;
  UnmodifiableListView<JobModel> get jobs => UnmodifiableListView(_jobs);

  Future<void> fetchJobs(String companyId) async {
    _loaded = false;
    _error = null;
    notifyListeners();

    try {
      final fetched = await JobService.getJobs(companyId);

      _jobs
        ..clear()
        ..addAll(fetched);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loaded = true;
      notifyListeners();
    }
  }

  Future<void> addNewJob(JobModel newJob) async {
    try {
      await JobService.addJob(newJob);
      _jobs.add(newJob);
      notifyListeners();
    } catch (e) {
      throw Exception("Error in JobProvider.addNewJob: $e");
    }
  }
}
