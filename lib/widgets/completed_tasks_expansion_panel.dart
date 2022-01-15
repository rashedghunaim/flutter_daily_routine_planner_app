import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/add_new_list_provider.dart';

import 'Today_Completed_Task_item.dart';

class CompletedExpansionPanel extends StatefulWidget {
  final List<Task> completedTasks;
  final Function undoCompletingTask;

  CompletedExpansionPanel(
      {required this.completedTasks, required this.undoCompletingTask});

  @override
  State<CompletedExpansionPanel> createState() =>
      _CompletedExpansionPanelState();
}

class _CompletedExpansionPanelState extends State<CompletedExpansionPanel> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final _addNewListProvider =
        Provider.of<AddNewListProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Theme.of(context).colorScheme.onError,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: ListTile(
              onTap: () {
                setState(() {
                  if (widget.completedTasks.isEmpty) {
                    _isExpanded = false;
                  } else {
                    _isExpanded = !_isExpanded;
                  }
                });
              },
              title: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  'Completed',
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
                      Text(widget.completedTasks.length.toString(),
                          style: Theme.of(context).textTheme.subtitle1),
                      _isExpanded
                          ? Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white,
                              size: 22,
                            )
                          : Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
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
                        itemBuilder: (context, index) => TodayCompletedTaskItem(
                          widget.completedTasks[index],
                          widget.undoCompletingTask,
                        ),
                        itemCount: widget.completedTasks.length,
                        separatorBuilder: (context, index) =>
                            Divider(height: 15),
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
