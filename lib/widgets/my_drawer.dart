import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/assets/icons/my_icons_icons.dart';
import 'package:todo/assets/icons/v_v_icons.dart';
import 'package:todo/providers/add_new_list_provider.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/screens/Adding_New_List_screen.dart';
import 'package:todo/screens/Inbox_screen.dart';
import 'package:todo/screens/today_tasks_screen.dart';
import 'package:todo/screens/tomorrow_tasks_screen.dart';
import 'package:todo/widgets/user_new_list_item.dart';
import '../screens/Tabs_Screen.dart';

class MyDrawer extends StatelessWidget {
  final Map<String, dynamic> todayScreenAppBarTitle = {
    'screen': ToadyTasksScreen(),
    'title': 'Today',
  };
  final Map<String, dynamic> inboxScreenAppBarTitle = {
    'screen': InboxScreen(),
    'title': 'Inbox',
  };
  final Map<String, dynamic> tomorrowScreenAppTitle = {
    'screen': TomorrowTasksScreen(),
    'title': 'Tomorrow',
  };

  @override
  Widget build(BuildContext context) {
    final _addNewListProvider =
        Provider.of<AddNewListProvider>(context, listen: true);

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryVariant,
                                minRadius: 40,
                                maxRadius: 40,
                                child: Text(
                                  'R',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Rashed Ghunaim',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 15, top: 60, left: 10),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0),
                        ),
                      ),
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Icon(
                            MyIcons.calendar,
                            size: 20,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Today',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        trailing: Consumer<TasksProvider>(
                          builder: (context, provider, child) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              provider.getTodayTasks.length.toString(),
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                        TabsScreen.routeName,
                        arguments: todayScreenAppBarTitle,
                      );
                    },
                  ),
                  Divider(),
                  GestureDetector(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0),
                        ),
                      ),
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Icon(
                            Icons.light_mode,
                            size: 20,
                            color:
                                Theme.of(context).colorScheme.secondaryVariant,
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Tomorrow',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        trailing: Consumer<TasksProvider>(
                          builder: (context, provider, child) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              provider.getTomorrowTasks.length.toString(),
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                        TabsScreen.routeName,
                        arguments: tomorrowScreenAppTitle,
                      );
                    },
                  ),
                  Divider(),
                  GestureDetector(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0),
                        ),
                      ),
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Icon(
                            MyIcons.inbox_alt,
                            size: 20,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Inbox',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        trailing: Consumer<TasksProvider>(
                          builder: (context, provider, child) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              provider.getAllTasks.length.toString(),
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                        TabsScreen.routeName,
                        arguments: inboxScreenAppBarTitle,
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  Divider(
                    height: 0.0,
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                  Container(
                    width: double.infinity,
                    height: 420,
                    child: ListView.builder(
                      itemBuilder: (context, index) => NewUserListItem(
                        _addNewListProvider.getUserLists.values.toList()[index],
                        index,
                      ),
                      itemCount: _addNewListProvider.getUserLists.length,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: ListTile(
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AddingNewListScreen.routeName,
                    );
                  },
                  icon: Icon(
                    VV.list_add,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 30,
                  ),
                ),
                title: Text(
                  'Add new List',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
