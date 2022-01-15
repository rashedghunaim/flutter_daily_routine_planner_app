import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/habit_category_model.dart';
import 'package:todo/providers/habits_provider.dart';
import 'package:todo/widgets/Habit_Item.dart';

import 'Edit_User_Category.dart';

class UserCategoryItem extends StatefulWidget {
  final HabitCategory userCategory;

  UserCategoryItem(this.userCategory);

  @override
  State<UserCategoryItem> createState() => _UserCategoryItemState();
}

class _UserCategoryItemState extends State<UserCategoryItem> {
  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    final _habitsProvider = Provider.of<HabitsProvider>(context);
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onError.withOpacity(0.40),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 0.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(
                      widget.userCategory.categoryIcon,
                      color: widget.userCategory.categoryColor,
                      size: 25,
                    ),
                  ),
                  title: Text(
                    widget.userCategory.title,
                    style: TextStyle(
                      color: widget.userCategory.categoryColor,
                    ),
                  ),
                  trailing: isEditable
                      ? SizedBox(
                          width: 110,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        EditUserCategory(widget.userCategory),
                                  );
                                },
                                icon: Icon(Icons.edit),
                              ),
                              SizedBox(width: 10),
                              deleteCategory(context, widget.userCategory),
                            ],
                          ),
                        )
                      : Container(
                          width: 20,
                        ),
                ),
              ),
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Divider(height: 10),
                    UserHabitItem(widget.userCategory.habits[index]),
                    Divider(),
                  ],
                );
              },
              shrinkWrap: true,
              itemCount: widget.userCategory.habits.length,
            ),
          ],
        ),
      ),
      onLongPress: () {
        setState(() {
          isEditable = !isEditable;
        });
      },
      onTap: () {
        setState(() {
          isEditable = false;
        });
      },
    );
  }
}

Widget deleteCategory(BuildContext context, HabitCategory userCategory) {
  return IconButton(
    onPressed: () async {
      final bool future = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Column(
            children: [
              Text(
                'Are you sure you want delete this category ?',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'care if you deleted the whole category . its all habits will be removed too ',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes'),
            ),
            SizedBox(width: 30),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            )
          ],
        ),
      );
      if (future) {
        Provider.of<HabitsProvider>(context, listen: false)
            .deleteUserCategory(userCategory);
      }
    },
    icon: Icon(
      Icons.delete,
      color: Colors.red,
    ),
  );
}
