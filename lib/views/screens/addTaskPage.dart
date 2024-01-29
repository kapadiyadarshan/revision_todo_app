import 'package:fb_rev_todo_app/helpers/fb_helper.dart';
import 'package:fb_rev_todo_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/dateTimeController.dart';
import '../../utils/color_utils.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key});

  late String id;
  late String todo;
  late String d;
  late String t;
  bool isDone = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: MyColor.theme2,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter task...";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "Input new task here",
                          prefixIcon: Icon(
                            Icons.task,
                            size: 24,
                            color: MyColor.theme1,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 2,
                              color: MyColor.theme1,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          todo = value;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.black38,
                                  width: 1.5,
                                ),
                              ),
                              child: Consumer<DateTimeController>(
                                  builder: (context, provider, _) {
                                return Column(
                                  children: [
                                    Text(
                                      (provider.date == null)
                                          ? "Pick Date"
                                          : "${provider.date!.day}-${provider.date!.month}-${provider.date!.year}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        DateTime? date = await showDatePicker(
                                          context: context,
                                          initialDate:
                                              provider.date ?? DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now().add(
                                            const Duration(days: 10),
                                          ),
                                        );

                                        if (date != null) {
                                          provider.dateChanged(dateTime: date);
                                          d = DateFormat("yMd").format(date);
                                        }
                                      },
                                      icon: const Icon(Icons.date_range),
                                      label: const Text("Select Date"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: MyColor.theme1,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              })),
                          const SizedBox(
                            width: 12,
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.black38,
                                width: 1.5,
                              ),
                            ),
                            child: Consumer<DateTimeController>(
                                builder: (context, provider, _) {
                              return Column(
                                children: [
                                  Text(
                                    (provider.time == null)
                                        ? "Pick Time"
                                        : "${(provider.time!.hour == 0) ? 12 : (provider.time!.hour > 12) ? (provider.time!.hour % 12).toString().padLeft(2, "0") : provider.time!.hour.toString().padLeft(2, "0")}:${provider.time!.minute.toString().padLeft(2, "0")}\t${(provider.time!.hour >= 12) ? "PM" : "AM"}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      TimeOfDay? time = await showTimePicker(
                                        context: context,
                                        initialTime:
                                            provider.time ?? TimeOfDay.now(),
                                      );

                                      if (time != null) {
                                        provider.timeChanged(timeOfDay: time);
                                        t = "${(provider.time!.hour == 0) ? 12 : (provider.time!.hour > 12) ? (provider.time!.hour % 12).toString().padLeft(2, "0") : provider.time!.hour.toString().padLeft(2, "0")}:${provider.time!.minute.toString().padLeft(2, "0")}\t${(time.hour >= 12) ? "PM" : "AM"}";
                                      }
                                    },
                                    icon: const Icon(Icons.timer),
                                    label: const Text("Select Time"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColor.theme1,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  bool isValidated = formKey.currentState!.validate();

                  if (isValidated) {
                    FbHelper.fbHelper.addTodo(
                      data: ToDo(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        task: todo,
                        date: d,
                        time: t,
                        isDone: isDone,
                      ),
                    );

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Task Add Successfully"),
                        backgroundColor: MyColor.theme1,
                      ),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: MyColor.theme1,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Add Task",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
