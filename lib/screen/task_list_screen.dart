import 'dart:collection';

import 'package:what_when/widgets/list_item_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:what_when/model/TaskModel.dart';
import 'package:what_when/model/task_list_model.dart';
import 'package:what_when/screen/add_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  int mainTask;

  TaskListScreen({this.mainTask});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<TaskListModel>(context, listen: false).getAllTasks();

    return Consumer<TaskListModel>(
      builder: (context, tasks, child) {
        UnmodifiableListView<TaskModel> subTasks =
            tasks.getSubtasksFor(widget.mainTask, false);
        TaskModel task = tasks.getTaskById(widget.mainTask);

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
                children: buildTaskList(subTasks, context, widget.mainTask)),
          ),
        );
      },
    );
  }

  List<GestureDetector> buildTaskList(UnmodifiableListView<TaskModel> subTasks,
      BuildContext context, int parentid) {
    List<GestureDetector> subtasklist = subTasks
        .map((e) => GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx > 0) {
                  print("Dragging in +X direction");
                  _showDeleteConfirmation(e);
                } else {
                  //if (details.delta.dx < 0) {
                  print("Dragging in -X direction");
                }
                if (details.delta.dy > 0)
                  print("Dragging in +Y direction");
                else
                  print("Dragging in -Y direction");
              },
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TaskListScreen(mainTask: e.id)));
                // });
              },
              child: ListItemCard(
                title: e.title,
              ),
            ))
        .toList();

    return subtasklist +
        [
          GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return AddTaskBottomSheet(
                    parentid: parentid,
                  );
                },
              );
            },
            child: ListItemCard(
              title: 'Add Task',
              leading: Icon(Icons.add),
            ),
          )
        ];
  }

  void _showDeleteConfirmation(TaskModel activeTask) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are You Sure You want to delete?"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You are about to delete ${activeTask.title}.'),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'You cannot undo this action.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                print("Deleting ${activeTask.title}...");

                // call deletion function
                Provider.of<TaskListModel>(context, listen: false)
                    .deleteTask(activeTask.id);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                print("Canceled delete.");
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
