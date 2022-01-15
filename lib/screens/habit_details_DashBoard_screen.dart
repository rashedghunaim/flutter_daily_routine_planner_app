import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:todo/assets/icons/my_emojies_icons.dart';
import 'package:todo/models/habit_model.dart';
import 'package:todo/providers/habits_provider.dart';
import 'package:todo/widgets/habit_dashBoard.dart';

class HabitDetailsDashBoard extends StatefulWidget {
  static const String routeName = './HabitDetailsDashBoardScreen';

  @override
  _HabitDetailsDashBoardState createState() => _HabitDetailsDashBoardState();
}

class _HabitDetailsDashBoardState extends State<HabitDetailsDashBoard> {
  bool isDidChangeActive = true;

  Habit habit = Habit(
    lastDay: DateTime.now(),
    habitCategoryID: 'habitCategoryID',
    title: 'title',
    frequency: {'v': 1},
    dayAchievementGoal: {"": 0},
    goalDays: [],
    habitID: 'habitID',
    startDate: DateTime.now(),
    achievedDays: [],
    unAchievedDays: [],
  );

  @override
  void didChangeDependencies() {
    if (isDidChangeActive) {
      habit = ModalRoute.of(context)!.settings.arguments as Habit;
    }
    isDidChangeActive = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _habitsProvider = Provider.of<HabitsProvider>(context, listen: true);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.background,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          title: Text(
            'Daily check in',
            style: Theme.of(context).textTheme.headline6,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 20),
            habit.isResetForToday == false
                ? Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Icon(MyEmojies.emo_coffee, size: 120),
                  )
                : habit.isAchievedForToday
                    ? Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Icon(MyEmojies.emo_thumbsup, size: 130),
                      )
                    : Icon(MyEmojies.emo_cry, size: 130),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  height: 400,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        habit.goalDays[_habitsProvider.frequencyDayIndex]
                                .frequencyDay.isDone
                            ? Container()
                            : Text(
                                'Daily Check - in',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  decorationStyle: TextDecorationStyle.wavy,
                                ),
                              ),
                        Column(
                          children: [
                            habit.isResetForToday == false
                                ? Consumer<HabitsProvider>(
                                    builder: (context, habitProvider, child) =>
                                        Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ConfirmationSlider(
                                          onConfirmation: () {
                                            setState(() {});

                                            if (habit.dayAchievementGoal
                                                .containsValue(0)) {
                                              habitProvider
                                                  .completingHabit(habit);
                                            } else {
                                              int i = 1;
                                              i = i + habit.goalPerDayValue;
                                              habitProvider
                                                  .completingGoalPerDay(
                                                habit,
                                                i,
                                              );
                                            }
                                          },
                                          shadow: BoxShadow(
                                              offset: Offset.infinite),
                                          height: 80,
                                          sliderButtonContent: SizedBox(
                                            height: 70,
                                            width: 70,
                                            child: CircleAvatar(
                                              foregroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ),
                                          backgroundColorEnd: Colors.white70,
                                          backgroundColor: Colors.white70,
                                          text: '',
                                        ),
                                        habit.dayAchievementGoal
                                                .containsValue(0)
                                            ? Container()
                                            : Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 20),
                                                child: Text(
                                                  '${habit.goalPerDayValue} /  ${habit.dayAchievementGoal.values.first.toString()}  ${habit.dayAchievementGoal.keys.first.toString()}',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              )
                                      ],
                                    ),
                                  )
                                : habit.isAchievedForToday
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 70,
                                            width: 70,
                                            child: CircleAvatar(
                                              foregroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Text(
                                            'Well Done',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        'It\'s OK there is always a tomorrow ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 35, top: 50),
                            //   child: IconButton(
                            //     onPressed: () {
                            //       showModalBottomSheet(
                            //         // constraints: BoxConstraints(
                            //         //   maxWidth: 400,
                            //         //   maxHeight: 700,
                            //         // ),
                            //         elevation: 0,
                            //         backgroundColor: Colors.transparent,
                            //         isScrollControlled: true,
                            //         enableDrag: false,
                            //         context: context,
                            //         builder: (context) => HabitDashBoard(
                            //           habit: habit,
                            //         ),
                            //       );
                            //     },
                            //     icon: Icon(
                            //       Icons.keyboard_arrow_up_rounded,
                            //       color: Colors.black,
                            //       size: 70,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
