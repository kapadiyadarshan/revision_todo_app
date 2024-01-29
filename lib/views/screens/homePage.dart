import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_rev_todo_app/controller/dateTimeController.dart';
import 'package:fb_rev_todo_app/helpers/fb_helper.dart';
import 'package:fb_rev_todo_app/models/todo_model.dart';
import 'package:fb_rev_todo_app/utils/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/color_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do List"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: StreamBuilder(
          stream: FbHelper.fbHelper.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              QuerySnapshot<Map<String, dynamic>>? snaps = snapshot.data;

              List<QueryDocumentSnapshot> data = snaps?.docs ?? [];

              List<ToDo> allToDos = data
                  .map(
                    (e) => ToDo.fromMap(data: e.data() as Map),
                  )
                  .toList();

              return ListView.builder(
                itemCount: allToDos.length,
                itemBuilder: (context, index) {
                  ToDo todo = allToDos[index];
                  return Card(
                    child: ListTile(
                      onTap: () {
                        todo.isDone = !todo.isDone;
                        FbHelper.fbHelper.taskDone(data: todo);
                      },
                      leading: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          (todo.isDone)
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: MyColor.theme1,
                        ),
                      ),
                      title: Text(
                        todo.task,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          decoration: (todo.isDone)
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${todo.date}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              decoration: (todo.isDone)
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            todo.time,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              decoration: (todo.isDone)
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                      trailing: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: MyColor.theme2,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IconButton(
                          onPressed: () {
                            FbHelper.fbHelper.deleteTask(id: todo.id);
                          },
                          icon: const Icon(Icons.delete_forever_rounded),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, MyRoutes.addTaskPage);

          Provider.of<DateTimeController>(context).dateAndTimeNull();
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Task"),
      ),
    );
  }
}
