import 'package:collection/collection.dart';
import 'package:task_manager/app/app.locator.dart';
import 'package:task_manager/app/app.router.dart';
import 'package:task_manager/services/task_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/ui/common/ext_group_by.dart';
import 'package:task_manager/ui/model/Task.dart';

class HomeViewModel extends BaseViewModel {
  List<Task> tasks;

  HomeViewModel({required this.tasks});
  List<Task> updatedTasks = [];

  final _taskService = locator<TaskService>();
  final _navigationService = locator<NavigationService>();

  final _dialogService = locator<DialogService>();

  List<MapEntry<String, List<Task>>> groupedTasksByStatus = [];
  List<Task> get activeTasks => groupedTasksByStatus
      .where((k) => k.key == "active")
      .map((e) => e.value)
      .flattened
      .toList();

  List<Task> get closedTasks => groupedTasksByStatus
      .where((k) => k.key == "done")
      .map((e) => e.value)
      .flattened
      .toList();

  setUp() {
    _categorizeTasksByStatus();
  }

  _categorizeTasksByStatus() {
    groupedTasksByStatus = tasks.groupBy((t) => t.status.name).entries.toList();
    rebuildUi();
  }

  onCreateTask() async {
    bool? res = await _navigationService.navigateToCreateTaskView();
    if (res == true) {
      onRefresh();
    }
  }

  Future<void> onDeleteTask(Task p1) async {
    var status = await _dialogService.showDialog(
      title: "You're going to delete your task, are you sure",
      cancelTitle: "Cancel",
    );
    if (status?.confirmed == true) {
      //
      setBusy(true);

      await _taskService.deleteTask(p1.id!);
      onRefresh();
    }
  }

  onEdit(Task p1) async {
    bool? res = await _navigationService.navigateToEditTaskView(task: p1);
    if (res == true) {
      onRefresh();
    }
  }

  Future<void> onRefresh() async {
    try {
      setBusy(true);
      tasks = await _taskService.getAllTasks(refresh: true);
      setBusy(false);
      rebuildUi();
      setUp();
    } catch (e) {
      //got an error
    }
  }
}
