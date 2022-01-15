import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/todo_button_provider.dart';
import 'package:todo/screens/Task_Details_Screen.dart';

class IboxScreenTaskItem extends StatelessWidget {
  final Task task;
  IboxScreenTaskItem(this.task);
  @override
  Widget build(BuildContext context) {
    final _todoButtonProvider = Provider.of<TodoButtonProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          TaskDetailsScreen.routeName,
          arguments: task,
        );
      },
      child: Dismissible(
        key: ValueKey(task.taskID),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          child: Icon(
            Icons.delete,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        ),

        confirmDismiss: (dismissDirection) async {
          final future = await showDialog(
            context: context,
            builder: (context) => Container(
              child: AlertDialog(
                title: Text(
                  'Are you sure ?',
                ),
                content: Text('Do you want to remove this task ?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            ),
          );
          return future;
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        // completingTask(task);
                      },
                      icon: Icon(
                        Icons.check_box_outline_blank,
                        color: _todoButtonProvider.getPriorityColor,
                      ),
                    ),
                    Text(
                      task.title,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                  task.time.format(context).toString(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // updateTask(context, task);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
