import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/app/app.locator.dart';
import 'package:task_manager/services/task_service.dart';
import 'package:task_manager/ui/enums/task_status.enum.dart';
import 'package:task_manager/ui/model/Task.dart';

class EditTaskViewModel extends BaseViewModel {
  final Task task;
  EditTaskViewModel({required this.task});
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _taskService = locator<TaskService>();

  final _navigationService = locator<NavigationService>();

  bool isDone = false;

  setUp() {
    titleController.text = task.title;
    descriptionController.text = task.description;
    categoryController.text = task.category;
    isDone = task.status.isDone;
  }

  onEdit() async {
    if (formKey.currentState?.validate() ?? false) {
      //
      Task updatedTask = task.copyWith(
          title: titleController.text,
          category: categoryController.text,
          description: descriptionController.text,
          status: isDone ? TaskStatus.done : TaskStatus.active);
      try {
        setBusy(true);
        await _taskService.updateTask(updatedTask);
        _navigationService.back(result: true);
      } catch (e) {
        //got an error
      } finally {
        setBusy(false);
      }
    }
  }

  String? textValidator(String? p1) {
    if (p1 == null || p1.isEmpty) {
      return "Please enter the value here.";
    }
    return null;
  }

  void onDoneToggler(bool value) {
    isDone = value;
    rebuildUi();
  }
}
