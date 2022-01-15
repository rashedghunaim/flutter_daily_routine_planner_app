import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/habits_provider.dart';
import 'package:todo/screens/Adding_New_Habit_Category_Screen.dart';
import 'package:todo/widgets/user_Category_Item.dart';

class HabitsScreen extends StatelessWidget {
  static const String routeName = './HabitScreen';

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Provider.of<HabitsProvider>(context).getUserCategories.isNotEmpty
            ? Consumer<HabitsProvider>(
                builder: (context, habitProvider, child) => Column(
                  children: [
                    SizedBox(height: 30),
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return habitProvider
                                  .getUserCategories[index].habits.isNotEmpty
                              ? Column(
                                  children: [
                                    UserCategoryItem(
                                      habitProvider.getUserCategories[index],
                                    ),
                                    Divider(),
                                  ],
                                )
                              : Container();
                        },
                        itemCount: habitProvider.getUserCategories.length,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                margin: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                child: Column(
                  children: [
                    Image(
                      height: 350,
                      width: 350,
                      fit: BoxFit.contain,
                      image: AssetImage(
                        'lib/assets/images/start.png',
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Start Adding ',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        onPressed: () {
          Navigator.of(context).pushNamed(
            AddingNewHabitCategoryScreen.routeName,
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
