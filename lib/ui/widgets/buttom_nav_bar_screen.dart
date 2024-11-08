import 'package:flutter/material.dart';
import 'package:taskmanagementapp/ui/widgets/background_screen.dart';

import '../screen/task/cancelled_task.dart';
import '../screen/task/complete_task.dart';
import '../screen/task/new_task_screen.dart';
import '../screen/task/progress_task.dart';

import 'task_appbar.dart';

class ButtomNavBarScreen extends StatefulWidget {
  const ButtomNavBarScreen({super.key});

  @override
  State<ButtomNavBarScreen> createState() => _ButtomNavBarScreenState();
}

class _ButtomNavBarScreenState extends State<ButtomNavBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _taskScreen = const [
    NewTaskScreen(),
    CompleteTaskScreen(),
    CancelledTaskScreen(),
    ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskMenegerAppBar(),
      body: ScreenBackground(
          child: _taskScreen[_selectedIndex]
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(
              color: Colors.white, // Active label color
            ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.black87,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            _selectedIndex = index;
            setState(() {});
          },
          destinations: [
            NavigationDestination(
                icon: Icon(
                  Icons.near_me,
                  color: Colors.white,
                ),
                label: "New Task"),
            NavigationDestination(
                icon: Icon(
                  Icons.done_all,
                  color: Colors.white,
                ),
                label: "Complete"),
            NavigationDestination(
              icon: Icon(
                Icons.cancel_presentation,
                color: Colors.white,
              ),
              label: "Cancelled",
            ),
            NavigationDestination(
                icon: Icon(
                  Icons.incomplete_circle,
                  color: Colors.white,
                ),
                label: "Progress"),
          ],
        ),
      ),
    );
  }
}
