import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/widgets/Today_Inbox_TaskItem.dart';
import 'package:todo/widgets/inbox_screen_item.dart';

class InboxScreen extends StatelessWidget {
  static const routeName = './Inbox_Screen';

  @override
  Widget build(BuildContext context) {
    final _tasksProvider = Provider.of<TasksProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: ListView.separated(
        itemBuilder: (context, index) {
          return TodayInboxTaskItem(
            textTheme: true,
            task: _tasksProvider.getAllInboxTasks[index],
            completingTask: _tasksProvider.completingTask,
            deletingTask: _tasksProvider.deleteTask,
            updatingTask: _tasksProvider.updateTask,
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: _tasksProvider.getAllInboxTasks.length,
      ),
    );
  }
}
