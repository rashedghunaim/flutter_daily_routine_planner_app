import 'package:flutter/material.dart';
import 'package:todo/widgets/todo_floating_buttton.dart';

class ToDoPersonalListScreen extends StatelessWidget {
  static const String routeName = './ToDoPersonalListScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: TodFloatingActionButton(_scaffoldKey),
    );
  }
}
