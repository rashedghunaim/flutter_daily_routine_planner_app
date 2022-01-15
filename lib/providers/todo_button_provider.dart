import 'package:flutter/material.dart';

enum Priorities { High, Meduim, Low, None }

class TodoButtonProvider with ChangeNotifier {
  Color priorityColor = Colors.grey;
  String priorityText = 'None';

  Color get getPriorityColor {
    return priorityColor;
  }

  String get getPriorityTitle {
    return priorityText;
  }

  void defineTaskPriority(Priorities selectedPriority) {
    switch (selectedPriority) {
      case Priorities.High:
        {
          priorityColor = Colors.red;
        }
        break;

      case Priorities.Meduim:
        {
          priorityColor = Colors.amber;
        }
        break;
      case Priorities.Low:
        {
          priorityColor = Colors.blue;
        }
        break;
      case Priorities.None:
        {
          priorityColor = Colors.grey;
        }
        break;
      default:
    }
  }

  void defineTaskPriorityTitle(Priorities selectedPriority) {
    switch (selectedPriority) {
      case Priorities.High:
        {
          priorityText = 'High';
        }
        break;

      case Priorities.Meduim:
        {
          priorityText = 'Medium';
        }
        break;
      case Priorities.Low:
        {
          priorityText = 'Low';
        }
        break;
      case Priorities.None:
        {
          priorityText = 'None';
        }
        break;
      default:
    }
  }

  bool isBottomSheetOpened = false;

  void resetBottomSheet() {
    isBottomSheetOpened = false;
    notifyListeners();
  }

  void toggleBottomSheetStatus() {
    isBottomSheetOpened = !isBottomSheetOpened;
    print(isBottomSheetOpened);
    notifyListeners();
  }
}
