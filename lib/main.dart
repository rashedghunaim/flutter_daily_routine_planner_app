import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/habits_provider.dart';
import 'package:todo/screens/Adding_New_Habit_Category_Screen.dart';
import 'package:todo/screens/Adding_new_habit_screen.dart';
import 'package:todo/screens/add_edit_new_list_note_screen.dart';
import 'package:todo/screens/habit_details_DashBoard_screen.dart';
import 'package:todo/screens/habits_screens.dart';
import 'package:todo/screens/tomorrow_tasks_screen.dart';
import 'package:todo/screens/userNewList_NoteType.dart';
import './providers/add_new_list_provider.dart';
import './providers/tasks_provider.dart';
import './providers/todo_button_provider.dart';
import 'screens/Adding_New_List_screen.dart';
import 'screens/Inbox_screen.dart';
import 'screens/Tabs_Screen.dart';
import 'screens/Task_Details_Screen.dart';
import 'screens/To_Do_Personal.dart';

void main() => runApp(AppRoot());

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TasksProvider()),
        ChangeNotifierProvider(create: (context) => TodoButtonProvider()),
        ChangeNotifierProvider(create: (context) => AddNewListProvider()),
        ChangeNotifierProvider(create: (context) => HabitsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.blue),
          colorScheme: ColorScheme(
            primary: Color(0xFF0d0d0d),
            onError: Color(0xFF161618),
            surface: Color(0xff212121),
            // surface: Color(0xFF3F3F3F),
            secondary: Color(0xff00FFFF),
            secondaryVariant: Color(0xFF3E60C1),
            // secondaryVariant: Color(0xffF88379),
            primaryVariant: Color(0xff86817C),
            background: Color(0xFF3E60C1),
            error: Color(0xff7A1F34),
            onPrimary: Color(0xFF3E60C1),
            // onPrimary: Color(0xff0096FF),
            onSecondary: Color(0xffEDEADE),
            // onSurface: Color(0xfffdf6f6),
            onSurface: Color(0xffff1f5a),
            onBackground: Color(0xFF28385e),

            brightness: Brightness.light,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF1c1c1c),
            toolbarTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              decorationStyle: TextDecorationStyle.wavy,
              debugLabel: 'hey there',
            ),
            //
            bodyText2: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            //
            headline1: TextStyle(
              color: Color(0xff0096FF),
              fontStyle: FontStyle.italic,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
            headline3: TextStyle(
              color: Colors.white70,
              fontStyle: FontStyle.italic,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            overline: TextStyle(
              color: Colors.white70,
              fontStyle: FontStyle.italic,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              decorationThickness: 2,
              leadingDistribution: TextLeadingDistribution.even,
              textBaseline: TextBaseline.ideographic,
            ),
            //
            subtitle1: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              decorationStyle: TextDecorationStyle.wavy,
            ),
            //
            subtitle2: TextStyle(
              color: Colors.grey,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              decorationStyle: TextDecorationStyle.wavy,
            ),
            headline2: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              decorationStyle: TextDecorationStyle.wavy,
            ),
            headline6: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              decorationStyle: TextDecorationStyle.wavy,
            ),
            caption: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              decorationStyle: TextDecorationStyle.wavy,
            ),
            headline5: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 25,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              decorationStyle: TextDecorationStyle.wavy,
            ),
            headline4: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              decorationStyle: TextDecorationStyle.wavy,
            ),
          ),
        ),
        initialRoute: TabsScreen.routeName,
        routes: {
          TabsScreen.routeName: (context) => TabsScreen(),
          InboxScreen.routeName: (context) => InboxScreen(),
          AddingNewListScreen.routeName: (context) => AddingNewListScreen(),
          ToDoPersonalListScreen.routeName: (context) =>
              ToDoPersonalListScreen(),
          TaskDetailsScreen.routeName: (context) => TaskDetailsScreen(),
          AddingNewHabitCategoryScreen.routeName: (context) =>
              AddingNewHabitCategoryScreen(),
          AddingNewHabitScreen.routeName: (context) => AddingNewHabitScreen(),
          HabitsScreen.routeName: (context) => HabitsScreen(),
          TomorrowTasksScreen.route: (context) => TomorrowTasksScreen(),
          HabitDetailsDashBoard.routeName: (context) => HabitDetailsDashBoard(),
          UserNewListNotesScreen.routeName: (context) =>
              UserNewListNotesScreen(''),
          AddEditNewListNoteScreen.routeName: (context) =>
              AddEditNewListNoteScreen(),
        },
      ),
    );
  }
}
