import 'package:flutter/material.dart';

class DateTimeController extends ChangeNotifier {
  DateTime? date;
  TimeOfDay? time;

  List<String> allDates = [];
  List<String> allTimes = [];

  dateChanged({required DateTime dateTime}) {
    date = dateTime;
    notifyListeners();
  }

  timeChanged({required TimeOfDay timeOfDay}) {
    time = timeOfDay;
    notifyListeners();
  }

  dateAndTimeNull() {
    date = null;
    time = null;
    notifyListeners();
  }
}
