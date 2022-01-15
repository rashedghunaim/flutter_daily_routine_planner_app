import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/add_new_list_provider.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/widgets/completed_tasks_expansion_panel.dart';
import 'package:todo/widgets/for_today_tomorrow_expansion_panel.dart';
import 'package:todo/widgets/todo_floating_buttton.dart';
import 'package:todo/widgets/uncompleted_tasks_expansion_panel.dart';
import 'package:todo/widgets/user_List_tasks_expansion_panel.dart';

class TomorrowTasksScreen extends StatefulWidget {
  static String route = './tomorrowScreen';

  @override
  State<TomorrowTasksScreen> createState() => _TomorrowTasksScreenState();
}

class _TomorrowTasksScreenState extends State<TomorrowTasksScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _tasksProvider = Provider.of<TasksProvider>(context);
    Provider.of<AddNewListProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            ForTodayTomorrowExpansionPanel(
              startExpantionOpened: false,
              expansionPanelTitle: 'Inbox',
              userTasksList: _tasksProvider.getTomorrowTasks,
              completingTask: _tasksProvider.completingTask,
              updatingTask: _tasksProvider.updateTask,
              deletingTask: _tasksProvider.deleteTask,
            ),
            Divider(color: Colors.transparent, thickness: 0, height: 20),
            _tasksProvider.getCompletedTasks.isEmpty
                ? Container()
                : CompletedExpansionPanel(
                    completedTasks: _tasksProvider.getCompletedTasks,
                    undoCompletingTask: _tasksProvider.undoCompletingTask,
                  ),
            Divider(color: Colors.transparent, thickness: 0, height: 20),
            _tasksProvider.getTodayUncompletedTasks.isEmpty
                ? Container()
                : UnCompletedExpansionPanel(
                    uncompletedTasksList:
                        _tasksProvider.getTodayUncompletedTasks,
                  ),
            Divider(color: Colors.transparent, thickness: 0, height: 20),
            Column(
              children: [
                UserListExpansionPanel(),
                Divider(color: Colors.transparent, thickness: 0, height: 20),
              ],
            ),
          ],
        ),
      ),
      key: _scaffoldKey,
      floatingActionButton: TodFloatingActionButton(_scaffoldKey),
    );
  }
}
