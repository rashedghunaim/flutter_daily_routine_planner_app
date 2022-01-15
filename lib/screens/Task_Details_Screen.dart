import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/providers/todo_button_provider.dart';

class TaskDetailsScreen extends StatefulWidget {
  static const String routeName = './Task_details_screen';

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isDidChangeActive = true;

  Task _selectedTask = Task(
      taskID: '', date: DateTime.now(), time: TimeOfDay.now(), title: 'title');

  String hintText = 'Description';

  @override
  void didChangeDependencies() {
    if (isDidChangeActive) {
      _selectedTask = ModalRoute.of(context)!.settings.arguments as Task;
    }
    isDidChangeActive = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _todoButtonProvider =
        Provider.of<TodoButtonProvider>(context, listen: false);

    _todoButtonProvider.defineTaskPriority(_selectedTask.priority);
    final Color priorityColor = _todoButtonProvider.getPriorityColor;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            _formKey.currentState!.save();
            Navigator.of(context).pop(hintText);
          },
        ),
        title: Text(
          _selectedTask.taskCategoryList.isEmpty
              ? 'Inbox'
              : _selectedTask.taskCategoryList,
          style: Theme.of(context).appBarTheme.toolbarTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Container(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Consumer<TasksProvider>(
                        builder: (context, taskProvider, child) => IconButton(
                          onPressed: () {
                            _selectedTask.isCompleted
                                ? taskProvider.undoCompletingTask(_selectedTask)
                                : taskProvider.completingTask(_selectedTask);
                          },
                          icon: Icon(
                            _selectedTask.isCompleted
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: priorityColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        _selectedTask.time.format(context),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.priority_high,
                    color: priorityColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.only(left: 25),
            child: Text(
              _selectedTask.title,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.white70,
                ),
                initialValue: _selectedTask.description,
                cursorHeight: 20,
                cursorColor: Colors.deepPurple,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: 17,
                    color: Colors.grey[800],
                    decorationStyle: TextDecorationStyle.wavy,
                    leadingDistribution: TextLeadingDistribution.proportional,
                    overflow: TextOverflow.visible,
                  ),
                  border: InputBorder.none,
                ),
                onSaved: (value) {
                  hintText = value!;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
