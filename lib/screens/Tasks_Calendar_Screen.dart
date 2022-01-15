import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/Calendar_Events.dart';
import 'package:todo/providers/habits_provider.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/widgets/Events_Expantion_panel.dart';
import 'package:todo/widgets/calendar_habits_expanstion_panel.dart';
import 'package:todo/widgets/custom_elevated_button.dart';
import 'package:todo/widgets/for_today_tomorrow_expansion_panel.dart';

class TasksCalenderScreen extends StatefulWidget {
  @override
  State<TasksCalenderScreen> createState() => _TasksCalenderScreenState();
}

class _TasksCalenderScreenState extends State<TasksCalenderScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  TimeOfDay _pickedEventTime = TimeOfDay.now();
  final _eventController = TextEditingController();
  Map<DateTime, List<Event>> _selectedEvents = {};
  final _pageViewController = PageController(initialPage: 0);
  int eventsLength = 0;
  int _selectedPageIndex = 0;
  bool isDidChangeActive = true;

  List<Event> _getDayEvents(DateTime selectedDate) {
    return _selectedEvents[selectedDate] ?? [];
  }

  @override
  void initState() {
    _selectedEvents = {};
    super.initState();
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _tasksProvider = Provider.of<TasksProvider>(context, listen: true);
    final _habitsProvider = Provider.of<HabitsProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          PhysicalModel(
            color: Theme.of(context).colorScheme.onError,
            elevation: 8,
            shadowColor: Colors.transparent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Container(
              padding: EdgeInsets.only(bottom: 15, top: 30),
              child: Column(
                children: [
                  TableCalendar(
                    sixWeekMonthsEnforced: true,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    weekendDays: [DateTime.saturday, DateTime.friday],
                    pageAnimationEnabled: true,
                    pageJumpingEnabled: true,
                    headerStyle: HeaderStyle(),
                    headerVisible: false,
                    currentDay: DateTime.now(),
                    daysOfWeekVisible: true,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      decoration: BoxDecoration(),
                      weekdayStyle: TextStyle(
                        fontStyle: FontStyle.italic,

                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      weekendStyle: TextStyle(
                        color: Colors.lightGreen,
                      ),
                    ),
                    calendarStyle: CalendarStyle(),
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.parse('2021-11-10'),
                    lastDay: DateTime.parse('2022-12-30'),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    eventLoader: (date) {
                      return _getDayEvents(date);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      Provider.of<HabitsProvider>(context, listen: false)
                          .generateCalendarHabits(selectedDay);
                      Provider.of<TasksProvider>(context, listen: false)
                          .calendarTasks(selectedDay);
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    calendarFormat: _calendarFormat,
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                    onDayLongPressed: (day, d) {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => addEventDialog(),
                      );
                    },
                  ),
                  SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    width: 50,
                    height: 2,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          _tasksProvider.getCalendarTasks.isEmpty &&
                  Provider.of<HabitsProvider>(context, listen: false)
                      .getDailyCalendarHabits
                      .isEmpty &&
                  _getDayEvents(_selectedDay).isEmpty
              ? Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: 70),
                      Image(
                        fit: BoxFit.contain,
                        image: AssetImage(
                          'lib/assets/images/searching-file.png',
                        ),
                        height: 200,
                        width: 200,
                      ),
                      SizedBox(height: 30),
                      Column(
                        children: [
                          Text(
                            'Looks like you have a free day',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'it\'s all clear . just relax and recharge ',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) => ListView(
                      shrinkWrap: true,
                      children: [
                        _tasksProvider.getCalendarTasks.isNotEmpty
                            ? ForTodayTomorrowExpansionPanel(
                                startExpantionOpened: true,
                                expansionPanelTitle: 'Tasks',
                                userTasksList: _tasksProvider.getTodayTasks,
                                completingTask: _tasksProvider.completingTask,
                                updatingTask: _tasksProvider.updateTask,
                                deletingTask: _tasksProvider.deleteTask,
                              )
                            : Container(),
                        Divider(),
                        _habitsProvider.getDailyCalendarHabits.isNotEmpty
                            ? CalendarHabitsExpantionPanel(
                                userHabitList:
                                    _habitsProvider.getDailyCalendarHabits,
                                startExpantionOpened: true,
                                expansionPanelTitle: 'Habits',
                              )
                            : Container(),
                        Divider(),
                        _getDayEvents(_selectedDay).isNotEmpty
                            ? EventsExpantionPanel(
                                startExpantionOpened: true,
                                expansionPanelTitle: 'Events',
                                userEvents: _getDayEvents(_selectedDay),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget addEventDialog() {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomElevatedButton(
                  child: Text(
                    'Discard',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  raduis: 5.0,
                  maximumSizeWidth: 100.0,
                  minimumSizeWidth: 100.0,
                  maximumSizeHeight: 30.0,
                  minimumSizeHeight: 30.0,
                  backGroundColor: Theme.of(context).colorScheme.onError,
                  onTap: () => Navigator.of(context).pop(),
                  buttonTitle: 'Discard',
                ),
                SizedBox(width: 20),
                CustomElevatedButton(
                  child: Text(
                    'Save',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  raduis: 5.0,
                  maximumSizeWidth: 100.0,
                  minimumSizeWidth: 100.0,
                  maximumSizeHeight: 30.0,
                  minimumSizeHeight: 30.0,
                  backGroundColor: Theme.of(context).colorScheme.onError,
                  onTap: () {
                    try {
                      if (_eventController.text.isEmpty) {
                        Navigator.of(context).pop();
                        return;
                      } else {
                        if (_selectedEvents.containsKey(_selectedDay)) {
                          _selectedEvents[_selectedDay]!.add(
                            Event(
                              title: _eventController.text,
                              eventTime: _pickedEventTime,
                            ),
                          );
                          eventsLength = _selectedEvents[_selectedDay]!.length;
                        } else {
                          _selectedEvents[_selectedDay] = [
                            Event(
                              title: _eventController.text,
                              eventTime: _pickedEventTime,
                            ),
                          ];
                          eventsLength = _selectedEvents[_selectedDay]!.length;
                        }
                      }
                      Navigator.pop(context);
                      _eventController.clear();
                      setState(() {});
                      return;
                    } catch (error) {
                      print(error);
                    }
                  },
                  buttonTitle: 'Save',
                ),
              ],
            ),
          ],
          content: Container(
            height: 150,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Event',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 15),
                TextField(
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline2,
                  controller: _eventController,
                  decoration: InputDecoration(
                    hintText: 'title',
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 15),
                    CustomElevatedButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time_sharp,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Time',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                      raduis: 5.0,
                      maximumSizeWidth: 100.0,
                      minimumSizeWidth: 100.0,
                      maximumSizeHeight: 30.0,
                      minimumSizeHeight: 30.0,
                      backGroundColor:
                          Theme.of(context).colorScheme.secondaryVariant,
                      onTap: () async {
                        final future = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        setState(() {
                          _pickedEventTime = future!;
                        });
                      },
                      buttonTitle: 'Time',
                    ),
                    SizedBox(width: 15),
                    Text(
                      _pickedEventTime.format(context).toString(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
