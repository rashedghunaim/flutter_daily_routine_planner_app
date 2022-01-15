import 'package:flutter/material.dart';
import 'package:todo/providers/todo_button_provider.dart';

class Task {
  bool isExpanded ;
  final String title;
  final DateTime date;
  final TimeOfDay time;
  Priorities priority;
  final String taskID;
  bool isCompleted;
   String description;
  String taskCategoryList;

  Task({
    this.isExpanded = false ,
    this.description = '',
    this.taskCategoryList = '',
    this.isCompleted = false,
    required this.taskID,
    required this.date,
    this.priority = Priorities.None,
    required this.time,
    required this.title,
  });
}
