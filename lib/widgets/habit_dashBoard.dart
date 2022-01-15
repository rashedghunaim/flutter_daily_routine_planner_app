import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/models/frequencyDay_model.dart';
import 'package:todo/models/habit_day_model.dart';
import 'package:todo/models/habit_log_model.dart';
import 'package:todo/models/habit_model.dart';
import 'package:todo/providers/habits_provider.dart';

import 'habit_LOG_DIALOG.dart';

class HabitDashBoard extends StatefulWidget {
  final Habit habit;

  HabitDashBoard({required this.habit});

  @override
  State<HabitDashBoard> createState() => _HabitDashBoardState();
}

class _HabitDashBoardState extends State<HabitDashBoard> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  TimeOfDay _pickedEventTime = TimeOfDay.now();

  final _eventController = TextEditingController();
  Day selectedDay = Day(
    weekDay: DateTime.now(),
    isAchieved: false,
    frequencyDay: FrequencyDay(
      day: DateTime.now().day,
      isDone: false,
      isResetForToday: false,
      dayLog: HabitLog(
        logDescription: '',
        logEmojie: '',
      ),
    ),
    goalPerDay: [],
  );
  var _habitLogTextController = TextEditingController();

  // List<Day> _habitLogDays = [];

  @override
  // void didChangeDependencies() {
  //   selectedDay = widget.habit.goalDays.firstWhere(
  //     (element) => element.frequencyDay.day == _selectedDay.day,
  //   );
  //   if (_habitLogDays.contains(selectedDay)) {
  //   } else {
  //     _habitLogDays.add(selectedDay);
  //   }
  //
  //   super.didChangeDependencies();
  // }

  // List<Day> get generateLogdaysGroupedByMonths {
  //   List<Day> _logDaysPerMonth = [];
  //   List.generate(_habitLogDays.length, (index) {
  //     for (Day day in _habitLogDays) {
  //       if (day.weekDay.month == _focusedDay.month) {
  //         _logDaysPerMonth.add(day);
  //       }
  //     }
  //   });
  //   return _logDaysPerMonth;
  // }

  @override
  void dispose() {
    _habitLogTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _habitProvider = Provider.of<HabitsProvider>(context);
    return Container(
      height: 700,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onError,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (widget.habit.goalDays.length.toString()),
                          style: TextStyle(fontSize: 15, color: Colors.white70),
                        ),
                        Text('habit goal'),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.habit.achievedDays.length.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.white70),
                        ),
                        Text('longest streak '),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.habit.achievedDays.length.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.white70),
                        ),
                        Text('current streak'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(2),
              height: 400,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onError,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TableCalendar(
                startingDayOfWeek: StartingDayOfWeek.sunday,
                weekendDays: [DateTime.saturday, DateTime.friday],
                headerStyle: HeaderStyle(
                  headerPadding: EdgeInsets.only(bottom: 15, top: 15),
                  leftChevronIcon: Icon(
                    Icons.chevron_left_rounded,
                    color: Colors.white70,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.white70,
                  ),
                ),
                headerVisible: true,
                currentDay: DateTime.now(),
                daysOfWeekVisible: true,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: Colors.white,
                  ),
                  weekendStyle: TextStyle(
                    color: Colors.lightGreen,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: true,
                  selectedDecoration: BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage('lib/assets/images/smile.png'),
                    //   colorFilter: ColorFilter.mode(
                    //     Colors.white.withOpacity(0.30),
                    //     BlendMode.modulate,
                    //   ),
                    // ),
                    color: Theme.of(context).colorScheme.secondaryVariant,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(color: Colors.white),
                  rangeHighlightColor: Theme.of(context).colorScheme.surface,
                  withinRangeTextStyle: TextStyle(color: Colors.grey.shade700),
                  rangeEndDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  rangeStartDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  withinRangeDecoration: BoxDecoration(),
                ),
                firstDay: widget.habit.startDate,
                lastDay: widget.habit.lastDay,
                rangeEndDay: widget.habit.lastDay,
                rangeStartDay: widget.habit.startDate,
                focusedDay: DateTime.now(),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => HabitLogDialog(
                      selectedCalendarDay: selectedDay,
                      habit: widget.habit,
                    ),
                  ).then((value) {
                    // _habitLogTextController = value;
                  });
                  // _habitProvider.generateCalendarHabits(selectedDay);
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
                shouldFillViewport: true,
              ),
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onError,
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 15,
                    ),
                    child: Text(
                      'Habit Log on ${DateFormat.MMMM().format(_focusedDay)}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  // ListView.builder(
                  //   padding: EdgeInsets.symmetric(vertical: 20),
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemBuilder: (context, index) {
                  //     return Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //         vertical: 0.0,
                  //         horizontal: 15,
                  //       ),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               CircleAvatar(
                  //                 backgroundColor: Theme.of(context)
                  //                     .colorScheme
                  //                     .secondaryVariant,
                  //                 radius: 3,
                  //               ),
                  //               SizedBox(width: 7),
                  //               Text(
                  //                 '${DateFormat.MMMM().format(DateTime.now())}  ${_habitLogDays[index].frequencyDay.day}',
                  //                 style: TextStyle(
                  //                   color: Theme.of(context)
                  //                       .colorScheme
                  //                       .secondaryVariant,
                  //                   fontSize: 13,
                  //                   fontWeight: FontWeight.w300,
                  //                   fontStyle: FontStyle.italic,
                  //                   decorationStyle: TextDecorationStyle.wavy,
                  //                 ),
                  //               ),
                  //               SizedBox(width: 15),
                  //               Container(
                  //                 child: _habitLogDays[index]
                  //                         .frequencyDay
                  //                         .dayLog
                  //                         .logEmojie
                  //                         .isEmpty
                  //                     ? null
                  //                     : Image(
                  //                         width: 13,
                  //                         height: 13,
                  //                         image: AssetImage(_habitLogDays[index]
                  //                             .frequencyDay
                  //                             .dayLog
                  //                             .logEmojie),
                  //                       ),
                  //               ),
                  //             ],
                  //           ),
                  //           SizedBox(height: 5),
                  //           SizedBox(
                  //             width: 100,
                  //             child: Text(
                  //               _habitLogDays[index]
                  //                       .frequencyDay
                  //                       .dayLog
                  //                       .logDescription
                  //                       .isEmpty
                  //                   ? ''
                  //                   : _habitLogDays[index]
                  //                       .frequencyDay
                  //                       .dayLog
                  //                       .logDescription,
                  //               style: TextStyle(
                  //                 color: Colors.grey,
                  //                 fontSize: 11,
                  //                 fontWeight: FontWeight.bold,
                  //                 fontStyle: FontStyle.italic,
                  //                 decorationStyle: TextDecorationStyle.wavy,
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(height: 0.0),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  //   itemCount: _habitLogDays.length,
                  // ),
                ],
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
