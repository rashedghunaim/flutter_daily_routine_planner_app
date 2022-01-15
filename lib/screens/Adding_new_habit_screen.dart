import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/habit_model.dart';
import 'package:todo/providers/habits_provider.dart';
import 'package:todo/widgets/custom_elevated_button.dart';

import 'Tabs_Screen.dart';

class AddingNewHabitScreen extends StatefulWidget {
  static const String routeName = './AddingNewHabit_Screen';

  @override
  State<AddingNewHabitScreen> createState() => _AddingNewHabitScreenState();
}

class _AddingNewHabitScreenState extends State<AddingNewHabitScreen> {
  final _selectedDayController = FixedExtentScrollController();

  List<String> _weekDaysTitles = [
    'Sun',
    'Mon',
    'Tus',
    'Wes',
    'Thu',
    'Fri',
    'Sat',
  ];

  List<WeekDay> _weekDays = [
    // WeekDay(DateTime.sunday, 'Sun', true),
    // WeekDay(DateTime.monday, 'Mon', true),
    // WeekDay(DateTime.tuesday, 'Tus', true),
    // WeekDay(DateTime.wednesday, 'Wed', true),
    // WeekDay(DateTime.thursday, 'Thu', true),
    // WeekDay(DateTime.friday, 'Fri', true),
    // WeekDay(DateTime.saturday, 'Sat', true),
  ];

  Map<String, int> _selectedDays = {};

