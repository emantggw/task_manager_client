import 'package:flutter/material.dart';
import 'package:task_manager/ui/model/Task.dart';

class TaskStateProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  set tasks(tks) {
    _tasks = tks;
    notifyListeners();
  }
}
