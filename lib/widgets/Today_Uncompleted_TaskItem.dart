import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task_model.dart';

class TodayUncompletedTaskItem extends StatelessWidget {
  final Task uncompletedTask;

  TodayUncompletedTaskItem(this.uncompletedTask);

  @override
  Widget build(BuildContext context) {
   return  Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 260,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.check_box_outline_blank,
                    size: 20,
                  ),
                ),
                Text(
                  uncompletedTask.title,
                  style:Theme.of(context).textTheme.bodyText1
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              DateFormat.MEd().format(uncompletedTask.date).toString(),
              style: TextStyle(
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
