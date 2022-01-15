import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/habit_model.dart';
import 'package:todo/providers/habits_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/screens/habit_details_DashBoard_screen.dart';
import 'package:todo/widgets/update_habit_widget.dart';

class UserHabitItem extends StatefulWidget {
  final Habit habit;

  UserHabitItem(this.habit);

  @override
  State<UserHabitItem> createState() => _UserHabitItemState();
}

class _UserHabitItemState extends State<UserHabitItem> {
  bool isAchieved = false;

  @override
  Widget build(BuildContext context) {
    widget.habit.goalDays.map((e) => print(e.toString())).toList();
    final _habitsProvider = Provider.of<HabitsProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          HabitDetailsDashBoard.routeName,
          arguments: widget.habit,
        );
      },
      child: Slidable(
        dragStartBehavior: DragStartBehavior.start,
        key: ValueKey(widget.habit.habitID),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: <Widget>[
            widget.habit.isResetForToday
                ? InkWell(
                    child: _backGroundWidget(
                      context: context,
                      icon: Icons.redo,
                      backGroundColor: Theme.of(context).colorScheme.primary,
                      iconColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onTap: () {
                      _habitsProvider.reSetHabit(widget.habit);
                    },
                  )
                : Row(
                    children: [
                      InkWell(
                        child: _backGroundWidget(
                          context: context,
                          icon: Icons.check,
                          backGroundColor:
                              Theme.of(context).colorScheme.primary,
                          iconColor: Colors.lightGreen,
                        ),
                        onTap: () {
                          if (widget.habit.dayAchievementGoal
                              .containsValue(0)) {
                            _habitsProvider.completingHabit(widget.habit);
                          } else {
                            int i = 1;
                            i = i + widget.habit.goalPerDayValue;
                            Provider.of<HabitsProvider>(context, listen: false)
                                .completingGoalPerDay(
                              widget.habit,
                              i,
                            );
                          }
                        },
                      ),
                      InkWell(
                        child: _backGroundWidget(
                          context: context,
                          iconColor: Theme.of(context).colorScheme.error,
                          backGroundColor:
                              Theme.of(context).colorScheme.primary,
                          icon: Icons.close,
                        ),
                        onTap: () {
                          _habitsProvider.unCompleteHabit(widget.habit);
                        },
                      ),
                    ],
                  )
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            InkWell(
              child: _backGroundWidget(
                context: context,
                icon: Icons.remove,
                iconColor: Colors.red,
                backGroundColor: Theme.of(context).colorScheme.primary,
              ),
              onTap: () {
                _habitsProvider.deleteUserHabit(widget.habit);
              },
            ),
            InkWell(
              child: _backGroundWidget(
                backGroundColor: Theme.of(context).colorScheme.primary,
                context: context,
                iconColor: Theme.of(context).colorScheme.background,
                icon: Icons.edit,
              ),
              onTap: () {
                showModalBottomSheet(
                  enableDrag: false,
                  backgroundColor: Theme.of(context).colorScheme.onError,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return UpdateHabit(widget.habit);
                  },
                );
              },
            ),
          ],
        ),
        child: Column(
          children: [
            ListTile(
              minVerticalPadding: 20,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
              leading: Icon(
                widget.habit.isResetForToday == false
                    ? widget.habit.habitIcon
                    : widget.habit.isAchievedForToday
                        ? Icons.check_circle_rounded
                        : Icons.cancel_rounded,
                color: widget.habit.isResetForToday == false
                    ? Colors.white70
                    : widget.habit.isAchievedForToday
                        ? Colors.lightGreen
                        : Theme.of(context).colorScheme.error,
              ),
              subtitle: widget.habit.dayAchievementGoal.containsValue(0)
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: GoalPerDayWidget(
                        dayAchievementGoal: widget.habit.dayAchievementGoal,
                        goalPerDayValue: widget.habit.goalPerDayValue,
                        habit: widget.habit,
                      ),
                    ),
              title: Text(
                widget.habit.title,
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Container(
                child: Text(
                  '${widget.habit.achievedDays.length.toString()} / ${widget.habit.goalDays.length}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _backGroundWidget({
  required BuildContext context,
  required IconData icon,
  required Color iconColor,
  required Color backGroundColor,
}) {
  return Container(
    child: CircleAvatar(
      radius: 20,
      backgroundColor: backGroundColor,
      child: Icon(
        icon,
        color: iconColor,
        size: 20,
      ),
    ),
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
  );
}

class GoalPerDayWidget extends StatelessWidget {
  final Habit habit;
  final int goalPerDayValue;
  final Map<String, int> dayAchievementGoal;

  GoalPerDayWidget({
    required this.dayAchievementGoal,
    required this.goalPerDayValue,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '${habit.isAchievedForToday ? dayAchievementGoal.values.first.toString() : goalPerDayValue} /  ${dayAchievementGoal.values.first.toString()}  ${dayAchievementGoal.keys.first.toString()}',
        style: TextStyle(
          fontSize: 11,
        ),
      ),
    );
  }
}
