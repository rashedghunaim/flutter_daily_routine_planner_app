import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/habits_screens.dart';
import '../screens/setting_screen.dart';
import '../screens/Tasks_Calendar_Screen.dart';
import '../screens/today_tasks_screen.dart';
import '../widgets/my_drawer.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = './Tabs_Screen';

  @override
  State<TabsScreen> createState() => _TabsScreenStateState();
}

class _TabsScreenStateState extends State<TabsScreen> {
  List<Map<String, dynamic>> _bodyScreens = [
    {
      'screen': TasksCalenderScreen(),
      'title': DateFormat.MEd().format(DateTime.now())
    },
    {'screen': HabitsScreen(), 'title': 'Habits'},
    // {
    //   'screen': SettingsScreen(),
    //   'title': 'Settings',
    // },
  ];
  int _currentIndex = 0;
  bool didChange = true;

  @override
  void didChangeDependencies() {
    if (didChange) {
      Map<String, dynamic>? routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (routeArgs == null) {
        _bodyScreens
            .insert(0, {'screen': ToadyTasksScreen(), 'title': 'Today'});
      } else {
        _bodyScreens.insert(0, routeArgs);
      }
    }
    didChange = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      drawer: MyDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _currentIndex == 1
            ? Theme.of(context).colorScheme.onError
            : Theme.of(context).colorScheme.primary,
        title: Text(
          _bodyScreens[_currentIndex]['title'],
          style: _currentIndex == 1
              ? TextStyle(
                  color: Colors.white70,
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                )
              : Theme.of(context).appBarTheme.toolbarTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
            ),
          )
        ],
      ),
      body: _bodyScreens[_currentIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          print(index);
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.surface,
        iconSize: 30,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(
              Icons.check_circle,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.fact_check,
              ),
              label: ''),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.next_plan,
            ),
            label: '',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings, size: 30),
          //   label: '',
          // )
        ],
      ),
    );
  }
}
