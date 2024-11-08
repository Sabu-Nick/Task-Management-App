import 'package:flutter/material.dart';
import 'package:taskmanagementapp/ui/widgets/center_circular_progress_indicator.dart';

import '../../../data/models/task_list_module.dart';
import '../../../data/models/task_model.dart';
import '../../../data/network_caller.dart';
import '../../../data/network_response.dart';
import '../../../data/urls.dart';
import '../../widgets/snack_bar_mgs.dart';
import '../../widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  bool _getCompletedTaskListInProgress = false;
  List<TaskModel> _completedTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCompleteTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getCompletedTaskListInProgress,
      replacement: CenterCircularProgressIndicator(),
      child: RefreshIndicator(
        onRefresh: () async {
          await _getCompleteTaskList();
        },
        child: ListView.separated(
          itemCount: _completedTaskList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TaskCard(
                taskModel: _completedTaskList[index],
                onRefreshList: _getCompleteTaskList,
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

  Future<void> _getCompleteTaskList() async {
    setState(() => _getCompletedTaskListInProgress = true);

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.completeTaskList);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      setState(() {
        _completedTaskList = taskListModel.taskList ?? [];
        _getCompletedTaskListInProgress = false;
      });
    } else {
      setState(() => _getCompletedTaskListInProgress = false);
      SnackBarMessages(context, 'There seems to be a mistake.', true);
    }
  }
}
