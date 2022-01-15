import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';

class CalendarTaskItem extends StatelessWidget {
  final Task forTheDayTask;
  CalendarTaskItem(this.forTheDayTask);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 20,
                      color: Colors.transparent,
                      width: 70,
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        forTheDayTask.time.format(context).toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Theme.of(context).colorScheme.surface,
                      width: 270,
                    ),
                    Container(
                      height: 20,
                      color: Colors.transparent,
                      width: 15,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 20,
                      color: Colors.transparent,
                      width: 50,
                      margin: EdgeInsets.only(left: 20),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      height: 50,
                      width: 270,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  forTheDayTask.title,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 20,
                      color: Colors.transparent,
                      width: 15,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
