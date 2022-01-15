import 'package:flutter/material.dart';

import 'habit_day_model.dart';

class Habit {
  final String habitCategoryID;
  DateTime lastDay ;
  bool isAwaitForToday ;
  final String habitID;
  final String title;
  final String quote;
  bool isEditable  ;
  Map<String, int> frequency;
  Map<String, int> dayAchievementGoal;
  List<Day> goalDays;
  List<Day> achievedDays;
  List<Day> unAchievedDays;
  DateTime startDate;
  bool isAchievedForToday;
  bool isResetForToday;
   String habitLog;
   String emojiLog;
  IconData habitIcon ;
  int goalPerDayValue ;

  Habit({
    required this.habitCategoryID,
    required this.title,
    required this.frequency,
    required this.dayAchievementGoal,
    required this.goalDays,
    required this.habitID,
    this.habitLog = '',
    this.emojiLog = '',
    this.isAchievedForToday = false,
    this.quote = '',
    required this.startDate,
    required this.achievedDays,
    required this.unAchievedDays,
    this.isResetForToday = false,
    this.isEditable = false ,
    this.isAwaitForToday = false ,
    this.goalPerDayValue = 0 ,
    this.habitIcon = Icons.add  ,
    required this.lastDay ,
  });
}
