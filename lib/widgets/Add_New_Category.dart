import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/habit_category_model.dart';
import 'package:todo/providers/habits_provider.dart';
import 'package:todo/screens/Adding_new_habit_screen.dart';

import '../theme_date.dart';

class AddNewCategory extends StatefulWidget {
  @override
  State<AddNewCategory> createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  final _formKey = GlobalKey<FormState>();
  Color _pickedColor = Colors.grey;
  var _pickedIcon = Icons.more_horiz;
  HabitCategory _userNewCategory = HabitCategory(
    habits: [],
    title: '',
    categoryID: DateTime.now().toString(),
    categoryColor: Colors.red,
    categoryIcon: Icons.more_horiz,
    isNewCategory: false,
  );

  @override
  Widget build(BuildContext context) {
    final _habitsProvider = Provider.of<HabitsProvider>(context, listen: false);
    return Container(
      height: 110 + MediaQuery.of(context).viewInsets.bottom,
      width: double.infinity,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: TextFormField(
                autofocus: true,
                showCursor: true,
                style: Theme.of(context).textTheme.bodyText1,
                keyboardAppearance: Brightness.dark,
                cursorHeight: 17,
                cursorColor: Colors.green,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.list,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'category title',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade700,
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                  ),
                ),
                onSaved: (value) {
                  _userNewCategory = HabitCategory(
                    habits: _userNewCategory.habits,
                    title: value as String,
                    categoryID: _userNewCategory.categoryID,
                    categoryIcon: _userNewCategory.categoryIcon,
                    categoryColor: _userNewCategory.categoryColor,
                  );
                },
                validator: (value) {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                insetPadding: EdgeInsets.all(15),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                child: Container(
                                  height: 300,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: Column(
                                    children: [
                                      GridView(
                                        padding: EdgeInsets.all(30),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5,
                                          childAspectRatio: 3 / 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                        ),
                                        children: randomColors.map(
                                          (selectedColor) {
                                            return CircleAvatar(
                                              backgroundColor: selectedColor,
                                              child: GestureDetector(
                                                onTap: () {
                                                  _userNewCategory =
                                                      new HabitCategory(
                                                    habits:
                                                        _userNewCategory.habits,
                                                    title:
                                                        _userNewCategory.title,
                                                    categoryID: _userNewCategory
                                                        .categoryID,
                                                    categoryIcon:
                                                        _userNewCategory
                                                            .categoryIcon,
                                                    categoryColor:
                                                        selectedColor as Color,
                                                  );
                                                  setState(() {
                                                    _pickedColor =
                                                        selectedColor;
                                                  });
                                                  Navigator.pop(context);
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
                          },
                          child: Icon(
                            Icons.color_lens,
                            color: _pickedColor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                insetPadding: EdgeInsets.all(15),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                child: Container(
                                  height: 300,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: Column(
                                    children: [
                                      GridView(
                                        padding: EdgeInsets.all(30),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5,
                                          childAspectRatio: 3 / 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                        ),
                                        children: randomIcons.map(
                                          (selectedIcon) {
                                            return GestureDetector(
                                              child: CircleAvatar(
                                                child: Icon(selectedIcon),
                                              ),
                                              onTap: () {
                                                _userNewCategory =
                                                    new HabitCategory(
                                                  habits:
                                                      _userNewCategory.habits,
                                                  title: _userNewCategory.title,
                                                  categoryID: _userNewCategory
                                                      .categoryID,
                                                  categoryIcon: selectedIcon,
                                                  categoryColor:
                                                      _userNewCategory
                                                          .categoryColor,
                                                );
                                                setState(() {
                                                  _pickedIcon = selectedIcon;
                                                });
                                                Navigator.pop(context);
                                              },
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Icon(
                            _pickedIcon,
                            color: _pickedColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        _habitsProvider.addNewCategory(_userNewCategory);
                        print(_userNewCategory.categoryColor.toString());

                        Navigator.pushNamed(
                          context,
                          AddingNewHabitScreen.routeName,
                          arguments: _userNewCategory.categoryID,
                        );
                      }
                    },
                    icon: Icon(
                      Icons.add_circle_rounded,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
