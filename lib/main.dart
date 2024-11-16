import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/app/app.bottomsheets.dart';
import 'package:task_manager/app/app.dialogs.dart';
import 'package:task_manager/app/app.locator.dart';
import 'package:task_manager/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/state/TaskStateProvider.dart';

SharedPreferences? localStorage;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  localStorage = await SharedPreferences.getInstance();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TaskStateProvider())],
      child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
