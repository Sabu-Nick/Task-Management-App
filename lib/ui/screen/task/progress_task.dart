
import 'package:flutter/material.dart';
import 'package:taskmanagementapp/ui/widgets/center_circular_progress_indicator.dart';

import '../../../data/models/task_list_module.dart';
import '../../../data/models/task_model.dart';
import '../../../data/network_caller.dart';
import '../../../data/network_response.dart';
import '../../../data/urls.dart';
import '../../widgets/snack_bar_mgs.dart';
import '../../widgets/task_card.dart';



class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  bool _getProgressTaskListInProgress = false;
  List<TaskModel> _progressTaskList = [];

  @override
  void initState() {
    super.initState();
    _getProgressTaskList();
  }


  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _getProgressTaskListInProgress == false,
      replacement: CenterCircularProgressIndicator(),

      child: RefreshIndicator(
        onRefresh: () async {
          await _getProgressTaskList();
        },
        child: ListView.separated(
          itemCount: _progressTaskList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TaskCard(
                taskModel: _progressTaskList[index],
                onRefreshList: _getProgressTaskList,
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 8,
            );
          },
        ),
      ),
    );
  }

  Future<void> _getProgressTaskList() async {
    setState(() => _getProgressTaskListInProgress = true);

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.progressTaskList);

    if (response.isSuccess) {

      debugPrint('Cancelled Task Response: ${response.responseData}');

      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);

      setState(() {
        _progressTaskList = taskListModel.taskList ?? [];
        _getProgressTaskListInProgress = false;
      });

      // Print the number of tasks in the cancelled task list to verify
      debugPrint('Number of Cancelled Tasks: ${_progressTaskList.length}');
    } else {
      setState(() => _getProgressTaskListInProgress = false);
      SnackBarMessages(context, 'There seems to be a mistake.', true);
    }
  }



}
