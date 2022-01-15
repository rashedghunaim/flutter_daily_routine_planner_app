import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/new_list_model.dart';
import 'package:todo/providers/add_new_list_provider.dart';

import '../theme_date.dart';

class AddingNewListScreen extends StatefulWidget {
  static const routeName = './Adding_New_List_Screen';

  @override
  State<AddingNewListScreen> createState() => _AddingNewListScreenState();
}

class _AddingNewListScreenState extends State<AddingNewListScreen> {
  final _formKey = GlobalKey<FormState>();
  var _selectedListType = ListType.Task;

  var selectedColor = Colors.transparent;
  bool onSelectedColor = false;
  ListType? _listType = ListType.Task;
  Map<String, dynamic> _initialValues = {
    'title': '',
    'color': Colors.transparent,
    'ListType': ListType.Task,
  };
  bool didChangeD = true;
  dynamic routeArgs = '';
  var _userNewList = NewList(
    listID: DateTime.now().toString(),
    listofTasks: [],
    listOfNotes: [],
    title: '',
    listColor: Colors.transparent,
    listType: ListType.Task,
    listofCompletedTasks: [],
    listofUnCompletedTasks: [],
  );
  NewList _fetchedEditedList = NewList(
    listType: ListType.Task,
    listID: DateTime.now().toString(),
    listofTasks: [],
    listOfNotes: [],
    title: '',
    listColor: Colors.transparent,
    listofCompletedTasks: [],
    listofUnCompletedTasks: [],
  );

  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context)!.settings.arguments;
    if (routeArgs != null) {
      _fetchedEditedList =
          Provider.of<AddNewListProvider>(context, listen: false)
              .getUserEditedList(routeArgs)!;
      _initialValues = {
        'title': _fetchedEditedList.title,
        'color': _fetchedEditedList.listColor,
        'listType': _fetchedEditedList.listType,
      };
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _addNewListProvider =
        Provider.of<AddNewListProvider>(context, listen: false);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.primary,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: PreferredSize(
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: IconButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                elevation: 0,
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text(
                                      'Discard',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text(
                                      'Save',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                ],
                                content: Container(
                                  child: Text(
                                    'You have made changes . Do you want to save or discard them ?',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                                title: Text(
                                  'Review changes',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                            ).then((value) {
                              if (value == true) {
                                _formKey.currentState!.save();
                                if (routeArgs == null) {
                                  _addNewListProvider.addNewList(
                                    _userNewList,
                                  );
                                  Navigator.of(context).pop();
                                } else {
                                  _addNewListProvider.updateUserList(
                                    _userNewList,
                                    routeArgs,
                                  );
                                  Navigator.of(context).pop();
                                }
                              } else {
                                Navigator.of(context).pop();
                              }
                            });
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(width: 25),
                    Text(
                      routeArgs == null ? 'Add list' : 'Edit List',
                      style: Theme.of(context).appBarTheme.toolbarTextStyle,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    onPressed: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        if (routeArgs == null) {
                          _addNewListProvider.addNewList(
                            _userNewList,
                          );
                          Navigator.of(context).pop();
                        } else {
                          _addNewListProvider.updateUserList(
                            _userNewList,
                            routeArgs,
                          );
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    icon: Icon(
                      Icons.done,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(100),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: pickListName(),
                ),
                SizedBox(height: 25),
                Card(
                  color: Theme.of(context).colorScheme.onError,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    margin: EdgeInsets.all(15),
                    width: double.infinity,
                    height: 150,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final future = await colorPicker(context);
                            setState(() {
                              onSelectedColor = future;
                            });
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Color',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: onSelectedColor
                                          ? selectedColor
                                          : _initialValues['color'],
                                      minRadius: 10,
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.invert_colors,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 3),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 50,
                          color: Colors.black,
                          thickness: 0.7,
                        ),
                        GestureDetector(
                          onTap: () {
                            taskTypePicker(context).then((value) {
                              setState(() {});
                              _userNewList = NewList(
                                listType: _selectedListType,
                                listColor: _userNewList.listColor,
                                listID: _userNewList.listID,
                                listOfNotes: _userNewList.listOfNotes,
                                title: _userNewList.title,
                                listofTasks: _fetchedEditedList.listofTasks,
                                listofCompletedTasks:
                                    _fetchedEditedList.listofCompletedTasks,
                                listofUnCompletedTasks:
                                    _fetchedEditedList.listofUnCompletedTasks,
                              );
                            });
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'List Type',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      _listType == ListType.Note
                                          ? 'Note'
                                          : 'Task',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField pickListName() {
    return TextFormField(
      autofocus: true,
      style: TextStyle(color: Colors.white70),
      cursorColor: Colors.blue,
      cursorHeight: 18,
      initialValue: _initialValues['title'],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          decorationStyle: TextDecorationStyle.wavy,
        ),
        prefixIcon: Icon(
          Icons.playlist_add_check,
          color: Colors.white70,
          size: 25,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff7A1F34),
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        hintText: 'List Name ',
        hintStyle: TextStyle(
          fontSize: 18,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        focusColor: Color(0xff7A1F34),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.white70,
            width: 0.8,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.white70,
            width: 0.3,
          ),
        ),
      ),
      onSaved: (value) {
        _userNewList = NewList(
          listType: _userNewList.listType,
          listColor: _userNewList.listColor,
          listOfNotes: _userNewList.listOfNotes,
          listID: _userNewList.listID,
          title: value as String,
          listofTasks: _fetchedEditedList.listofTasks,
          listofCompletedTasks: _fetchedEditedList.listofCompletedTasks,
          listofUnCompletedTasks: _fetchedEditedList.listofUnCompletedTasks,
        );
      },
      onFieldSubmitted: (value) {},
      validator: (value) {
        if (value!.isEmpty) {
          return 'pls enter a list name ';
        } else {
          return null;
        }
      },
    );
  }

  Future<dynamic> taskTypePicker(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          insetPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'List Type',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              icon: Icon(
                                Icons.task_alt,
                                color: Colors.grey,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 10, color: Colors.grey, thickness: 0.5),
                  RadioListTile(
                    value: ListType.Task,
                    groupValue: _listType,
                    onChanged: (ListType? value) {
                      _selectedListType = value as ListType;
                      setState(() {
                        _listType = value;
                      });
                    },
                    title: Text(
                      'Task',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  SizedBox(height: 10),
                  RadioListTile(
                    value: ListType.Note,
                    groupValue: _listType,
                    onChanged: (ListType? value) {
                      _selectedListType = value as ListType;
                      setState(() {
                        _listType = value;
                      });
                    },
                    title: Text(
                      'Note',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> colorPicker(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        insetPadding: EdgeInsets.all(15),
        backgroundColor: Colors.white,
        child: Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Color pick',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          icon: Icon(
                            Icons.task_alt,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 25),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
                height: 55,
              ),
              GridView(
                padding: EdgeInsets.all(30),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: randomColors.map(
                  (color) {
                    return CircleAvatar(
                      backgroundColor: color,
                      child: GestureDetector(
                        onTap: () {
                          _userNewList = NewList(
                            listType: _userNewList.listType,
                            listColor: color as Color,
                            listID: _userNewList.listID,
                            listOfNotes: _userNewList.listOfNotes,
                            title: _userNewList.title,
                            listofTasks: _fetchedEditedList.listofTasks,
                            listofCompletedTasks:
                                _fetchedEditedList.listofCompletedTasks,
                            listofUnCompletedTasks:
                                _fetchedEditedList.listofUnCompletedTasks,
                          );
                          setState(() {
                            selectedColor = color;
                          });
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
