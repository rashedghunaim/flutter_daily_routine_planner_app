import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/assets/icons/second_expansion_icons_icons.dart';
import 'package:todo/models/frequencyDay_model.dart';
import 'package:todo/models/habit_category_model.dart';
import 'package:todo/models/habit_day_model.dart';
import 'package:todo/models/habit_log_model.dart';
import 'package:todo/models/habit_model.dart';

class HabitsProvider with ChangeNotifier {
  List<Color> firstExpansionColors = [
    Colors.purple,
    Colors.white70,
    Colors.red,
    Colors.yellowAccent,
    Colors.pink,
    Colors.purpleAccent,
    Colors.lightBlueAccent,
    Colors.pinkAccent,
    Colors.brown,
    Colors.blueGrey,
    Colors.green,
    Colors.red,
    Colors.brown,
    Colors.black54,
    Colors.black12,
    Colors.blue,
    Colors.lightBlue,
    Colors.pinkAccent,
    Colors.red,
    Colors.yellow,
    Colors.lightGreen,
    Colors.black54,
    Colors.purple,
    Colors.deepPurple,
    Colors.deepOrangeAccent,
    Colors.white70,
    Colors.black54,
    Colors.lightBlueAccent,
    Colors.deepOrange,
    Colors.teal,
  ];

  List<Color> secondExpansionColors = [
    Colors.purple,
    Colors.white70,
    Colors.red,
    Colors.yellowAccent,
    Colors.pink,
    Colors.purpleAccent,
    Colors.lightBlueAccent,
    Colors.pinkAccent,
    Colors.brown,
    Colors.blueGrey,
    Colors.green,
    Colors.red,
    Colors.brown,
    Colors.black54,
    Colors.black12,
    Colors.blue,
    Colors.lightBlue,
    Colors.pinkAccent,
    Colors.red,
    Colors.yellow,
    Colors.lightGreen,
    Colors.black54,
    Colors.purple,
    Colors.deepPurple,
    Colors.deepOrangeAccent,
    Colors.white70,
    Colors.black54,
    Colors.lightBlueAccent,
    Colors.deepOrange,
    Colors.teal,
  ];

  List<IconData> firstExpansionIcons = [
    Icons.home_outlined,
    Icons.favorite_outlined,
    Icons.face_outlined,
    Icons.manage_accounts_outlined,
    Icons.question_answer_outlined,
    Icons.star_rate_outlined,
    Icons.room_outlined,
    Icons.supervisor_account_outlined,
    Icons.open_in_full_outlined,
    Icons.accessibility_outlined,
    Icons.nightlight_round_outlined,
    Icons.production_quantity_limits_outlined,
    Icons.alarm_on_outlined,
    Icons.alarm_off_outlined,
    Icons.refresh_outlined,
    Icons.south_west_outlined,
    Icons.person_add_outlined,
    Icons.engineering_outlined,
    Icons.self_improvement_outlined,
    Icons.sports_tennis_outlined,
    Icons.add_moderator_outlined,
    Icons.public_off_outlined,
    Icons.sledding_outlined,
    Icons.face_retouching_natural_outlined,
    Icons.music_off_outlined,
    Icons.support_agent_outlined,
    Icons.family_restroom_outlined,
    Icons.print,
    Icons.remove,
    Icons.keyboard,
    Icons.work,
    Icons.wine_bar,
  ];

  List<IconData> secondExpansionIcons = [
    SecondExpansionIcons.fitness_center,
    SecondExpansionIcons.adjust,
    SecondExpansionIcons.blind,
    SecondExpansionIcons.chat,
    SecondExpansionIcons.coffee,
    SecondExpansionIcons.device_camera_video,
    SecondExpansionIcons.dumbbell,
    SecondExpansionIcons.emo_coffee,
    SecondExpansionIcons.emo_saint,
    SecondExpansionIcons.graduation_cap,
    SecondExpansionIcons.group,
    SecondExpansionIcons.group_add,
    SecondExpansionIcons.hammer,
    SecondExpansionIcons.hand_holding_heart,
    SecondExpansionIcons.hands_helping,
    SecondExpansionIcons.local_dining,
    SecondExpansionIcons.local_florist,
    SecondExpansionIcons.local_grocery_store,
    SecondExpansionIcons.local_post_office,
    SecondExpansionIcons.megaphone,
    SecondExpansionIcons.monitor,
    SecondExpansionIcons.moon,
    SecondExpansionIcons.music,
    SecondExpansionIcons.parachute_box,
    SecondExpansionIcons.picture,
    SecondExpansionIcons.windy_rain,
    SecondExpansionIcons.stopwatch,
    SecondExpansionIcons.progress_3,
  ];

