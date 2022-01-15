import 'package:todo/models/habit_log_model.dart';

class FrequencyDay {
  int day;

  bool isDone;

  bool isResetForToday;

  HabitLog dayLog;

  FrequencyDay(
      {required this.day,
      this.isDone = false,
      required this.dayLog,
      this.isResetForToday = false});
}
