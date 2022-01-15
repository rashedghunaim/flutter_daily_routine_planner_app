import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/habit_model.dart';
import 'package:todo/providers/habits_provider.dart';

enum HabitLogEnum { Achieved, UnAchieved }

class emojies {
  final String image;
  bool isActive;

  HabitLogEnum habitLogEnum;

  emojies(this.habitLogEnum, this.image, this.isActive);
}

class HabitLogDialog extends StatefulWidget {
  final DateTime selectedCalendarDay;
  final Habit habit;

  HabitLogDialog({required this.habit, required this.selectedCalendarDay});

  @override
  _HabitLogDialogState createState() => _HabitLogDialogState();
}

class _HabitLogDialogState extends State<HabitLogDialog> {
  List<emojies> _habitLogEmojies = [
    emojies(
      HabitLogEnum.UnAchieved,
      'lib/assets/images/angry.png',
      false,
    ),
    emojies(
      HabitLogEnum.UnAchieved,
      'lib/assets/images/sad-1.png',
      false,
    ),
    emojies(
      HabitLogEnum.UnAchieved,
      'lib/assets/images/confused.png',
      false,
    ),
    emojies(
      HabitLogEnum.UnAchieved,
      'lib/assets/images/happy.png',
      false,
    ),
    emojies(
      HabitLogEnum.UnAchieved,
      'lib/assets/images/smile.png',
      false,
    ),
  ];
  String _pickedEmojie = 'lib/assets/images/confused.png';
  bool isPickedEmojieActive = false;

  HabitLogEnum _habitLogValue = HabitLogEnum.UnAchieved;
  final _habitLogTextController = TextEditingController();
@override
  void dispose() {
    _habitLogTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final _habitsProvider = Provider.of<HabitsProvider>(context, listen: false);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: EdgeInsets.all(15),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Container(
        margin: EdgeInsets.all(10),
        height: 400,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(DateFormat.MEd().format(DateTime.now()).toString()),
            ),
            RadioListTile(
              title: Text('Achieved'),
              value: HabitLogEnum.Achieved,
              groupValue: _habitLogValue,
              onChanged: (value) {
                _habitLogEmojies[0].habitLogEnum = HabitLogEnum.UnAchieved;
                _habitLogEmojies[4].habitLogEnum = HabitLogEnum.Achieved;
                setState(() {
                  _habitLogValue = value as HabitLogEnum;
                });
              },
            ),
            RadioListTile(
              title: Text('Unachieved'),
              value: HabitLogEnum.UnAchieved,
              groupValue: _habitLogValue,
              onChanged: (value) {
                setState(() {
                  _habitLogEmojies[4].habitLogEnum = HabitLogEnum.UnAchieved;
                  _habitLogEmojies[0].habitLogEnum = HabitLogEnum.Achieved;
                  _habitLogValue = value as HabitLogEnum;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _habitLogEmojies.map((emojie) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _habitLogEmojies.forEach((element) {
                        element.isActive = false;
                      });
                      _pickedEmojie = emojie.image;
                      emojie.isActive = !emojie.isActive;
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(emojie.image),
                        colorFilter: emojie.isActive
                            ? null
                            : ColorFilter.mode(
                                Colors.white.withOpacity(0.30),
                                BlendMode.modulate,
                              ),
                        // emojie.habitLogEnum == HabitLogEnum.Achieved
                        //     ? null
                        //     : ColorFilter.mode(
                        //         Colors.white.withOpacity(0.30),
                        //         BlendMode.modulate,
                        //       ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 35),
            Container(
              child: TextFormField(
                maxLines: 2,
                cursorHeight: 13,
                controller: _habitLogTextController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'what do you have in mind ?',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade700,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Container(
                child: SizedBox(
                  width: double.infinity,
                  height: 90,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              if (_habitLogValue == HabitLogEnum.UnAchieved) {}
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              height: 40,
                              width: 60,
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     for (var day in widget.habit.goalDays) {
                          //       if (day.frequencyDay.day ==
                          //           widget.selectedCalendarDay.day) {
                          //         day.frequencyDay.dayLog.logDescription =
                          //             _habitLogTextController.text;
                          //         day.frequencyDay.dayLog.logEmojie =
                          //             _pickedEmojie;
                          //       }
                          //     }
                          //
                          //     if (_habitLogValue == HabitLogEnum.Achieved) {
                          //       if (widget.habit.dayAchievementGoal
                          //           .containsValue(0)) {
                          //         _habitsProvider
                          //             .completingFromDetailsDashBoard(
                          //           widget.habit,
                          //           widget.selectedCalendarDay,
                          //         );
                          //       } else {
                          //         int i = 1;
                          //         i = i + widget.habit.goalPerDayValue;
                          //         _habitsProvider
                          //             .completingFromDetailsDashBoardGoalPerDay(
                          //           widget.habit,
                          //           i,
                          //           widget.selectedCalendarDay,
                          //         );
                          //       }
                          //     } else {
                          //       _habitsProvider
                          //           .unCompletingFromDetailsDashBoard(
                          //         widget.habit,
                          //         widget.selectedCalendarDay,
                          //       );
                          //     }
                          //     Navigator.of(context).pop(_habitLogTextController);
                          //   },
                          //   child: SizedBox(
                          //     height: 40,
                          //     width: 60,
                          //     child: Center(
                          //       child: Text(
                          //         'Save',
                          //         style: TextStyle(
                          //             color: Theme.of(context)
                          //                 .colorScheme
                          //                 .onPrimary,
                          //             fontSize: 17,
                          //             fontWeight: FontWeight.w500),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
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
