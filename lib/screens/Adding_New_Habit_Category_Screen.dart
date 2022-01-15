import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/habits_provider.dart';
import 'package:todo/screens/Adding_new_habit_screen.dart';
import 'package:todo/widgets/Add_New_Category.dart';
import 'package:todo/widgets/custom_elevated_button.dart';

class AddingNewHabitCategoryScreen extends StatelessWidget {
  static const String routeName = './AddingNewHabitScreen';

  @override
  Widget build(BuildContext context) {
    final _habitsProvider = Provider.of<HabitsProvider>(context);

    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 5 / 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 5,
            ),
            itemCount: _habitsProvider.getDefaultCategories.length,
            itemBuilder: (context, index) => GestureDetector(
              child: Container(
                decoration: BoxDecoration(),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _habitsProvider.getDefaultCategories[index].title,
                    ),
                    CircleAvatar(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.30),
                      radius: 20,
                      child: Icon(
                        _habitsProvider
                            .getDefaultCategories[index].categoryIcon,
                        color: _habitsProvider
                            .getDefaultCategories[index].categoryColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                _habitsProvider.addNewCategory(
                  _habitsProvider.getDefaultCategories[index],
                );
                Navigator.pushNamed(
                  context,
                  AddingNewHabitScreen.routeName,
                  arguments:
                      _habitsProvider.getDefaultCategories[index].categoryID,
                );
              },
            ),
          ),
          SizedBox(height: 120),
          CustomElevatedButton(
            child: Text(
              'Create New Category',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 17,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            raduis: 10.0,
            maximumSizeWidth: 370.0,
            minimumSizeWidth: 370.0,
            maximumSizeHeight: 50.0,
            minimumSizeHeight: 50.0,
            backGroundColor:
                Theme.of(context).colorScheme.surface.withOpacity(0.30),
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Theme.of(context).colorScheme.onError,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                elevation: 0,
                enableDrag: false,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Container(
                    width: double.infinity,
                    child: AddNewCategory(),
                  );
                },
              );
            },
            buttonTitle: 'Create New Category',
          ),
        ],
      ),
    );
  }
}