  List<HabitCategory> _defaultCategories = [
    HabitCategory(
      habits: [],
      title: 'Meditation',
      categoryID: DateTime.now().toString(),
      categoryColor: Colors.purple,
      categoryIcon: Icons.self_improvement,
    ),
    HabitCategory(
      habits: [],
      title: 'Sports',
      categoryID: DateTime.now().toString(),
      categoryIcon: Icons.fitness_center,
      categoryColor: Colors.blueAccent,
    ),
    HabitCategory(
      habits: [],
      title: 'Social',
      categoryID: DateTime.now().toString(),
      categoryColor: Colors.green,
      categoryIcon: Icons.group,
    ),
    HabitCategory(
      habits: [],
      title: 'Nutrition',
      categoryID: DateTime.now().toString(),
      categoryIcon: Icons.restaurant_menu,
      categoryColor: Colors.amber,
    ),
    HabitCategory(
      habits: [],
      title: 'Outdoor',
      categoryID: DateTime.now().toString(),
      categoryIcon: Icons.nature_people,
      categoryColor: Colors.red,
    ),
    HabitCategory(
      habits: [],
      title: 'Work',
      categoryID: DateTime.now().toString(),
      categoryIcon: Icons.business_center,
      categoryColor: Colors.brown,
    ),
    HabitCategory(
      habits: [],
      title: 'Quit a bad habit',
      categoryID: DateTime.now().toString(),
      categoryColor: Color(0xff5c1521),
      categoryIcon: Icons.block,
    ),
    HabitCategory(
      habits: [],
      title: 'Study',
      categoryID: DateTime.now().toString(),
      categoryIcon: Icons.school,
      categoryColor: Colors.deepPurple,
    ),
    HabitCategory(
      habits: [],
      title: 'Entertainment',
      categoryID: DateTime.now().toString(),
      categoryColor: Colors.teal,
    ),
    HabitCategory(
      habits: [],
      title: 'Health',
      categoryID: DateTime.now().toString(),
      categoryColor: Colors.lightGreenAccent,
      categoryIcon: Icons.healing,
    ),
    HabitCategory(
      habits: [],
      title: 'Home',
      categoryID: DateTime.now().toString(),
      categoryIcon: Icons.home,
      categoryColor: Colors.deepOrange,
    ),
    HabitCategory(
      habits: [],
      title: 'Art',
      categoryID: DateTime.now().toString(),
      categoryColor: Colors.redAccent,
      categoryIcon: Icons.brush_rounded,
    ),
    HabitCategory(
      habits: [],
      title: 'Finance',
      categoryID: DateTime.now().toString(),
      categoryIcon: Icons.money_off,
      categoryColor: Colors.white70,
    ),
    HabitCategory(
      habits: [],
      title: 'Other',
      categoryID: DateTime.now().toString(),
      categoryIcon: Icons.more_horiz,
      categoryColor: Colors.white70,
    ),
  ];

  List<HabitCategory> get getDefaultCategories {
    return [..._defaultCategories];
  }

  List<HabitCategory> _userCategories = [];

  List<HabitCategory> get getUserCategories {
    return [..._userCategories];
  }

  List<Habit> _calendarDailyHabits = [];
  List<Habit> getDailyCalendarHabits = [];

  void generateCalendarHabits(DateTime selectedDay) {
    for (var habit in _calendarDailyHabits) {
      for (var day in habit.goalDays) {
        if (day.frequencyDay.day == selectedDay.day) {
          if (getDailyCalendarHabits.contains(habit)) {
          } else {
            getDailyCalendarHabits.add(habit);
          }
        }
      }
    }

    notifyListeners();
  }

  void addNewCategory(HabitCategory userCategory) {
    if (_userCategories.contains(userCategory)) {
    } else {
      if (_defaultCategories.contains(userCategory)) {
        _userCategories.add(userCategory);
      } else {
        _userCategories.add(userCategory);
        _defaultCategories.add(userCategory);
      }
    }
    notifyListeners();
  }

  void addNewHabit(Habit userHabit) {
    HabitCategory _userCategory = _userCategories.firstWhere(
      (category) => category.categoryID == userHabit.habitCategoryID,
    );
    _userCategory.habits.insert(0, userHabit);
    _calendarDailyHabits.add(userHabit);

    notifyListeners();
  }

  void updateUserCategory(HabitCategory selectedCategory) {
    int selectedCategoryIndex = _userCategories.indexWhere(
        (category) => category.categoryID == selectedCategory.categoryID);
    _userCategories[selectedCategoryIndex] = selectedCategory;
    notifyListeners();
  }

  void updateUserHabit(Habit selectedHabit) {
    int selectedCategoryIndex = _userCategories.indexWhere(
        (category) => category.categoryID == selectedHabit.habitCategoryID);
    int selectedHabitIndex = _userCategories[selectedCategoryIndex]
        .habits
        .indexWhere((element) => element.habitID == selectedHabit.habitID);
    _userCategories[selectedCategoryIndex].habits[selectedHabitIndex] =
        selectedHabit;
    notifyListeners();
  }

