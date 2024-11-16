import 'package:task_manager/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:task_manager/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:task_manager/ui/views/home/home_view.dart';
import 'package:task_manager/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/services/task_service.dart';
import 'package:task_manager/ui/views/create_task/create_task_view.dart';
import 'package:task_manager/ui/views/edit_task/edit_task_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: CreateTaskView),
    MaterialRoute(page: EditTaskView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: TaskService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
