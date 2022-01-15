import 'package:flutter/material.dart';
import 'habit_model.dart';

class HabitCategory {
  final String title;
  final IconData categoryIcon;
  final String categoryID;
  final Color categoryColor;
  List<Habit> habits;
  bool isNewCategory ;

  HabitCategory({
    this.isNewCategory = false  ,
    required this.habits,
    required this.title,
    required this.categoryID,
    this.categoryColor = Colors.black,
    this.categoryIcon = Icons.add,
  });
}
