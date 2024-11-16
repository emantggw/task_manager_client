import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/app/app.locator.dart';
import 'package:task_manager/services/task_service.dart';
import 'package:task_manager/ui/enums/task_status.enum.dart';
import 'package:task_manager/ui/model/Task.dart';

class CreateTaskViewModel extends BaseViewModel {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _taskService = locator<TaskService>();
  final _navigationService = locator<NavigationService>();

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      //
      try {
        setBusy(true);
        Task updatedTask = Task(
            title: titleController.text,
            category: categoryController.text,
            description: descriptionController.text,
            status: TaskStatus.active);
        await _taskService.createTask(updatedTask);
        _navigationService.back(result: true);
      } catch (e) {
        //got an error;
        debugPrint("Got an error.");
        debugPrint(e.toString());
      } finally {
        setBusy(false);
        rebuildUi();
      }
    }
  }

  String? textValidator(String? p1) {
    if (p1 == null || p1.isEmpty) {
      return "Please enter the value here.";
    }
    return null;
  }
}
