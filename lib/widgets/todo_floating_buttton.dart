import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/assets/icons/my_icons_icons.dart';
import 'package:todo/models/new_list_model.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/add_new_list_provider.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/providers/todo_button_provider.dart';

class TodFloatingActionButton extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  TodFloatingActionButton(this._scaffoldKey);

  @override
  _TodFloatingActionButtonState createState() =>
      _TodFloatingActionButtonState();
}

class _TodFloatingActionButtonState extends State<TodFloatingActionButton> {
  final _formKey = GlobalKey<FormState>();
  DateTime pickedDate = DateTime.now();
  TimeOfDay pickedTime = TimeOfDay.now();
  Priorities pickedPriority = Priorities.None;
  String pickedList = '';

  Task userTask = new Task(
    title: 'rashed',
    taskID: DateTime.now().toString(),
    date: DateTime.now(),
    time: TimeOfDay.now(),
    isCompleted: false,
    priority: Priorities.None,
    taskCategoryList: '',
    description: '',
  );

  @override
  Widget build(BuildContext context) {
    final _todoButtonProvider =
        Provider.of<TodoButtonProvider>(context, listen: true);
    final _tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    final _addNewListProvider =
        Provider.of<AddNewListProvider>(context, listen: false);

    return FloatingActionButton(
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: _todoButtonProvider.isBottomSheetOpened
            ? BorderRadius.all(
                Radius.circular(30),
              )
            : BorderRadius.all(
                Radius.circular(30),
              ),
      ),
      onPressed: () {
        showModalBottomSheet(
            backgroundColor: Theme.of(context).colorScheme.onError,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            enableDrag: false,
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  bool isInputFieldTapped = false;
                  final DateTime tomorrow =
                      DateTime.now().add(Duration(days: 1));
                  return Container(
                    height: 110 + MediaQuery.of(context).viewInsets.bottom,
                    width: double.infinity,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 280,
                            child: TextFormField(
                              autofocus: true,
                              showCursor: true,
                              style: Theme.of(context).textTheme.bodyText1,
                              keyboardAppearance: Brightness.dark,
                              cursorHeight: 17,
                              cursorColor: Colors.green,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                suffix: Container(
                                  padding: EdgeInsets.only(left: 0.0),
                                  child: Text(
                                    userTask.taskCategoryList,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      decorationStyle: TextDecorationStyle.wavy,
                                    ),
                                  ),
                                ),
                                prefix: Container(
                                  width: 70,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.priority_high,
                                        color: _todoButtonProvider
                                            .getPriorityColor,
                                        size: 20,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        _todoButtonProvider.getPriorityTitle,
                                        style: TextStyle(
                                          color: _todoButtonProvider
                                              .getPriorityColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          decorationStyle:
                                              TextDecorationStyle.wavy,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'what do you like to do ?',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 13,
                                ),
                              ),
                              onSaved: (value) {
                                userTask = new Task(
                                  taskID: userTask.taskID,
                                  date: userTask.date,
                                  time: userTask.time,
                                  title: value as String,
                                  priority: userTask.priority,
                                  isCompleted: userTask.isCompleted,
                                  taskCategoryList: userTask.taskCategoryList,
                                );
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'pls enter a task title';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: _addNewListProvider.getUserLists.values
                                        .where((element) =>
                                            element.listType == ListType.Task)
                                        .toList()
                                        .isEmpty
                                    ? 230
                                    : 300,
                                margin: EdgeInsets.only(left: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        DateTime? future = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate:
                                              DateTime.parse('2021-11-10'),
                                          lastDate:
                                              DateTime.parse('2022-12-30'),
                                        );
                                        setState(() {
                                          pickedDate = future as DateTime;
                                        });

                                        userTask = new Task(
                                          taskID: userTask.taskID,
                                          date: future as DateTime,
                                          time: userTask.time,
                                          title: userTask.title,
                                          priority: userTask.priority,
                                          isCompleted: userTask.isCompleted,
                                          taskCategoryList:
                                              userTask.taskCategoryList,
                                        );
                                      },
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Icon(
                                              MyIcons.calendar_2,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              size: 20,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              pickedDate.day ==
                                                      DateTime.now().day
                                                  ? 'Today'
                                                  : pickedDate.day ==
                                                          tomorrow.day
                                                      ? 'Tomorrow'
                                                      : DateFormat.MEd()
                                                          .format(pickedDate),
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                decorationStyle:
                                                    TextDecorationStyle.wavy,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: InkWell(
                                        onTap: () async {
                                          final future = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          );
                                          userTask = new Task(
                                            taskID: userTask.taskID,
                                            date: userTask.date,
                                            time: future as TimeOfDay,
                                            title: userTask.title,
                                            isCompleted: userTask.isCompleted,
                                            priority: userTask.priority,
                                            taskCategoryList:
                                                userTask.taskCategoryList,
                                          );
                                          setState(() {
                                            pickedTime = future;
                                          });
                                        },
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.watch_later,
                                                size: 20,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                pickedTime
                                                    .format(context)
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                  decorationStyle:
                                                      TextDecorationStyle.wavy,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: PopupMenuButton(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        onSelected: (Priorities value) {
                                          _todoButtonProvider
                                              .defineTaskPriority(value);
                                          _todoButtonProvider
                                              .defineTaskPriorityTitle(value);
                                          userTask = new Task(
                                            taskID: userTask.taskID,
                                            date: userTask.date,
                                            time: userTask.time,
                                            title: userTask.title,
                                            isCompleted: userTask.isCompleted,
                                            priority: value,
                                            taskCategoryList:
                                                userTask.taskCategoryList,
                                          );
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.flag,
                                          color: Colors.grey,
                                        ),
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.priority_high,
                                                      color: Colors.red),
                                                  SizedBox(width: 20),
                                                  Text(
                                                    'High Priority',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1,
                                                  )
                                                ],
                                              ),
                                              value: Priorities.High,
                                            ),
                                            PopupMenuItem(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.priority_high,
                                                      color: Colors.amber),
                                                  SizedBox(width: 20),
                                                  Text(
                                                    'Medium Priority',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1,
                                                  )
                                                ],
                                              ),
                                              value: Priorities.Meduim,
                                            ),
                                            PopupMenuItem(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.priority_high,
                                                    color: Colors.blue,
                                                  ),
                                                  SizedBox(width: 20),
                                                  Text('Low Priority',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1)
                                                ],
                                              ),
                                              value: Priorities.Low,
                                            ),
                                            PopupMenuItem(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.priority_high,
                                                      color: Colors.grey[500]),
                                                  SizedBox(width: 20),
                                                  Text('No Priority',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1)
                                                ],
                                              ),
                                              value: Priorities.None,
                                            ),
                                          ];
                                        },
                                      ),
                                    ),
                                    _addNewListProvider.getUserLists.values
                                            .where((element) =>
                                                element.listType ==
                                                ListType.Task)
                                            .toList()
                                            .isEmpty
                                        ? Container()
                                        : Container(
                                            padding: EdgeInsets.only(right: 40),
                                            child: PopupMenuButton(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              child: Icon(
                                                Icons.playlist_add_check,
                                                color: Colors.grey,
                                                size: 30,
                                              ),
                                              onSelected: (NewList value) {
                                                userTask = new Task(
                                                  taskID: userTask.taskID,
                                                  date: userTask.date,
                                                  time: userTask.time,
                                                  title: userTask.title,
                                                  isCompleted:
                                                      userTask.isCompleted,
                                                  priority: userTask.priority,
                                                  taskCategoryList: value.title,
                                                );
                                                setState(() {
                                                  pickedList = value.title;
                                                });
                                              },
                                              itemBuilder: (context) =>
                                                  _addNewListProvider
                                                      .getUserLists.values
                                                      .where((element) =>
                                                          element.listType ==
                                                          ListType.Task)
                                                      .toList()
                                                      .map((newList) {
                                                return PopupMenuItem(
                                                  onTap: () {
                                                    setState(() {});
                                                  },
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        maxRadius: 7,
                                                        backgroundColor:
                                                            newList.listColor,
                                                      ),
                                                      SizedBox(width: 15),
                                                      Text(
                                                        newList.title,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1,
                                                      ),
                                                    ],
                                                  ),
                                                  value: newList,
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: IconButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      _tasksProvider.addNewTask(
                                        userTask,
                                        _addNewListProvider.getUserLists,
                                      );
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('Added'),
                                        duration: Duration(seconds: 3),
                                      ));
                                    }
                                  },
                                  icon: Icon(
                                    Icons.send_rounded,
                                    color: isInputFieldTapped
                                        ? Colors.white70
                                        : Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            });
      },
    );
  }
}
