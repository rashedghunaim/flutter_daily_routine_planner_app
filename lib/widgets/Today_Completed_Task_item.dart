import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/screens/Task_Details_Screen.dart';

class TodayCompletedTaskItem extends StatelessWidget {
  final Task completedTask;
  final Function undoTask;

  TodayCompletedTaskItem(this.completedTask, this.undoTask);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(TaskDetailsScreen.routeName  , arguments: completedTask);
      },
      child: Dismissible(
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(7),
            ),
            color: Colors.blueGrey,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.restart_alt,
            ),
          ),
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        ),
        key: ValueKey(completedTask.taskID),
        direction: DismissDirection.startToEnd,
        onDismissed: (dismissDirection) {
          if (dismissDirection == DismissDirection.startToEnd) {
            undoTask(completedTask);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              padding: EdgeInsets.only(left: 10),
              width: 260,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_box,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Text(
                    completedTask.title,
                    style: Theme.of(context).textTheme.overline,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                DateFormat.MEd().format(completedTask.date).toString(),
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
