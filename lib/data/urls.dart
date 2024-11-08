class Urls {
  static const String _baseurl = 'http://35.73.30.144:2005/api/v1';
  static const String registration = '$_baseurl/Registration';
  static const String login ='$_baseurl/Login';
  static const String addNewTask = '$_baseurl/createTask';
  static const String newTaskList = '$_baseurl/listTaskByStatus/New';
  static const String completeTaskList = '$_baseurl/listTaskByStatus/Completed';
  static const String cancelledTaskList = '$_baseurl/listTaskByStatus/Cancelled';
  static const String taskStatusCount = '$_baseurl/taskStatusCount';
  static String changeStatus(String taskId, String status) =>
      '$_baseurl/listTaskByStatus/$taskId/$status';
  static const String progressTaskList = '$_baseurl/listTaskByStatus/Progress';


  static String deleteTask(String taskId) =>
      '$_baseurl/deleteTask/$taskId/';
}