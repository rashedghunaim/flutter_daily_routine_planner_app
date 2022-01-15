import 'package:todo/models/frequencyDay_model.dart';

class Day {
  DateTime weekDay;
  List<int> goalPerDay;
  FrequencyDay frequencyDay;
  bool isAchieved;

  Day({
    required this.weekDay,
    required this.isAchieved,
    required this.frequencyDay,
    required this.goalPerDay ,

  });
}