  void deleteUserCategory(HabitCategory selectedCategory) {
    _userCategories.removeWhere(
        (element) => element.categoryID == selectedCategory.categoryID);
    notifyListeners();
  }

  void deleteUserHabit(Habit selectedHabit) {
    int selectedCategoryIndex = _userCategories.indexWhere(
        (category) => category.categoryID == selectedHabit.habitCategoryID);

    _userCategories[selectedCategoryIndex]
        .habits
        .removeWhere((element) => element.habitID == selectedHabit.habitID);
    notifyListeners();
  }

  Habit? getHabitByID(String categoryID) {
    HabitCategory selectedCategory = _userCategories
        .firstWhere((element) => element.categoryID == categoryID);

    if (selectedCategory.habits.isEmpty) {
      return null;
    } else {
      Habit selectedHabit = selectedCategory.habits
          .firstWhere((element) => element.habitCategoryID == categoryID);
      return selectedHabit;
    }
  }

  static DateTime endDay = DateTime.now();
  int calendarFrequencyDay = DateTime.now().day;

  void generateTargetedDays(Habit habit, int pickedGoal) {
    List<Day> _goalDays = [];

    int pGoal = pickedGoal;
    if (pickedGoal == 0) {
      pGoal = 365;
    } else {
      pGoal = pickedGoal;
    }

    List.generate(pGoal, (index) {
      DateTime startsDay = habit.startDate;
      habit.lastDay = endDay;
      DateTime weekDay = startsDay.add(Duration(days: index));
      endDay = startsDay.add(Duration(days: pGoal));

      if (habit.frequency.containsValue(weekDay.day)) {
        _goalDays.add(
          Day(
            goalPerDay: [],
            weekDay: weekDay,
            isAchieved: false,
            frequencyDay: FrequencyDay(
              dayLog: HabitLog(
                logDescription: '',
                logEmojie: '',
              ),
              day: weekDay.day,
              isDone: false,
              isResetForToday: false,
            ),
          ),
        );
        calendarFrequencyDay = weekDay.day;
      } else {
        _goalDays.add(
          Day(
            goalPerDay: [],
            weekDay: weekDay,
            isAchieved: false,
            frequencyDay: FrequencyDay(
              day: 0,
              dayLog: HabitLog(
                logDescription: '',
                logEmojie: '',
              ),
              isResetForToday: false,
              isDone: false,
            ),
          ),
        );
        calendarFrequencyDay = 0;
      }
    });
    habit.goalDays = _goalDays;
    notifyListeners();
  }

  void generateGoalsPerDay(Habit habit) {
    List.generate(habit.dayAchievementGoal.values.first, (index) {
      for (var i in habit.goalDays) {
        i.goalPerDay.add(index + 1);
      }
    });
    notifyListeners();
  }

  void completingGoalPerDay(Habit habit, int completedValue) {
    habit.goalPerDayValue = completedValue;
    if (DateTime.now().day == habit.startDate.day &&
        DateTime.now().month == habit.startDate.month &&
        DateTime.now().year == habit.startDate.year) {
      Day achievedDay = habit.goalDays.firstWhere(
        (element) => element.frequencyDay.day == DateTime.now().day,
      );
      achievedDay.goalPerDay.remove(completedValue);
      if (habit.achievedDays.contains(achievedDay)) {
      } else {
        if (achievedDay.goalPerDay.isEmpty) {
          habit.goalPerDayValue = 0;

          habit.isAchievedForToday = true;
          habit.isResetForToday = true;
          achievedDay.isAchieved = true;
          habit.achievedDays.add(achievedDay);
        }
      }
    }
    notifyListeners();
  }

  int frequencyDayIndex = 0;

  void completingHabit(Habit habit) {
    habit.isAchievedForToday = true;
    habit.isResetForToday = true;
    if (DateTime.now().day == habit.startDate.day &&
        DateTime.now().month == habit.startDate.month &&
        DateTime.now().year == habit.startDate.year) {
      Day achievedDay = habit.goalDays.firstWhere(
        (element) => element.frequencyDay.day == DateTime.now().day,
      );

      if (habit.achievedDays.contains(achievedDay)) {
      } else {
        habit.achievedDays.add(achievedDay);
      }
    }
    notifyListeners();
  }

