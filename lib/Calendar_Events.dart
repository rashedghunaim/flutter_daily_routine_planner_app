import 'package:flutter/material.dart';

class Event {
  final String title;
  final TimeOfDay eventTime;

  Event({
    required this.title,
    required this.eventTime ,
  });

  String toString() => this.title.toString();
}
