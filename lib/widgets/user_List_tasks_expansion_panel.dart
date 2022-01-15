import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/add_new_list_provider.dart';
import 'Today_Inbox_TaskItem.dart';

class UserListExpansionPanel extends StatefulWidget {
  @override
  State<UserListExpansionPanel> createState() => _UserListExpansionPanelState();
}

class _UserListExpansionPanelState extends State<UserListExpansionPanel> {
  @override
  Widget build(BuildContext context) {
    final _addNewListProvider =
        Provider.of<AddNewListProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        child: ExpansionPanelList(
          elevation: 2,
          expandedHeaderPadding: EdgeInsets.symmetric(vertical: 5),
          dividerColor: Theme.of(context).colorScheme.primary,
          expansionCallback: (index, isExpanded) {
            setState(
              () {
                _addNewListProvider.getUserLists.values
                        .where((element) => element.listType == ListType.Task)
                        .toList()[index]
                        .isExpanded =
                    !_addNewListProvider.getUserLists.values
                        .where((element) => element.listType == ListType.Task)
                        .toList()[index]
                        .isExpanded;
              },
            );
          },
          children: _addNewListProvider.getUserLists.values
              .where((element) => element.listType == ListType.Task)
              .toList()
              .map<ExpansionPanel>((newList) {
            return ExpansionPanel(
                backgroundColor: Colors.grey[300],
                canTapOnHeader: true,
                isExpanded: newList.isExpanded,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    autofocus: true,
                    title: newList.listType == ListType.Task
                        ? Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: newList.listColor,
                                minRadius: 6,
                              ),
                              SizedBox(width: 15),
                              Text(
                                newList.title,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                  'NOTE',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: newList.listColor,
                                    minRadius: 6,
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    newList.title,
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                    trailing: Text(
                      newList.listofTasks.length.toString(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  );
                },
                body: ListView(
                  shrinkWrap: true,
                  children: newList.listofTasks.map((task) {
                    print(task.taskCategoryList);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: Column(
                        children: [
                          TodayInboxTaskItem(
                            textTheme: false,
                            task: task,
                            completingTask:
                                _addNewListProvider.completingListTask,
                            updatingTask: _addNewListProvider.updateListTask,
                            deletingTask: _addNewListProvider.deleteListTask,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    );
                  }).toList(),
                ));
          }).toList(),
        ),
      ),
    );
  }
}
