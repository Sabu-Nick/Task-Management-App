import 'package:flutter/material.dart';
import 'package:taskmanagementapp/ui/screen/splash_screem.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey, // Fix here: added a comma instead of a dot
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
