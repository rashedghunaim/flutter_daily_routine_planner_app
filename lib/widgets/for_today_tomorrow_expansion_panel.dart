import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'Today_Inbox_TaskItem.dart';

class ForTodayTomorrowExpansionPanel extends StatefulWidget {
  final String expansionPanelTitle;
  final bool startExpantionOpened;

  final List<Task> userTasksList;
  final Function completingTask;
  final Function deletingTask;
  final Function updatingTask;

  ForTodayTomorrowExpansionPanel({
    required this.startExpantionOpened,
    required this.userTasksList,
    required this.completingTask,
    required this.deletingTask,
    required this.updatingTask,
    required this.expansionPanelTitle,
  });

  @override
  State<ForTodayTomorrowExpansionPanel> createState() =>
      _ForTodayTomorrowExpansionPanelState();
}

class _ForTodayTomorrowExpansionPanelState
    extends State<ForTodayTomorrowExpansionPanel> {
  bool _isExpanded = false;

  @override
  void initState() {
    _isExpanded = widget.startExpantionOpened;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Theme.of(context).colorScheme.onError,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ListTile(
              onTap: () {
                setState(() {
                  if (widget.userTasksList.isEmpty) {
                    _isExpanded = false;
                  } else {
                    _isExpanded = !_isExpanded;
                  }
                });
              },
              title: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  widget.expansionPanelTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  width: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.userTasksList.length.toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      _isExpanded
                          ? Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white70,
                              size: 22,
                            )
                          : Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white70,
                              size: 15,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _isExpanded
              ? Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onError,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(7),
                      bottomLeft: Radius.circular(7),
                    ),
                  ),
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        itemBuilder: (context, index) {
                          return TodayInboxTaskItem(
                            textTheme: true,
                            task: widget.userTasksList[index],
                            completingTask: _tasksProvider.completingTask,
                            deletingTask: _tasksProvider.deleteTask,
                            updatingTask: _tasksProvider.updateTask,
                          );
                        },
                        itemCount: widget.userTasksList.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 15,
                          thickness: 0.9,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
