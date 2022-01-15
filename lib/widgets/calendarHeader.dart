import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'Today_Circle_Animation.dart';
class CalenderTasksHeader extends StatelessWidget {
  final int selectedPageIndex;
  final int eventsLength;

  CalenderTasksHeader(this.selectedPageIndex, this.eventsLength);

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(
      builder: (context, tasksProvider, child) => Container(
        padding: EdgeInsets.only(left: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: TodayCircleAnimation(
                  'Task',
                  tasksProvider.getCalendarTasks.length,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Container(
                child: TodayCircleAnimation(
                  'Event',
                  eventsLength,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: TodayCircleAnimation(
                  'Habit',
                  eventsLength,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
