import 'package:todo/models/note_model.dart';
import 'package:todo/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:todo/providers/add_new_list_provider.dart';

class NewList {
  final String title;
  bool isExpanded;

  final List<Note> listOfNotes;

  final String listID;
  final ListType listType;
  final List<Task> listofTasks;
  final List<Task> listofCompletedTasks;
  final List<Task> listofUnCompletedTasks;
  final Color listColor;

  NewList({
    this.isExpanded = false,
    this.listofUnCompletedTasks = const [],
    this.listofCompletedTasks = const [],
    required this.listType,
    this.listColor = Colors.transparent,
    required this.listID,
    required this.listofTasks,
    required this.title,
    required this.listOfNotes,
  });
}
