import 'dart:collection';

import 'package:what_when/widgets/list_item_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:what_when/model/TaskModel.dart';
import 'package:what_when/model/task_list_model.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  int mainTask;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskListModel>(
      builder: (context, tasks, child) {
        UnmodifiableListView<TaskModel> subTasks =
            tasks.getSubtasksFor(mainTask);
        TaskModel task = tasks.getTaskById(mainTask);

        return Scaffold(
          persistentFooterButtons: [],
          appBar: AppBar(
            centerTitle: false,
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(task.title ?? 'Lists',
                  style: GoogleFonts.sanchez(
                      letterSpacing: 1,
                      fontSize: 25,
                      fontWeight: FontWeight.w700)),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: subTasks
                  .map((e) => GestureDetector(
                        onLongPress: () {
                          setState(() {
                            mainTask = e.id;
                          });
                        },
                        child: ListItemCard(
                          task: e,
                        ),
                      ))
                  .toList(),
            ),
          ),
        );
        // return Center(
        //   child: Text("Number of tasks: ${tasks.getListLength}"),
      },
    );
  }
}
