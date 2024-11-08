import 'package:flutter/material.dart';
import 'package:taskmanagementapp/data/network_caller.dart';
import 'package:taskmanagementapp/data/network_response.dart';
import 'package:taskmanagementapp/data/urls.dart';
import 'package:taskmanagementapp/ui/widgets/center_circular_progress_indicator.dart';
import 'package:taskmanagementapp/ui/widgets/snack_bar_mgs.dart';
import '../../data/models/task_model.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.onRefreshList,
  });

  final TaskModel taskModel;
  final VoidCallback onRefreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String _selectedTasks = '';
  bool _changeStatusInProgress = false;
  bool _deleteTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    _selectedTasks = widget.taskModel.status ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: Colors.white10,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title ?? '',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
            ),
            Text(
              'Date: ${widget.taskModel.createdDate ?? ''}',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.taskModel.description ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.red),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTaskChip(),
                Wrap(
                  children: [
                    Visibility(
                      visible: !_changeStatusInProgress,
                      replacement: CenterCircularProgressIndicator(),
                      child: IconButton(
                        onPressed: _onTabEditButton,
                        icon: Icon(
                          Icons.edit_calendar,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _deleteTaskInProgress == false,
                      replacement: CenterCircularProgressIndicator(),
                      child: IconButton(
                        onPressed: _onTabDeletedButton,
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Edit button function
  void _onTabEditButton() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red),
          ),
          title: Text(
            "Edit Status",
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ['New', 'Completed', 'Cancelled', 'In Progress']
                  .map((status) {
                return ListTile(
                  title: Text(
                    status,
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: _selectedTasks == status,
                  trailing: _selectedTasks == status
                      ? Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    _changeStatus(status);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Delete button function
  Future<void> _onTabDeletedButton() async {
    setState(() {
      _deleteTaskInProgress = true;
    });

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.deleteTask(widget.taskModel.sId!),
    );
    if (response.isSuccess) {
      widget.onRefreshList();
    } else {
      SnackBarMessages(context, 'Something is wrong', true);
    }

    setState(() {
      _deleteTaskInProgress = false;
    });
  }

  // Task Chip widget
  Chip _buildTaskChip() {
    return Chip(
      label: Text(
        widget.taskModel.status!,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  // Change Status function
  Future<void> _changeStatus(String newStatus) async {
    setState(() {
      _changeStatusInProgress = true;
    });

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.changeStatus(widget.taskModel.sId!, newStatus),
    );
    if (response.isSuccess) {
      setState(() {
        _selectedTasks = newStatus;
      });
      widget.onRefreshList(); // Ensure list is refreshed
    } else {
      SnackBarMessages(context, 'Something is wrong', true);
    }

    setState(() {
      _changeStatusInProgress = false;
    });
  }
}