  void unCompleteHabit(Habit habit) {
    if (DateTime.now().day == habit.startDate.day &&
        DateTime.now().month == habit.startDate.month &&
        DateTime.now().year == habit.startDate.year) {
      if (habit.achievedDays.isNotEmpty) {
        Day unaAchievedDay = habit.achievedDays.firstWhere(
          (element) =>
              element.weekDay.day == DateTime.now().day &&
              element.weekDay.month == DateTime.now().month &&
              element.weekDay.year == DateTime.now().year,
        );

        habit.isAchievedForToday = false;
        habit.isResetForToday = true;

        habit.achievedDays.remove(unaAchievedDay);
        habit.unAchievedDays.add(unaAchievedDay);
      } else {
        Day unaAchievedDay = habit.goalDays.firstWhere(
          (element) =>
              element.weekDay.day == DateTime.now().day &&
              element.weekDay.month == DateTime.now().month &&
              element.weekDay.year == DateTime.now().year,
        );
        habit.isAchievedForToday = false;
        habit.isResetForToday = true;

        habit.unAchievedDays.add(unaAchievedDay);
      }
    }
    notifyListeners();
  }

  void reSetHabit(Habit habit) {
    habit.isAchievedForToday = false;
    habit.isResetForToday = false;
    Day resetedDay = Day(
      goalPerDay: [],
      weekDay: DateTime.now(),
      isAchieved: false,
      frequencyDay: FrequencyDay(
        day: 0,
        dayLog: HabitLog(
          logDescription: '',
          logEmojie: '',
        ),
        isResetForToday: false,
        isDone: false,
      ),
    );

    resetedDay = habit.goalDays.firstWhere(
      (day) =>
          DateTime.now().day == day.frequencyDay.day &&
          DateTime.now().month == day.weekDay.month &&
          DateTime.now().year == day.weekDay.year,
    );

    if (habit.achievedDays.contains(resetedDay)) {
      habit.achievedDays.removeWhere(
        (day) =>
            DateTime.now().day == day.frequencyDay.day &&
            DateTime.now().month == day.weekDay.month &&
            DateTime.now().year == day.weekDay.year,
      );

      List.generate(habit.dayAchievementGoal.values.first, (index) {
        for (var i in habit.goalDays) {
          i.goalPerDay.add(index + 1);
        }
      });
    } else {
      habit.unAchievedDays.removeWhere(
        (day) =>
            DateTime.now().day == day.frequencyDay.day &&
            DateTime.now().month == day.weekDay.month &&
            DateTime.now().year == day.weekDay.year,
      );
    }

    notifyListeners();
  }

// void completingFromDetailsDashBoardGoalPerDay(
//     Habit habit, int completedValue, DateTime selectedDay) {
//   habit.goalPerDayValue = completedValue;
//   Day achievedDay = habit.goalDays.firstWhere(
//     (element) => element.frequencyDay.day == selectedDay.day,
//   );
//   achievedDay.goalPerDay.remove(completedValue);
//   if (habit.achievedDays.contains(achievedDay)) {
//   } else {
//     if (achievedDay.goalPerDay.isEmpty) {
//       habit.goalPerDayValue = 0;
//       habit.isAchievedForToday = true;
//       habit.isResetForToday = true;
//       achievedDay.isAchieved = true;
//       habit.achievedDays.add(achievedDay);
//     }
//   }
//   notifyListeners();
// }

//
// void completingFromDetailsDashBoard(Habit habit, DateTime selectedDay) {
//   Day achievedDay = habit.goalDays.firstWhere(
//     (element) => element.frequencyDay.day == selectedDay.day,
//   );
//
//   frequencyDayIndex = habit.goalDays
//       .indexWhere((element) => element.frequencyDay.day == selectedDay.day);
//
//   if (habit.achievedDays.contains(achievedDay)) {
//   } else {
//     achievedDay.frequencyDay.isDone = true;
//     achievedDay.frequencyDay.isResetForToday = true;
//     habit.achievedDays.add(achievedDay);
//   }
//   print(achievedDay.frequencyDay.day.toString());
//   notifyListeners();
// }

// void unCompletingFromDetailsDashBoard(Habit habit, DateTime selectedDay) {
//
//   if(habit.achievedDays.contains(selectedDay)){
//     Day unaAchievedDay = habit.achievedDays
//         .firstWhere((element) => element.frequencyDay.day == selectedDay.day);
//     frequencyDayIndex = habit.goalDays
//         .indexWhere((element) => element.frequencyDay.day == selectedDay.day);
//     unaAchievedDay.frequencyDay.isDone = false;
//
//     habit.achievedDays.remove(unaAchievedDay);
//     habit.unAchievedDays.add(unaAchievedDay);
//   }
//
//
// else {
//     Day unaAchievedDay = habit.goalDays
//         .firstWhere((element) => element.frequencyDay.day == selectedDay.day);
//     unaAchievedDay.frequencyDay.isDone = false;
//     frequencyDayIndex = habit.goalDays
//         .indexWhere((element) => element.frequencyDay.day == selectedDay.day);
//     habit.unAchievedDays.add(unaAchievedDay);
//   }
//   notifyListeners();
// }

}
