
import 'package:flutter/material.dart';
import 'package:taskmanagementapp/data/network_caller.dart';
import 'package:taskmanagementapp/data/network_response.dart';
import 'package:taskmanagementapp/ui/widgets/background_screen.dart';
import 'package:taskmanagementapp/ui/style/text_style.dart';

import '../../../data/urls.dart';
import '../../style/buttom_style.dart';
import '../../style/text_field_style.dart';

import '../../widgets/buttom_nav_bar_screen.dart';
import '../../widgets/snack_bar_mgs.dart';
import '../../widgets/task_appbar.dart';


class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  TextEditingController _titleTEControler = TextEditingController();
  TextEditingController _discriptionTEControler = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInProgess = false;
  bool _shouldRefreshPrivousPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskMenegerAppBar(),
      body: ScreenBackground(

        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text("Add New Task", style: AppTextStyles.headline),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _titleTEControler,
                    decoration: TextFormFieldDecoration("Title"),
                    style: TextStyle(color: Colors.white),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your task title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _discriptionTEControler,
                    maxLines: 6,
                    decoration: TextFormFieldDecoration("Description"),
                    style: TextStyle(color: Colors.white),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your task discription';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: !_addNewTaskInProgess,
                    replacement: CircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTabSubmiteTaskButton,
                      style: ElevatedButtonButtonStyle(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Submite Task',
                              style: AppTextStyles.buttonTextStyle),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTabSubmiteTaskButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();

    }
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgess = true;

    setState(() {});
    Map<String, dynamic> requestBody = {
      "title": _titleTEControler.text.trim(),
      "description": _discriptionTEControler.text.trim(),
      "status": "New"
    };
    final NetworkResponse response =
        await NetworkCaller.postRequest(
            url: Urls.addNewTask,
          body: requestBody

        );

    _addNewTaskInProgess = false;
    setState(() {});
    if (response.isSuccess) {

      _shouldRefreshPrivousPage = true;
      _clearTextField();
      SnackBarMessages(context, 'New Task Added!');

      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ButtomNavBarScreen()),
        );
      });



    } else {
      SnackBarMessages(context, 'Your forgot to add something', true);
    }
  }

  void _clearTextField() {
    _titleTEControler.clear();
    _discriptionTEControler.clear();
  }
}
