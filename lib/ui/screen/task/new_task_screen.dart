import 'package:flutter/material.dart';
import 'package:taskmanagementapp/data/models/task_status_count_model.dart';
import 'package:taskmanagementapp/data/models/task_status_model.dart';
import 'package:taskmanagementapp/data/network_caller.dart';
import 'package:taskmanagementapp/data/network_response.dart';
import 'package:taskmanagementapp/data/urls.dart';
import 'package:taskmanagementapp/ui/widgets/background_screen.dart';
import 'package:taskmanagementapp/ui/widgets/center_circular_progress_indicator.dart';
import '../../../data/models/task_list_module.dart';
import '../../../data/models/task_model.dart';
import '../../widgets/snack_bar_mgs.dart';
import '../../widgets/task_card.dart';
import '../../widgets/task_summary_card.dart';
import 'add_new_task.dart';

// class NewTaskScreen extends StatefulWidget {
//   const NewTaskScreen({super.key});
//
//   @override
//   State<NewTaskScreen> createState() => _NewTaskScreenState();
// }
//
// class _NewTaskScreenState extends State<NewTaskScreen> {
//   bool _getNewTaskListInProgress = false;
//   bool _getTaskStatusCountInProgress = false;
//   List<TaskModel> _newTaskList = [];
//   List<TaskStatusModel> _taskStatusCountList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _getNewTaskList();
//     _getTaskStatusCount();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black87,
//       body: RefreshIndicator(
//          onRefresh: ()async{
//            _getNewTaskList();
//            _getTaskStatusCount();
//          },
//         child: ScreenBackground(
//           child: Column(
//             children: [
//               _buildSummaryAction(),
//               Expanded(
//                 child: _getNewTaskListInProgress
//                     ? Center(child: CircularProgressIndicator())
//                     : Visibility(
//                         visible: !_getNewTaskListInProgress,
//                         replacement: CenterCircularProgressIndicator(),
//                         child: ListView.separated(
//                           itemCount: _newTaskList.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
//                               child: TaskCard(taskModel: _newTaskList[index],
//                                 onRefreshList: _getNewTaskList,
//
//                               ),
//                             );
//                           },
//                           separatorBuilder: (context, index) =>
//                               const SizedBox(height: 8),
//                         ),
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _onFabPressed,
//         child: const Icon(Icons.add, color: Colors.white),
//         backgroundColor: const Color.fromRGBO(236, 30, 38, 1),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
//       ),
//     );
//   }
//
//   Widget _buildSummaryAction() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Visibility(
//         visible: _getTaskStatusCountInProgress ==false,
//         replacement: CenterCircularProgressIndicator(),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: _getTaskSummaryList(),
//             // children: [
//             //   ..._taskStatusCountList.map((status) {
//             //     return TaskSummary(
//             //       count: 9,
//             //       title: 'New',
//             //     );
//             //   }).toList(),
//             // ],
//           ),
//
//         ),
//       ),
//     );
//   }
//
//   List<TaskSummary> _getTaskSummaryList(){
//     List<TaskSummary> taskSummaryList =[];
//     for(TaskStatusModel t in _taskStatusCountList){
//       taskSummaryList.add(TaskSummary(title: t.sId!, count: t.sum??0));
//     } return taskSummaryList;
//   }
//
//
//   Future<void> _onFabPressed() async {
//     final bool shouldRefresh = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const AddNewTask()),
//     );
//     if(shouldRefresh == true){
//       _getNewTaskList();
//     }
//   }
//
//   Future<void> _getNewTaskList() async {
//     _newTaskList.clear();
//     setState(() => _getNewTaskListInProgress = true);
//
//     final NetworkResponse response =
//         await NetworkCaller.getRequest(url: Urls.newTaskList);
//
//     if (response.isSuccess) {
//       final TaskListModel taskListModel =
//           TaskListModel.fromJson(response.responseData);
//       setState(() {
//         _newTaskList =
//             taskListModel.taskList ?? [];
//         _getNewTaskListInProgress = false;
//       });
//     } else {
//       setState(() => _getNewTaskListInProgress = false);
//       SnackBarMessages(context, 'There seems to be a mistake.', true);
//     }
//   }
//
//
//   Future<void> _getTaskStatusCount() async {
//     _taskStatusCountList.clear();
//     setState(() => _getTaskStatusCountInProgress = true);
//
//     final NetworkResponse response =
//     await NetworkCaller.getRequest(url: Urls.taskStatusCount);
//
//     if (response.isSuccess) {
//       final TaskStatusCountModel taskStatusCountModel =
//       TaskStatusCountModel.fromJson(response.responseData);
//       setState(() {
//         _taskStatusCountList = taskStatusCountModel.taskStatusCountList ?? [];
//       });
//     } else {
//       setState(() => _getTaskStatusCountInProgress = false);
//       SnackBarMessages(context, 'There seems to be a mistake.', true);
//     }
//   }
//
//
//
// }
class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskListInProgress = false;
  bool _getTaskStatusCountInProgress = false;
  List<TaskModel> _newTaskList = [];
  List<TaskStatusModel> _taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
    _getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: RefreshIndicator(
        onRefresh: () async {
          await _getNewTaskList();
          await _getTaskStatusCount();
        },
        child: ScreenBackground(
          child: Column(
            children: [
              _buildSummaryAction(),
              Expanded(
                child: _getNewTaskListInProgress
                    ? Center(child: CircularProgressIndicator())
                    : ListView.separated(
                  itemCount: _newTaskList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: TaskCard(
                        taskModel: _newTaskList[index],
                        onRefreshList: _getNewTaskList,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: 8),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: const Color.fromRGBO(236, 30, 38, 1),
      ),
    );
  }

  Widget _buildSummaryAction() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Visibility(
        visible: !_getTaskStatusCountInProgress,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _getTaskSummaryList(),
          ),
        ),
      ),
    );
  }

  List<TaskSummary> _getTaskSummaryList() {
    return _taskStatusCountList
        .map((t) => TaskSummary(title: t.sId ?? 'N/A', count: t.sum ?? 0))
        .toList();
  }

  Future<void> _onFabPressed() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewTask()),
    );
    if (shouldRefresh == true) {
      _getNewTaskList();
    }
  }

  Future<void> _getNewTaskList() async {
    setState(() => _getNewTaskListInProgress = true);
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.newTaskList);

    if (response.isSuccess) {
      final taskListModel = TaskListModel.fromJson(response.responseData);
      setState(() {
        _newTaskList = taskListModel.taskList ?? [];
        _getNewTaskListInProgress = false;
      });
    } else {
      setState(() => _getNewTaskListInProgress = false);
      SnackBarMessages(context, 'There seems to be a mistake.');
    }
  }

  Future<void> _getTaskStatusCount() async {
    setState(() => _getTaskStatusCountInProgress = true);
    final response = await NetworkCaller.getRequest(url: Urls.taskStatusCount);

    if (response.isSuccess) {
      final taskStatusCountModel = TaskStatusCountModel.fromJson(response.responseData);
      setState(() {
        _taskStatusCountList = taskStatusCountModel.taskStatusCountList ?? [];
        _getTaskStatusCountInProgress = false;
      });
    } else {
      setState(() => _getTaskStatusCountInProgress = false);
      SnackBarMessages(context, 'There seems to be a mistake.');
    }
  }
}