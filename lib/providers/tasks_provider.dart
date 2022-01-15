import 'package:flutter/material.dart';
import 'package:todo/models/new_list_model.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/add_new_list_provider.dart';

class TasksProvider with ChangeNotifier {
  static bool isFirstTime = true;

  List<Task> _allInboxTasks = [];

  List<Task> get getAllInboxTasks {
    return [..._allInboxTasks];
  }

  static List<Task> _userTasks = [];

  List<Task> get getAllTasks {
    return [..._userTasks];
  }

  Map<String, NewList> _taskList = {};

  static List<Task> completedTasks = [];

  List<Task> get getCompletedTasks {
    return [...completedTasks];
  }

  void addNewTask(Task userTask, Map<String, NewList> selectedList) {
    final tomorrowDate = DateTime.now().add(Duration(days: 1));
    _taskList = selectedList;
    if (selectedList.containsKey(userTask.taskCategoryList) &&
        (userTask.date.day == DateTime.now().day &&
            userTask.date.month == DateTime.now().month &&
            userTask.date.year == DateTime.now().year)) {
      selectedList[userTask.taskCategoryList]!.listofTasks.insert(0, userTask);
      _userTasks.add(userTask);
      _allInboxTasks.add(userTask);
    } else if (selectedList.containsKey(userTask.taskCategoryList) &&
        (userTask.date.day < DateTime.now().day ||
            userTask.date.month < DateTime.now().month ||
            userTask.date.year < DateTime.now().year)) {
      selectedList[userTask.taskCategoryList]!
          .listofUnCompletedTasks
          .insert(0, userTask);
      _allInboxTasks.add(userTask);
    } else if (selectedList.containsKey(userTask.taskCategoryList) &&
        (userTask.date.day == tomorrowDate.day &&
            tomorrowDate.month == tomorrowDate.month &&
            tomorrowDate.year == tomorrowDate.year)) {
      selectedList[userTask.taskCategoryList]!.listofTasks.insert(0, userTask);
      _userTasks.add(userTask);
      _allInboxTasks.add(userTask);
    } else if (selectedList.containsKey(userTask.taskCategoryList) &&
        (userTask.date.day > DateTime.now().day ||
            userTask.date.month > DateTime.now().month ||
            userTask.date.year > DateTime.now().year)) {
      selectedList[userTask.taskCategoryList]!.listofTasks.insert(0, userTask);
      _allInboxTasks.add(userTask);
    } else {
      if (userTask.date.day == DateTime.now().day) {
        _calendarTasks.add(userTask);
      }

      _userTasks.add(userTask);
      _allInboxTasks.add(userTask);
    }
    isFirstTime = false;

    notifyListeners();
  }

  List<Task> get getTodayTasks {
    return _userTasks.where((element) {
      if (element.date.day == DateTime.now().day &&
          element.date.month == DateTime.now().month &&
          element.date.year == DateTime.now().year) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  List<Task> get getTomorrowTasks {
    final tomorrowDate = DateTime.now().add(Duration(days: 1));
    return _userTasks.where((element) {
      if (element.date.day == tomorrowDate.day &&
          element.date.month == tomorrowDate.month &&
          element.date.year == tomorrowDate.year) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  List<Task> get getTodayUncompletedTasks {
    return _userTasks.where((element) {
      if (element.date.day < DateTime.now().day ||
          element.date.month < DateTime.now().month ||
          element.date.year < DateTime.now().year) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  void completingTask(Task completedTask) {
    if (completedTask.taskCategoryList.isEmpty) {
      completedTask.isCompleted = !completedTask.isCompleted;
      completedTasks.insert(0, completedTask);
      _userTasks.removeWhere((element) => element.isCompleted == true);
      _calendarTasks.remove(completedTask);
      _allInboxTasks.remove(completedTask);
    } else {
      completedTask.isCompleted = !completedTask.isCompleted;
      _userTasks.removeWhere((element) => element.isCompleted == true);
      _allInboxTasks.remove(completedTask);
      _taskList[completedTask.taskCategoryList]!
          .listofCompletedTasks
          .insert(0, completedTask);
      _taskList[completedTask.taskCategoryList]!
          .listofTasks
          .remove(completedTask);
    }

    notifyListeners();
  }

  Task getTaskByID(String taskID) {
    return _userTasks.firstWhere((element) => element.taskID == taskID);
  }

  void deleteTask(Task task) {
    if (task.taskCategoryList.isEmpty) {
      _userTasks.removeWhere((element) => element.taskID == task.taskID);
      _allInboxTasks.removeWhere((element) => element.taskID == task.taskID);
    } else {
      _userTasks.removeWhere((element) => element.taskID == task.taskID);
      _allInboxTasks.removeWhere((element) => element.taskID == task.taskID);
      _taskList[task.taskCategoryList]!
          .listofTasks
          .removeWhere((element) => element.taskID == task.taskID);
    }

    notifyListeners();
  }

  List<Task> forTodayUserTasks = _userTasks;

  List<Task> forTomorrowUserTasks = _userTasks;

  void undoCompletingTask(Task undoCompletedTask) {
    if (undoCompletedTask.taskCategoryList.isEmpty) {
      undoCompletedTask.isCompleted = !undoCompletedTask.isCompleted;
      completedTasks.removeWhere((element) => element.isCompleted == false);
      _userTasks.insert(0, undoCompletedTask);
      _allInboxTasks.insert(0, undoCompletedTask);
    } else {
      undoCompletedTask.isCompleted = !undoCompletedTask.isCompleted;

      completedTasks.removeWhere((element) => element.isCompleted == false);
      _userTasks.insert(0, undoCompletedTask);
      _allInboxTasks.insert(0, undoCompletedTask);

      _taskList[undoCompletedTask.taskCategoryList]!
          .listofCompletedTasks
          .remove(undoCompletedTask);
      _taskList[undoCompletedTask.taskCategoryList]!
          .listofTasks
          .add(undoCompletedTask);
    }

    notifyListeners();
  }

  void updateTask(Task task) {
    if (task.taskCategoryList.isEmpty) {
      final taskIndex =
          _userTasks.indexWhere((element) => element.taskID == task.taskID);
      _userTasks[taskIndex] = task;
    } else {
      final taskIndex =
          _userTasks.indexWhere((element) => element.taskID == task.taskID);
      _userTasks[taskIndex] = task;

      final int taskListIndex = _taskList[task.taskCategoryList]!
          .listofTasks
          .indexWhere((element) => element.taskID == task.taskID);
      _taskList[task.taskCategoryList]!.listofTasks[taskListIndex] = task;
    }

    notifyListeners();
  }

  List<Task> _calendarTasks = [];

  List<Task> get getCalendarTasks {
    return [..._calendarTasks];
  }

  void calendarTasks(DateTime? selectedDate) {
    if (getTodayTasks.isNotEmpty) {
      _calendarTasks = _allInboxTasks
          .where(
            (element) =>
                element.date.day == selectedDate!.day &&
                element.date.month == selectedDate.month &&
                element.date.year == selectedDate.year,
          )
          .toList();
    }

    notifyListeners();
  }
}
