import 'package:stacked/stacked.dart';
import 'package:task_manager/app/app.locator.dart';
import 'package:task_manager/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/services/task_service.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _taskService = locator<TaskService>();

  Future runStartupLogic() async {
    final tasks = await _taskService.getAllTasks();
    _navigationService.replaceWithHomeView(tasks: tasks);
  }
}
