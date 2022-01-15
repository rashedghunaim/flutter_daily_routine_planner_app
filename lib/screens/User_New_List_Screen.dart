import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/add_new_list_provider.dart';
import 'package:todo/widgets/Today_Inbox_TaskItem.dart';
import 'package:todo/widgets/todo_floating_buttton.dart';

class UserNewListScreen extends StatefulWidget {
  @override
  _UserNewListScreenState createState() => _UserNewListScreenState();
}

class _UserNewListScreenState extends State<UserNewListScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _addNewListProvider = Provider.of<AddNewListProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: ListView.builder(
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.onError
            ),
            child: TodayInboxTaskItem(
              textTheme: true,
              task: _addNewListProvider
                  .getUserLists[_addNewListProvider.getRouteKey]!
                  .listofTasks[index],
              completingTask: _addNewListProvider.completingListTask,
              deletingTask: _addNewListProvider.deleteListTask,
              updatingTask: _addNewListProvider.updateListTask,
            ),
          ),
          itemCount: _addNewListProvider
              .getUserLists[_addNewListProvider.getRouteKey]!
              .listofTasks
              .length,
        ),
      key: _scaffoldKey,
      floatingActionButton: TodFloatingActionButton(_scaffoldKey),
    );
  }
}
