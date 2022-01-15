import 'package:flutter/material.dart';
import 'package:todo/models/new_list_model.dart';
import 'package:todo/models/note_model.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/tasks_provider.dart';

enum ListType { Task, Note }

class AddNewListProvider with ChangeNotifier {
  Map<String, NewList> _userLists = {};

  Map<String, NewList> get getUserLists {
    return {..._userLists};
  }

  String routeKey = '';

  String get getRouteKey {
    return routeKey;
  }

  void completingListTask(Task userListCompletedTask) {
    TasksProvider.completedTasks.add(userListCompletedTask);
    userListCompletedTask.isCompleted = !userListCompletedTask.isCompleted;
    if (_userLists.containsKey(userListCompletedTask.taskCategoryList)) {
      _userLists[userListCompletedTask.taskCategoryList]!
          .listofTasks
          .removeWhere((element) => element.isCompleted == true);
      _userLists[userListCompletedTask.taskCategoryList]!
          .listofCompletedTasks
          .add(userListCompletedTask);
    }
    notifyListeners();
  }

  void undoCompletingListTask(Task undoCompletedTask) {
    undoCompletedTask.isCompleted = !undoCompletedTask.isCompleted;
    if (_userLists.containsKey(undoCompletedTask.taskCategoryList)) {
      _userLists[undoCompletedTask.taskCategoryList]!
          .listofCompletedTasks
          .removeWhere((element) => element.isCompleted == false);
      _userLists[undoCompletedTask.taskCategoryList]!
          .listofTasks
          .insert(0, undoCompletedTask);
    }

    notifyListeners();
  }

  Task getTaskByID(Task task) {
    return _userLists[task.taskCategoryList]!
        .listofTasks
        .firstWhere((element) => element.taskID == task.taskID);
  }

  void deleteListTask(Task task) {
    _userLists[task.taskCategoryList]!
        .listofTasks
        .removeWhere((element) => element.taskID == task.taskID);
    notifyListeners();
  }

  void updateListTask(Task task, String movedToList) {
    if (movedToList.isEmpty) {
      final taskIndex =
          _userLists[task.taskCategoryList]!.listofTasks.indexWhere(
                (element) => element.taskID == task.taskID,
              );
      _userLists[task.taskCategoryList]!.listofTasks[taskIndex] = task;
    } else {
      final taskIndex =
          _userLists[task.taskCategoryList]!.listofTasks.indexWhere(
                (element) => element.taskID == task.taskID,
              );
      _userLists[task.taskCategoryList]!.listofTasks[taskIndex] = task;
      final transferedTask = _userLists[task.taskCategoryList]!
          .listofTasks
          .firstWhere((element) => element.taskID == task.taskID);
      _userLists[transferedTask.taskCategoryList]!
          .listofTasks
          .remove(transferedTask);
      transferedTask.taskCategoryList = movedToList;
      _userLists[transferedTask.taskCategoryList]!
          .listofTasks
          .insert(0, transferedTask);
    }
    notifyListeners();
  }

  void deleteUserList(String listKey) {
    _userLists.remove(listKey);
    notifyListeners();
  }

  void updateUserList(NewList newList, String listKey) {
    _userLists.remove(listKey);
    _userLists.putIfAbsent(
      newList.title,
      () => NewList(
        listType: newList.listType,
        listID: newList.listID,
        listOfNotes: newList.listOfNotes,
        listofTasks: newList.listofTasks,
        title: newList.title,
        listColor: newList.listColor,
        listofCompletedTasks: newList.listofCompletedTasks,
        listofUnCompletedTasks: newList.listofUnCompletedTasks,
      ),
    );

    notifyListeners();
  }

  dynamic getUserEditedList(String listKey) {
    return _userLists[listKey];
  }

  List<ExpantionItem> items = [];

  List<ExpantionItem> get getItems {
    return _userLists.values.toList().map((e) {
      return ExpantionItem(
        body: e.title,
        header: e.title,
      );
    }).toList();
  }

  void addNewNote(Note note) {
    if (_userLists[note.noteCategoryList]!.listOfNotes.contains(note)) {
    } else {
      _userLists[note.noteCategoryList]!.listOfNotes.add(note);
    }
    notifyListeners();
  }

  Note getNoteByID(String noteListName , Note note) {
    return _userLists[noteListName]!
        .listOfNotes
        .firstWhere((element) => element.noteID == note.noteID);
  }

  void updateNote(Note note) {
    int noteIndex = _userLists[note.noteCategoryList]!
        .listOfNotes
        .indexWhere((element) => element.noteID == note.noteID);
    _userLists[note.noteCategoryList]!.listOfNotes[noteIndex] = note;
    notifyListeners();
  }

  void deleteNote(Note note) {
    _userLists[note.noteCategoryList]!.listOfNotes.removeWhere(
          (element) => element.noteID == note.noteID,
        );
    notifyListeners();
  }

  void addNewList(NewList newList) {
    _userLists.putIfAbsent(
      newList.title,
      () => NewList(
        listType: newList.listType,
        listID: newList.listID,
        title: newList.title,
        listColor: newList.listColor,
        listofTasks: [],
        listOfNotes: [],
        listofCompletedTasks: [],
        listofUnCompletedTasks: [],
      ),
    );

    notifyListeners();
  }
}

class ExpantionItem {
  bool isExpanded;
  final String header;
  final String body;

  ExpantionItem({
    required this.body,
    required this.header,
    this.isExpanded = false,
  });
}
