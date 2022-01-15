import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/habit_model.dart';
import 'package:todo/providers/habits_provider.dart';

class UpdateHabit extends StatefulWidget {
  final Habit selectedHabit;

  UpdateHabit(this.selectedHabit);

  @override
  State<UpdateHabit> createState() => _UpdateHabitState();
}

class _UpdateHabitState extends State<UpdateHabit> {
  final _formKey = GlobalKey<FormState>();
  int pickedGoal = 0;
  bool isGoalPicked = false;
  DateTime pickedStartDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final _habitProvider = Provider.of<HabitsProvider>(context);
    Habit _editedHabit = Habit(
      lastDay: DateTime.now(),
      habitCategoryID: widget.selectedHabit.habitCategoryID,
      title: widget.selectedHabit.title,
      frequency: widget.selectedHabit.frequency,
      dayAchievementGoal: widget.selectedHabit.dayAchievementGoal,
      goalDays: widget.selectedHabit.goalDays,
      habitID: widget.selectedHabit.habitID,
      startDate: widget.selectedHabit.startDate,
      achievedDays: widget.selectedHabit.achievedDays,
      unAchievedDays: widget.selectedHabit.unAchievedDays,
      isResetForToday: widget.selectedHabit.isResetForToday,
      isEditable: widget.selectedHabit.isEditable,
      quote: widget.selectedHabit.quote,
      habitLog: widget.selectedHabit.habitLog,
      isAchievedForToday: widget.selectedHabit.isAchievedForToday,
    );
    return Container(
      height: 220 + MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 15,
        left: 15,
      ),
      width: double.infinity,
      child: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  initialValue: _editedHabit.title,
                  style: TextStyle(color: Colors.white70),
                  cursorColor: Colors.blue,
                  cursorHeight: 18,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.text_fields,
                      color: Colors.white60,
                      size: 22,
                    ),
                    errorBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    focusedErrorBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'title',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.white60,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                    focusColor: Color(0xff7A1F34),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  onSaved: (value) {
                    _editedHabit = new Habit(
                      lastDay: DateTime.now(),
                      title: value as String,
                      frequency: _editedHabit.frequency,
                      dayAchievementGoal: _editedHabit.dayAchievementGoal,
                      goalDays: _editedHabit.goalDays,
                      habitID: _editedHabit.habitID,
                      habitLog: _editedHabit.habitLog,
                      isAchievedForToday: _editedHabit.isAchievedForToday,
                      quote: _editedHabit.quote,
                      habitCategoryID: _editedHabit.habitCategoryID,
                      startDate: _editedHabit.startDate,
                      achievedDays: _editedHabit.achievedDays,
                      unAchievedDays: _editedHabit.unAchievedDays,
                      isEditable: _editedHabit.isEditable,
                      isResetForToday: _editedHabit.isResetForToday,
                    );
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'pls enter Habit title';
                    } else {
                      return null;
                    }
                  },
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        List<int> _goalDays = [0, 10, 21, 30, 50, 100, 365];
                        int selectedGoal = 1;
                        return Dialog(
                          child: StatefulBuilder(
                            builder: (context, dialogSetState) {
                              List<Widget> createRadioGoalDays() {
                                List<Widget> widgets = [];
                                for (int goal in _goalDays) {
                                  widgets.add(
                                    RadioListTile(
                                      value: goal,
                                      groupValue: selectedGoal,
                                      onChanged: (int? value) {
                                        dialogSetState(() {
                                          selectedGoal = goal;
                                          pickedGoal = value!;
                                          isGoalPicked = true;
                                        });
                                      },
                                      title: Text(
                                        goal.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return widgets;
                              }

                              return Container(
                                height: 600,
                                width: 200,
                                child: Column(
                                  children: createRadioGoalDays(),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ).then((value) => setState(() {}));
                  },
                  child: SizedBox(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Goal Days '),
                        SizedBox(width: 15),
                        Text(isGoalPicked
                            ? pickedGoal.toString()
                            : _editedHabit.goalDays.length.toString()),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.parse('2022-12-30'),
                    ).then((future) {
                      setState(() {
                        isGoalPicked = true;
                        pickedStartDate = future!;
                        _editedHabit.startDate = future;
                      });
                    });
                  },
                  child: SizedBox(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('start Date'),
                        SizedBox(width: 15),
                        Text(
                          DateFormat.MEd().format(
                            isGoalPicked
                                ? pickedStartDate
                                : _editedHabit.startDate,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: IconButton(
                onPressed: () {
                  _formKey.currentState!.save();
                  _habitProvider.generateTargetedDays(_editedHabit, pickedGoal);
                  // _habitProvider.generateTargetedFrequency(_editedHabit);
                  _habitProvider.updateUserHabit(_editedHabit);
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.update,
                  color: Theme.of(context).colorScheme.background,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
