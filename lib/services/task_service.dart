import 'dart:convert';

import 'package:task_manager/app/api/factory/api.factory.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/ui/model/Task.dart';

class TaskService {
  final _apiRepo = APIRepoFactory.instance();
  final _baseEndpoint = "tasks";

  Future<List<Task>> getAllTasks({bool refresh = false}) async {
    String prefKey = "$_baseEndpoint/all";
    List<dynamic> data;
    if (refresh) {
      data = await _apiRepo.getData("$_baseEndpoint/all");
      localStorage?.setStringList(
          prefKey, List<String>.from(data.map((e) => jsonEncode(e))).toList());
    } else {
      data = (localStorage?.getStringList(prefKey) ?? [])
          .map((e) => jsonDecode(e))
          .toList();
    }
    return List<Task>.from(data.map((dt) => Task.fromJson(dt)));
  }

  Future<bool> updateTask(Task task) async {
    return await _apiRepo.updateData("$_baseEndpoint/update", task.toJson());
  }

  Future<void> createTask(Task task) async {
    await _apiRepo.postData("$_baseEndpoint/create", task.toJson());
  }

  Future<bool> deleteTask(String taskId) async {
    return await _apiRepo.deleteData("$_baseEndpoint/$taskId", {});
  }
}
