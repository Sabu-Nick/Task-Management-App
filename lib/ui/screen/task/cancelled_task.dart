import 'package:flutter/material.dart';
import 'package:taskmanagementapp/ui/widgets/center_circular_progress_indicator.dart';

import '../../../data/models/task_list_module.dart';
import '../../../data/models/task_model.dart';
import '../../../data/network_caller.dart';
import '../../../data/network_response.dart';
import '../../../data/urls.dart';
import '../../widgets/snack_bar_mgs.dart';
import '../../widgets/task_card.dart'; // Import the TaskCard widget

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskListInProgress = false;
  List<TaskModel> _cancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getCancelledTaskListInProgress,
      replacement: CenterCircularProgressIndicator(),
      child: RefreshIndicator(
        onRefresh: () async {
          await _getCancelledTaskList();
        },
        child: ListView.separated(
          itemCount: _cancelledTaskList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TaskCard(
                taskModel: _cancelledTaskList[index],
                onRefreshList: _getCancelledTaskList,
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

  Future<void> _getCancelledTaskList() async {
    setState(() => _getCancelledTaskListInProgress = true);

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.cancelledTaskList);

    if (response.isSuccess) {

      debugPrint('Cancelled Task Response: ${response.responseData}');

      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);

      setState(() {
        _cancelledTaskList = taskListModel.taskList ?? [];
        _getCancelledTaskListInProgress = false;
      });

      // Print the number of tasks in the cancelled task list to verify
      debugPrint('Number of Cancelled Tasks: ${_cancelledTaskList.length}');
    } else {
      setState(() => _getCancelledTaskListInProgress = false);
      SnackBarMessages(context, 'There seems to be a mistake.', true);
    }
  }

}