  List<int> _weeklyDays = [1, 2, 3, 4, 5, 6, 7];
  List<int> _intervalDays = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
  ];
  Map<String, int> _reachCertainAmount = {'achieve all': 0};
  int _currentIndex = 0;
  GoalType _goalTypeGroupValue = GoalType.AchiveItAll;
  bool isExpanded = false;
  final _dailyCountController = TextEditingController();
  String title = 'Count';
  int pickedGoal = 0;
  DateTime pickedStartDate = DateTime.now();
  bool isDidChaActive = true;
  IconData pickedIcon = Icons.more_horiz;
  String _pickedDayGoal = '';

  @override
  void dispose() {
    _selectedDayController.dispose();
    _dailyCountController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (isDidChaActive) {
      List.generate(7, (index) {
        var day = DateTime.now().add(Duration(days: index));
        _weekDays.add(WeekDay(day.day, _weekDaysTitles[index], true));
      });
    }
    super.didChangeDependencies();
  }

  final _formKey = GlobalKey<FormState>();
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final _categoryID = ModalRoute.of(context)!.settings.arguments as String;

    var _userHabit = Habit(
      lastDay: DateTime.now(),
      habitLog: '',
      isAchievedForToday: false,
      quote: '',
      title: '',
      frequency: {},
      dayAchievementGoal: {},
      goalDays: [],
      habitID: DateTime.now().toString(),
      habitCategoryID: _categoryID,
      startDate: DateTime.now(),
      achievedDays: [],
      unAchievedDays: [],
    );

    final _habitsProvider = Provider.of<HabitsProvider>(context, listen: false);
    List<Widget> _widgets = [
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _weekDays.map((weekDay) {
            return GestureDetector(
              child: CircleAvatar(
                backgroundColor: weekDay.isSelected
                    ? Theme.of(context).colorScheme.onSurface
                    : Colors.transparent,
                child: Text(
                  weekDay.title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              onTap: () {
                setState(() {
                  weekDay.isSelected = !weekDay.isSelected;
                });

                weekDay.isSelected
                    ? _selectedDays.putIfAbsent(
                        weekDay.title, () => weekDay.day)
                    : _selectedDays.remove(weekDay.title);
                print(_selectedDays.toString());
              },
            );
          }).toList(),
        ),
      ),
      Container(
        width: double.infinity,
        height: 170,
        child: Row(
          children: [
            Container(
              width: 200,
              child: ListWheelScrollView(
                controller: _selectedDayController,
                physics: FixedExtentScrollPhysics(),
                perspective: 0.009,
                useMagnifier: true,
                magnification: 1.3,
                itemExtent: 50,
                onSelectedItemChanged: (selectedIndex) {},
                children: _weeklyDays
                    .map((e) => Container(
                          width: 50,
                          color: Colors.transparent,
                          child: Center(
                            child: Text(
                              e.toString(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Align(
              child: Text(
                'Days per week ',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ],
        ),
      ),
      Center(
        child: Container(
          width: 300,
          height: 170,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Every',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Container(
                width: 200,
                child: ListWheelScrollView(
                  controller: _selectedDayController,
                  physics: FixedExtentScrollPhysics(),
                  perspective: 0.009,
                  useMagnifier: true,
                  magnification: 1.3,
                  itemExtent: 50,
                  onSelectedItemChanged: (selectedIndex) {},
                  children: _intervalDays
                      .map((e) => Container(
                            width: 50,
                            color: Colors.transparent,
                            child: Center(
                                child: Text(
                              e.toString(),
                              style: Theme.of(context).textTheme.subtitle1,
                            )),
                          ))
                      .toList(),
                ),
              ),
              Align(
                child: Text(
                  'days',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    void _changesReview() async {
      if (_formKey.currentState!.validate()) {
        final bool future = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
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
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ],
            content: Container(
              child: Text(
                'You have made changes . Do you want to save or discard them ?',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            title: Text(
              'Review changes',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                decorationStyle: TextDecorationStyle.wavy,
              ),
            ),
          ),
        );

        if (future) {
          _formKey.currentState!.save();
          _userHabit.startDate = pickedStartDate;
          _userHabit.frequency = _selectedDays;
          _habitsProvider.addNewHabit(_userHabit);
          _habitsProvider.generateTargetedDays(_userHabit, pickedGoal);
          Navigator.pushReplacementNamed(context, TabsScreen.routeName);
        } else {
          Navigator.pushReplacementNamed(context, TabsScreen.routeName);
        }
      } else {
        Navigator.of(context).pop();
      }
    }

    void reBuild() {
      setState(() {});
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => _changesReview(), icon: Icon(Icons.arrow_back)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Define your Habit'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: TextFormField(
                    autofocus: true,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.blue,
                    cursorHeight: 17,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff7A1F34),
                          width: 2,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff7A1F34),
                          width: 2,
                        ),
                      ),
                      hintText: 'title',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white60,
                        fontWeight: FontWeight.w600,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 25,
                      ),
                      focusColor: Color(0xff7A1F34),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.white54,
                          width: 0.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.white54,
                          width: 0.5,
                        ),
                      ),
                    ),
                    onSaved: (value) {
                      _userHabit = new Habit(
                        title: value as String,
                        frequency: _userHabit.frequency,
                        dayAchievementGoal: _userHabit.dayAchievementGoal,
                        goalDays: _userHabit.goalDays,
                        habitID: _userHabit.habitID,
                        habitLog: _userHabit.habitLog,
                        isAchievedForToday: _userHabit.isAchievedForToday,
                        quote: _userHabit.quote,
                        habitCategoryID: _userHabit.habitCategoryID,
                        startDate: _userHabit.startDate,
                        achievedDays: _userHabit.achievedDays,
                        unAchievedDays: _userHabit.unAchievedDays,
                        isEditable: _userHabit.isEditable,
                        isResetForToday: _userHabit.isResetForToday,
                        lastDay: DateTime.now(),
                      );
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'pls enter Habit title';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              'Icon',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(width: 15),
                            Icon(
                              pickedIcon,
                              size: 17,
                              color: Colors.white70,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      GridView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8,
                          childAspectRatio: 1 / 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 10,
                        ),
                        children:
                            Provider.of<HabitsProvider>(context, listen: false)
                                .firstExpansionIcons
                                .map(
                          (selectedIcon) {
                            return CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.onError,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    pickedIcon = selectedIcon;
                                  });
                                },
                                child: Icon(
                                  selectedIcon,
                                  size: 17,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                      SizedBox(height: 10),
                      _isExpanded
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isExpanded = true;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                      _isExpanded
                          ? Column(
                              children: [
                                GridView(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 8,
                                    childAspectRatio: 1 / 1,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 10,
                                  ),
                                  children: Provider.of<HabitsProvider>(
                                    context,
                                    listen: false,
                                  ).secondExpansionIcons.map(
                                    (selectedIcon) {
                                      return CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              pickedIcon = selectedIcon;
                                            });
                                          },
                                          child: Icon(
                                            selectedIcon,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                                SizedBox(height: 15),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isExpanded = false;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onError,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Frequency',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Divider(color: Colors.white70, height: 25),
                      SizedBox(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _currentIndex = 0;
                              });
                            },
                            child: Column(
                              children: [
                                Text('Daily'),
                                SizedBox(height: 10),
                                Container(
                                  width: 30,
                                  height: 2,
                                  color: _currentIndex == 0
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 15),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _currentIndex = 1;
                              });
                            },
                            child: Column(
                              children: [
                                Text('Weekly'),
                                SizedBox(height: 10),
                                Container(
                                  width: 30,
                                  height: 2,
                                  color: _currentIndex == 1
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 15),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _currentIndex = 2;
                              });
                            },
                            child: Column(
                              children: [
                                Text('Interval'),
                                SizedBox(height: 10),
                                Container(
                                  width: 40,
                                  height: 2,
                                  color: _currentIndex == 2
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 15),
                        ],
                      ),
                      SizedBox(height: 35),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: _widgets[_currentIndex],
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
                SizedBox(height: 35),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onError,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 25),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Colors.black,
                                child: StatefulBuilder(
                                  builder: (context, setState) {
                                    _pickedDayGoal = '';
                                    return Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 15),
                                          RadioListTile(
                                            value: GoalType.AchiveItAll,
                                            groupValue: _goalTypeGroupValue,
                                            onChanged:
                                                (GoalType? selectedValue) {
                                              if (selectedValue ==
                                                  GoalType.AchiveItAll) {
                                                _reachCertainAmount = {
                                                  'achieve all': 0
                                                };
                                                print(_reachCertainAmount);
                                                setState(
                                                  () {
                                                    isExpanded = !isExpanded;
                                                    _goalTypeGroupValue =
                                                        selectedValue!;
                                                  },
                                                );
                                              }
                                            },
                                            title: Text(
                                              'Achieve it all',
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          RadioListTile(
                                            value: GoalType.ReachCertainAmount,
                                            groupValue: _goalTypeGroupValue,
                                            onChanged:
                                                (GoalType? selectedValue) {
                                              if (selectedValue ==
                                                  GoalType.ReachCertainAmount) {
                                                _userHabit.dayAchievementGoal =
                                                    _reachCertainAmount;
                                              }
                                              setState(() {
                                                isExpanded = !isExpanded;
                                                _goalTypeGroupValue =
                                                    selectedValue!;
                                              });
                                            },
                                            title: Text(
                                              'Reach Certain amount',
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          isExpanded
                                              ? Container(
                                                  child: ListTile(
                                                    leading: Text(
                                                      'Daily',
                                                      style: TextStyle(
                                                        color: Colors.white70,
                                                      ),
                                                    ),
                                                    title: SizedBox(
                                                      height: 30,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 15),
                                                        child: TextFormField(
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                          cursorColor:
                                                              Colors.blue,
                                                          cursorHeight: 18,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            focusColor:
                                                                Colors.white70,
                                                            fillColor:
                                                                Colors.white70,
                                                            label: Text(
                                                              _dailyCountController
                                                                  .text,
                                                            ),
                                                            hintText:
                                                                1.toString(),
                                                            hintStyle:
                                                                TextStyle(
                                                              color: Colors
                                                                  .white70,
                                                            ),
                                                          ),
                                                          controller:
                                                              _dailyCountController,
                                                        ),
                                                      ),
                                                    ),
                                                    trailing: Container(
                                                      width: 130,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            title,
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white70,
                                                            ),
                                                          ),
                                                          SizedBox(width: 15),
                                                          PopupMenuButton(
                                                            color: Colors.black,
                                                            icon: Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              color: Colors
                                                                  .white70,
                                                            ),
                                                            onSelected: (dynamic
                                                                selectedAmount) {
                                                              if (selectedAmount ==
                                                                  ReachCertainAmount
                                                                      .Count) {
                                                                setState(() {
                                                                  title =
                                                                      'Count';
                                                                });
                                                              } else if (selectedAmount ==
                                                                  ReachCertainAmount
                                                                      .Minute) {
                                                                setState(() {
                                                                  title =
                                                                      'Minute';
                                                                });
                                                              } else if (selectedAmount ==
                                                                  ReachCertainAmount
                                                                      .Hour) {
                                                                setState(() {
                                                                  title =
                                                                      'Hour';
                                                                });
                                                              } else {
                                                                setState(() {
                                                                  title =
                                                                      'Kilometer';
                                                                });
                                                              }
                                                              print(
                                                                  selectedAmount);

                                                              _reachCertainAmount =
                                                                  {};
                                                              _reachCertainAmount
                                                                  .putIfAbsent(
                                                                title,
                                                                () => int.parse(
                                                                  _dailyCountController
                                                                      .text,
                                                                ),
                                                              );

                                                              print(_reachCertainAmount
                                                                  .toString());
                                                            },
                                                            itemBuilder:
                                                                (context) => <
                                                                    PopupMenuItem>[
                                                              PopupMenuItem(
                                                                  child: Text(
                                                                      'Count'),
                                                                  value:
                                                                      ReachCertainAmount
                                                                          .Count),
                                                              PopupMenuItem(
                                                                  child: Text(
                                                                      'Minute'),
                                                                  value: ReachCertainAmount
                                                                      .Minute),
                                                              PopupMenuItem(
                                                                  child: Text(
                                                                      'Hour'),
                                                                  value:
                                                                      ReachCertainAmount
                                                                          .Hour),
                                                              PopupMenuItem(
                                                                  child: Text(
                                                                      'Kilometer'),
                                                                  value: ReachCertainAmount
                                                                      .Kilometer),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ).then((value) => reBuild());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Goal',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                _reachCertainAmount.keys.contains('achieve all')
                                    ? 'Achieve it all'
                                    : '${_reachCertainAmount.values.first} ${_reachCertainAmount.keys.first} daily',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                List<int> _goalDays = [
                                  0,
                                  10,
                                  21,
                                  30,
                                  50,
                                  100,
                                  365
                                ];

                                int selectedGoal = 0;
                                return Dialog(
                                  child: StatefulBuilder(
                                    builder: (context, dialogSetState) {
                                      List<Widget> createRadioGoalDays() {
                                        List<Widget> widgets = [];
                                        for (int goal in _goalDays) {
                                          widgets.add(
                                            RadioListTile(
                                              value: goal,
                                              groupValue: selectedGoal,
                                              onChanged: (int? value) {
                                                dialogSetState(() {
                                                  selectedGoal = value!;
                                                  pickedGoal = value;
                                                });
                                              },
                                              title: Text(
                                                goal == 0
                                                    ? 'Forever'
                                                    : goal.toString(),
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        return widgets;
                                      }

                                      return Container(
                                        color: Colors.black,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: createRadioGoalDays(),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ).then((value) => reBuild());
                          },
                          child: ListTile(
                            leading: Text(
                              'Goal Days ',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            trailing: Container(
                              child: Text(pickedGoal != 0
                                  ? pickedGoal.toString()
                                  : 'Forever'),
                            ),
                          ),
                        ),
                      ),
                      pickedGoal != 0
                          ? Container(
                              margin: EdgeInsets.only(bottom: 15),
                              height: 50,
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.parse('2021-11-10'),
                                    lastDate: DateTime.parse('2022-12-30'),
                                  ).then((future) {
                                    setState(() {
                                      pickedStartDate = future!;
                                    });
                                  });
                                },
                                child: ListTile(
                                  leading: Text(
                                    'Start Date :',
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                  trailing: Text(
                                    DateFormat()
                                        .add_yMd()
                                        .format(pickedStartDate),
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: CustomElevatedButton(
              child: Text(
                'Create Habit',
                style: Theme.of(context).appBarTheme.toolbarTextStyle,
              ),
              raduis: 10.0,
              maximumSizeWidth: 370.0,
              minimumSizeWidth: 370.0,
              maximumSizeHeight: 50.0,
              minimumSizeHeight: 50.0,
              backGroundColor: Theme.of(context).colorScheme.onPrimary,
              onTap: () {
                _formKey.currentState!.save();
                if (_formKey.currentState!.validate()) {
                  _userHabit.habitIcon = pickedIcon;
                  _userHabit.startDate = pickedStartDate;
                  _userHabit.frequency = _selectedDays;
                  _userHabit.dayAchievementGoal = _reachCertainAmount;
                  _habitsProvider.addNewHabit(_userHabit);
                  _habitsProvider.generateTargetedDays(
                    _userHabit,
                    pickedGoal,
                  );
                  _habitsProvider.generateGoalsPerDay(_userHabit);
                  Navigator.pushReplacementNamed(
                    context,
                    TabsScreen.routeName,
                  );
                }
              },
              buttonTitle: 'Create Habit',
            ),
          ),
        ],
      ),
    );
  }
}

class WeekDay {
  String title;
  int day;
  bool isSelected = true;

  WeekDay(this.day, this.title, this.isSelected);
}

enum GoalType { AchiveItAll, ReachCertainAmount }
enum ReachCertainAmount { Count, Minute, Hour, Kilometer }
