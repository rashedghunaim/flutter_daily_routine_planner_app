import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/add_new_list_provider.dart';
import 'package:todo/providers/todo_button_provider.dart';

class UpdateTask extends StatelessWidget {
  final Task task;
  final Function updatingTask;

  UpdateTask({required this.task, required this.updatingTask});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return IconButton(
      icon: Icon(
        Icons.edit,
        size: 20,
      ),
      onPressed: () {
        final _addNewListProvider =
            Provider.of<AddNewListProvider>(context, listen: false);

        final _todoButtonProvider =
            Provider.of<TodoButtonProvider>(context, listen: false);
        _todoButtonProvider.defineTaskPriority(task.priority);
        Color priorityColor = _todoButtonProvider.getPriorityColor;
        final _formKey = GlobalKey<FormState>();
        Map<String, dynamic> _initialValues = {
          'title': task.title,
          'description': task.description,
          'taskCategoryList': task.taskCategoryList,
        };

        var _editedTask = new Task(
          taskCategoryList: task.taskCategoryList,
          taskID: task.taskID,
          description: task.description,
          isCompleted: task.isCompleted,
          priority: task.priority,
          date: task.date,
          time: task.time,
          title: task.title,
        );
        DateTime editedDate = task.date;
        TimeOfDay editedTime = task.time;
        Priorities editedPriority = task.priority;
        _todoButtonProvider.defineTaskPriorityTitle(task.priority);
        String priorityTitle = _todoButtonProvider.getPriorityTitle;
        String _selectedNewList = '';
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
          builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return Container(
                height: 220 + MediaQuery.of(context).viewInsets.bottom,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  right: 30,
                  left: 30,
                ),
                width: double.infinity,
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Text(
                                    'Title',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      decorationStyle: TextDecorationStyle.wavy,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  child: TextFormField(
                                    cursorColor: Colors.white70,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      decorationStyle: TextDecorationStyle.wavy,
                                    ),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      fillColor: Colors.transparent,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    initialValue: _initialValues['title'],
                                    onSaved: (value) {
                                      _editedTask = new Task(
                                        taskID: _editedTask.taskID,
                                        date: _editedTask.date,
                                        time: _editedTask.time,
                                        title: value as String,
                                        description: _editedTask.description,
                                        isCompleted: _editedTask.isCompleted,
                                        priority: _editedTask.priority,
                                        taskCategoryList:
                                            _editedTask.taskCategoryList,
                                      );
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'pls enter a task title';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 33),
                                  child: Text(
                                    'Date',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      decorationStyle: TextDecorationStyle.wavy,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    final future = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.parse('2021-11-10'),
                                      lastDate: DateTime.parse('2022-12-30'),
                                    );
                                    _editedTask = new Task(
                                      taskID: _editedTask.taskID,
                                      date: future as DateTime,
                                      time: _editedTask.time,
                                      title: _editedTask.title,
                                      description: _editedTask.description,
                                      isCompleted: _editedTask.isCompleted,
                                      priority: _editedTask.priority,
                                      taskCategoryList:
                                          _editedTask.taskCategoryList,
                                    );
                                    setState(() {
                                      editedDate = future;
                                    });
                                  },
                                  child: Container(
                                    width: 200,
                                    child: TextFormField(
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        decorationStyle:
                                            TextDecorationStyle.wavy,
                                      ),
                                      enabled: false,
                                      cursorColor: Colors.deepPurple,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        border: InputBorder.none,
                                        hintText: DateFormat.MMMd()
                                            .format(editedDate)
                                            .toString(),
                                        hintStyle: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          decorationStyle:
                                              TextDecorationStyle.wavy,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Text(
                                    'Time',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      decorationStyle: TextDecorationStyle.wavy,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    final future = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    _editedTask = new Task(
                                      taskID: _editedTask.taskID,
                                      date: _editedTask.date,
                                      time: future as TimeOfDay,
                                      title: _editedTask.title,
                                      isCompleted: _editedTask.isCompleted,
                                      priority: _editedTask.priority,
                                      taskCategoryList:
                                          _editedTask.taskCategoryList,
                                    );
                                    setState(() {
                                      editedTime = future;
                                    });
                                  },
                                  child: Container(
                                    width: 100,
                                    child: TextFormField(
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        decorationStyle:
                                            TextDecorationStyle.wavy,
                                      ),
                                      enabled: false,
                                      cursorColor: Colors.deepPurple,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: editedTime
                                            .format(context)
                                            .toString(),
                                        filled: true,
                                        hintStyle: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          decorationStyle:
                                              TextDecorationStyle.wavy,
                                        ),
                                        fillColor: Colors.transparent,
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Text(
                                    'Priority',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      decorationStyle: TextDecorationStyle.wavy,
                                    ),
                                  ),
                                ),
                                PopupMenuButton(
                                  onSelected: (Priorities value) {
                                    _editedTask = new Task(
                                      taskID: _editedTask.taskID,
                                      date: _editedTask.date,
                                      time: _editedTask.time,
                                      title: _editedTask.title,
                                      isCompleted: _editedTask.isCompleted,
                                      priority: value,
                                      taskCategoryList:
                                          _editedTask.taskCategoryList,
                                    );
                                    _todoButtonProvider
                                        .defineTaskPriority(value);
                                    priorityColor =
                                        _todoButtonProvider.getPriorityColor;

                                    setState(() {
                                      _todoButtonProvider
                                          .defineTaskPriorityTitle(value);
                                      priorityTitle =
                                          _todoButtonProvider.getPriorityTitle;
                                      editedPriority = value;
                                    });
                                  },
                                  child: Container(
                                    width: 100,
                                    child: TextFormField(
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        decorationStyle:
                                            TextDecorationStyle.wavy,
                                      ),
                                      enabled: false,
                                      cursorColor: Colors.deepPurple,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: priorityTitle,
                                        hintStyle: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          decorationStyle:
                                              TextDecorationStyle.wavy,
                                        ),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // icon: Icon(Icons.flag, color: priorityColor),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.flag, color: Colors.red),
                                          SizedBox(width: 20),
                                          Text(
                                            'High Priority',
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              decorationStyle:
                                                  TextDecorationStyle.wavy,
                                            ),
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
                                          Icon(Icons.flag, color: Colors.amber),
                                          SizedBox(width: 20),
                                          Text(
                                            'Medium Priority',
                                            style:
                                                TextStyle(color: Colors.black),
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
                                            Icons.flag,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(width: 20),
                                          Text(
                                            'Low Priority',
                                            style:
                                                TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                      value: Priorities.Low,
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.flag,
                                              color: Colors.grey[500]),
                                          SizedBox(width: 20),
                                          Text(
                                            'No Priority',
                                            style:
                                                TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                      value: Priorities.None,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  _addNewListProvider.getRouteKey.isNotEmpty
                                      ? _addNewListProvider.getRouteKey
                                      : '',
                                ),
                                _addNewListProvider.getRouteKey.isNotEmpty
                                    ? PopupMenuButton(
                                        onSelected: (String value) {
                                          _selectedNewList = value;
                                        },
                                        itemBuilder: (context) =>
                                            _addNewListProvider
                                                .getUserLists.keys
                                                .map((newList) {
                                          return PopupMenuItem(
                                            child: Text(
                                              newList,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            value: newList,
                                          );
                                        }).toList(),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, right: 15),
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              updatingTask(
                                _editedTask,
                              );
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Updated '),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                          child: CircleAvatar(
                            child: Icon(
                              Icons.check_circle_rounded,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
