import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/assets/icons/v_v_icons.dart';
import 'package:todo/models/new_list_model.dart';
import 'package:todo/providers/add_new_list_provider.dart';
import 'package:todo/screens/Adding_New_List_screen.dart';
import 'package:todo/screens/Tabs_Screen.dart';
import 'package:todo/screens/User_New_List_Screen.dart';
import 'package:todo/screens/userNewList_NoteType.dart';

class NewUserListItem extends StatefulWidget {
  final NewList newList;
  final int index;

  NewUserListItem(this.newList, this.index);

  @override
  State<NewUserListItem> createState() => _NewUserListItemState();
}

class _NewUserListItemState extends State<NewUserListItem> {
  bool onLongPress = false;

  @override
  Widget build(BuildContext context) {
    final _addNewListProvider =
        Provider.of<AddNewListProvider>(context, listen: true);
    return GestureDetector(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        leading: SizedBox(
          width: 50,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: widget.newList.listColor,
                ),
                height: 25,
                width: 2,
              ),
              SizedBox(width: 10),
              Icon(
                widget.newList.listType == ListType.Task
                    ? Icons.menu
                    : VV.class_icon,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        title: Text(
          widget.newList.title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        trailing: onLongPress
            ? Container(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AddingNewListScreen.routeName,
                          arguments: _addNewListProvider.getUserLists.keys
                              .toList()[widget.index],
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        _addNewListProvider.deleteUserList(
                          _addNewListProvider.getUserLists.keys
                              .toList()[widget.index],
                        );
                      },
                    ),
                  ],
                ),
              )
            : Text(
                widget.newList.listType == ListType.Task
                    ? widget.newList.listofTasks.length.toString()
                    : widget.newList.listOfNotes.length.toString(),
              ),
      ),
      onTap: () {
        if (widget.newList.listType == ListType.Task) {
          Navigator.of(context).pushReplacementNamed(
            TabsScreen.routeName,
            arguments: {
              'screen': UserNewListScreen(),
              'title':
                  _addNewListProvider.getUserLists.keys.toList()[widget.index],
            },
          );
        } else {
          Navigator.of(context).pushReplacementNamed(
            TabsScreen.routeName,
            arguments: {
              'screen': UserNewListNotesScreen(
                  _addNewListProvider.getUserLists.keys.toList()[widget.index]),
              'title':
                  _addNewListProvider.getUserLists.keys.toList()[widget.index],
            },
          );
        }
        _addNewListProvider.routeKey =
            _addNewListProvider.getUserLists.keys.toList()[widget.index];

        // Navigator.of(context).pushReplacementNamed(
        //   TabsScreen.routeName,
        //   arguments: {
        //     'screen': UserNewListScreen(),
        //     'title':
        //         _addNewListProvider.getUserLists.keys.toList()[widget.index],
        //   },
        // );
        // _addNewListProvider.routeKey =
        //     _addNewListProvider.getUserLists.keys.toList()[widget.index];
      },
      onLongPress: () {
        setState(() {
          onLongPress = true;
        });
      },
    );
  }
}
