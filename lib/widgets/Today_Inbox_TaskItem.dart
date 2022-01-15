import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/todo_button_provider.dart';
import 'package:todo/screens/Task_Details_Screen.dart';
import 'package:todo/widgets/update_Task_widget.dart';

class TodayInboxTaskItem extends StatelessWidget {
  final bool textTheme;

  final Task task;
  final Function completingTask;
  final Function deletingTask;
  final Function updatingTask;

  TodayInboxTaskItem({
    required this.textTheme,
    required this.task,
    required this.completingTask,
    required this.deletingTask,
    required this.updatingTask,
  });

  @override
  Widget build(BuildContext context) {
    final _todoButtonProvider =
        Provider.of<TodoButtonProvider>(context, listen: false);

    _todoButtonProvider.defineTaskPriority(task.priority);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(
              TaskDetailsScreen.routeName,
              arguments: task,
            )
            .then(
              (value) => task.description = value as String,
            );
      },
      child: Dismissible(
        key: ValueKey(task.taskID),
        secondaryBackground: dismissibleSecondaryBackground(context),
        background: dismissibleBackground(context),
        onDismissed: (dismissDirection) {
          if (dismissDirection == DismissDirection.endToStart) {
            deletingTask(task);
          } else if (dismissDirection == DismissDirection.startToEnd) {
            completingTask(task);
          }
        },
        confirmDismiss: (dismissDirection) async {
          if (dismissDirection == DismissDirection.endToStart) {
            final future = await showDialog(
              context: context,
              builder: (context) => Container(
                child: AlertDialog(
                  title: Text(
                    'Are you sure ?',
                  ),
                  content: Text(
                    'Do you want to remove this task ?',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text(
                        'No',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          decorationStyle: TextDecorationStyle.wavy,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          decorationStyle: TextDecorationStyle.wavy,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
            return future;
          } else {
            return true;
          }
        },
        child: Container(
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 260,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        completingTask(task);
                      },
                      icon: Icon(
                        Icons.check_box_outline_blank,
                        color: _todoButtonProvider.getPriorityColor,
                        size: 20,
                      ),
                    ),
                    Text(
                      task.title,
                      style: textTheme
                          ? Theme.of(context).textTheme.bodyText1
                          : Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
              ),
              Text(
                task.date.day == DateTime.now().day
                    ? 'Today'
                    : DateFormat.d().format(task.date),
                style: Theme.of(context).textTheme.headline1,
              ),
              UpdateTask(task: task, updatingTask: updatingTask),
            ],
          ),
        ),
      ),
    );
  }

  Container dismissibleSecondaryBackground(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        color: Color(0xFF943D2C),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Icon(
          Icons.remove_circle,
          color: Colors.white,
          size: 20,
        ),
      ),
      alignment: Alignment.centerRight,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
    );
  }

  Container dismissibleBackground(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        color: Color(0xFF228B22),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Icon(
          Icons.check,
          color: Colors.black,
          size: 20,
        ),
      ),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
    );
  }
}

Widget popMenuButton({required String title, required Color color}) {
  return PopupMenuItem(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.flag, color: Colors.red),
        SizedBox(width: 20),
        Text(
          title,
          style: TextStyle(color: color),
        )
      ],
    ),
    value: Priorities.High,
  );
}
