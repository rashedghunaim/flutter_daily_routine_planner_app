import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/habit_category_model.dart';
import 'package:todo/providers/habits_provider.dart';

import '../theme_date.dart';

class EditUserCategory extends StatefulWidget {
  final HabitCategory selectedCategory;

  EditUserCategory(this.selectedCategory );

  @override
  _EditUserCategoryState createState() => _EditUserCategoryState();
}

class _EditUserCategoryState extends State<EditUserCategory> {
  final _formKey = GlobalKey<FormState>();
  var _pickedColor = Colors.black;
  var _pickedIcon = Icons.more_horiz;
  bool isDidChaneActive = true;
  late HabitCategory selectedCategory;
  Map<String, dynamic> _initialValues = {};
  bool initialVal = true;

  @override
  void didChangeDependencies() {
    if (isDidChaneActive) {
      _initialValues = {
        'title': widget.selectedCategory.title,
        'categoryColor': widget.selectedCategory.categoryColor,
        'categoryIcon': widget.selectedCategory.categoryIcon,
      };
      isDidChaneActive = false;
    }
    selectedCategory = HabitCategory(
      habits: widget.selectedCategory.habits,
      title: widget.selectedCategory.title,
      categoryID: widget.selectedCategory.categoryID,
      categoryColor: widget.selectedCategory.categoryColor,
      categoryIcon: widget.selectedCategory.categoryIcon,
      isNewCategory: widget.selectedCategory.isNewCategory,
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Theme.of(context).colorScheme.secondaryVariant,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            TextFormField(
              initialValue: _initialValues['title'],
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.blue,
              cursorHeight: 18,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.menu,
                  color: Colors.white60,
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
                hintText: 'Category title',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white60,
                  fontWeight: FontWeight.w600,
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                focusColor: Color(0xff7A1F34),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Color(0xff7A1F34),
                    width: 2,
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
                selectedCategory = HabitCategory(
                  habits: selectedCategory.habits,
                  title: value as String,
                  categoryID: selectedCategory.categoryID,
                  categoryIcon: selectedCategory.categoryIcon,
                  categoryColor: selectedCategory.categoryColor,
                );
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'pls enter a category title';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  initialVal = false;
                });
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    insetPadding: EdgeInsets.all(15),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Theme.of(context).colorScheme.primary,
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
                                      selectedCategory = new HabitCategory(
                                        habits: selectedCategory.habits,
                                        title: selectedCategory.title,
                                        categoryID: selectedCategory.categoryID,
                                        categoryIcon:
                                        selectedCategory.categoryIcon,
                                        categoryColor: selectedColor as Color,
                                      );
                                      setState(() {
                                        _pickedColor = selectedColor;
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
              child: Container(
                height: 50,
                width: 120,
                child: Row(
                  children: [
                    Text('Picked color'),
                    SizedBox(width: 15),
                    Icon(
                      Icons.color_lens,
                      color: initialVal
                          ? _initialValues['categoryColor']
                          : _pickedColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  initialVal = false;
                });
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    insetPadding: EdgeInsets.all(15),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Theme.of(context).colorScheme.primary,
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
                                    selectedCategory = new HabitCategory(
                                      habits: selectedCategory.habits,
                                      title: selectedCategory.title,
                                      categoryID: selectedCategory.categoryID,
                                      categoryIcon: selectedIcon,
                                      categoryColor:
                                      selectedCategory.categoryColor,
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
              child: Container(
                height: 50,
                width: 120,
                child: Row(
                  children: [
                    Text('Picked Icon'),
                    SizedBox(width: 15),
                    Icon(
                      initialVal ? _initialValues['categoryIcon'] : _pickedIcon,
                      color: initialVal
                          ? _initialValues['categoryColor']
                          : _pickedColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                _formKey.currentState!.save();
                if (_formKey.currentState!.validate()) {
                  Provider.of<HabitsProvider>(context, listen: false)
                      .updateUserCategory(selectedCategory);
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Update category',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
