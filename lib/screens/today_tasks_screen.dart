import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/add_new_list_provider.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/widgets/completed_tasks_expansion_panel.dart';
import 'package:todo/widgets/for_today_tomorrow_expansion_panel.dart';
import 'package:todo/widgets/todo_floating_buttton.dart';
import 'package:todo/widgets/uncompleted_tasks_expansion_panel.dart';
import 'package:todo/widgets/user_List_tasks_expansion_panel.dart';

class ToadyTasksScreen extends StatefulWidget {
  @override
  State<ToadyTasksScreen> createState() => _ToadyTasksScreenState();
}

class _ToadyTasksScreenState extends State<ToadyTasksScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isFirstTime = true;

  @override
  Widget build(BuildContext context) {
    final _tasksProvider = Provider.of<TasksProvider>(context);
    Provider.of<AddNewListProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: TasksProvider.isFirstTime &&
              Provider.of<AddNewListProvider>(context, listen: false)
                  .getUserLists
                  .values
                  .where((element) => element.listType == ListType.Task)
                  .toList()
                  .isEmpty
          ? Column(
              children: [
                SizedBox(height: 70),
                Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'lib/assets/images/time_management.png',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'A fresh start',
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(height: 10),
                Text(
                  'Anything to add ?',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  ForTodayTomorrowExpansionPanel(
                    startExpantionOpened: false,
                    expansionPanelTitle: 'Inbox',
                    userTasksList: _tasksProvider.getTodayTasks,
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
                  Divider(
                      color: Colors.transparent, thickness: 0, height: 15),
                  _tasksProvider.getTodayUncompletedTasks.isEmpty
                      ? Container()
                      : UnCompletedExpansionPanel(
                          uncompletedTasksList:
                              _tasksProvider.getTodayUncompletedTasks,
                        ),
                  Column(
                    children: [
                      UserListExpansionPanel(),
                      Divider(
                        color: Colors.transparent,
                        thickness: 0,
                        height: 20,
                      ),
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
