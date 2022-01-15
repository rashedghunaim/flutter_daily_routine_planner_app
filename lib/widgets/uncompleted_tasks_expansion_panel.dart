import 'package:flutter/material.dart';
import 'Today_Uncompleted_TaskItem.dart';

class UnCompletedExpansionPanel extends StatefulWidget {
  final uncompletedTasksList;

  UnCompletedExpansionPanel({required this.uncompletedTasksList});

  @override
  State<UnCompletedExpansionPanel> createState() =>
      _UnCompletedExpansionPanelState();
}

class _UnCompletedExpansionPanelState extends State<UnCompletedExpansionPanel> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
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
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
              onTap: () {
                setState(() {
                  if (widget.uncompletedTasksList.isEmpty) {
                    _isExpanded = false;
                  } else {
                    _isExpanded = !_isExpanded;
                  }
                });
              },
              title: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  'UnCompleted',
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
                        widget.uncompletedTasksList.length.toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
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
                        bottomLeft: Radius.circular(7)),
                  ),
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        itemBuilder: (context, index) =>
                            TodayUncompletedTaskItem(
                          widget.uncompletedTasksList[index],
                        ),
                        itemCount: widget.uncompletedTasksList.length,
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
