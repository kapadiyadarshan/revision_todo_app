import 'package:flutter/material.dart';

class ToDo {
  String id;
  String task;
  String date;
  String time;
  bool isDone;

  ToDo({
    required this.id,
    required this.task,
    required this.date,
    required this.time,
    required this.isDone,
  });

  factory ToDo.fromMap({required Map data}) {
    return ToDo(
      id: data["id"],
      task: data["task"],
      date: data["date"],
      time: data["time"],
      isDone: data["isDone"],
    );
  }

  Map<String, dynamic> get toMap => {
        "id": id,
        "task": task,
        "date": date,
        "time": time,
        "isDone": isDone,
      };
}
