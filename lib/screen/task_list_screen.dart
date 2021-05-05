import 'dart:collection';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:what_when/widgets/bouncing_button.dart';
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
  UnmodifiableListView<TaskModel> subTasks;
  @override
  Widget build(BuildContext context) {
    Provider.of<TaskListModel>(context, listen: false).getAllTasks();

    return Consumer<TaskListModel>(
      builder: (context, tasks, child) {
        subTasks = tasks.getSubtasksFor(
          widget.mainTask,
          // false
        );
        //
        // UnmodifiableListView<TaskModel> completedSubTasks =
        //     tasks.getSubtasksFor(widget.mainTask, true);

        TaskModel task = tasks.getTaskById(widget.mainTask);

        return Scaffold(
          persistentFooterButtons: [],
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: BouncingButton(
                  icon: Icon(
                    Icons.delete,
                    size: 30,
                    color: Colors.red[50],
                  ),
                  onPressed: () {
                    print('there are ${subTasks.length} subtasks');

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Are You Sure?"),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('You are about to delete this task.'),
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
                                print("Deleting ${task.title}...");

                                int taskToDelete = task.id;
                                // call deletion function

                                Navigator.pop(context);
                                Navigator.pop(context);

                                Provider.of<TaskListModel>(context,
                                        listen: false)
                                    .deleteTask(taskToDelete);
                                // Pop until we get back to the contact list screen
                                // Navigator.popUntil(
                                //     context, ModalRoute.withName(ContactListScreen.screenId));
                              },
                            ),
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                print("Canceled delete.");
                                Navigator.of(context).pop();
                                // Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
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
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: ReorderableListView(
                  // header: Text(task.title ?? 'Lists',
                  //     style: GoogleFonts.sanchez(
                  //         color: Colors.white,
                  //         letterSpacing: 1,
                  //         fontSize: 25,
                  //         fontWeight: FontWeight.w700)),
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      // var replacedWidget = listItems.removeAt(oldIndex);
                      // listItems.insert(newIndex, replacedWidget);
                    });
                  },
                  children: buildTaskList(
                      // completedSubTasks,
                      subTasks,
                      context,
                      widget.mainTask)),
            ),
          ),
        );
      },
    );
  }

  List<Widget> buildTaskList(
      // UnmodifiableListView<TaskModel> completedSubTasks,
      UnmodifiableListView<TaskModel> subTasks,
      BuildContext context,
      int parentid) {
    List<GestureDetector> subtasklist =
        generateSubTasksList(subTasks: subTasks, complete: false);
    // List<Slidable> completedSubtasklist =
    //     generateSubTasksList(subTasks: completedSubTasks, complete: true);

    return subtasklist +
        [
          GestureDetector(
            key: Key('addButton'),
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
                title: 'Add Task', leading: Icon(Icons.add), complete: false),
          )
        ];
    // +
    // completedSubtasklist;
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

  List<GestureDetector> generateSubTasksList(
      {UnmodifiableListView<TaskModel> subTasks, bool complete}) {
    return subTasks
        .map((e) => GestureDetector(
              key: Key(e.id.toString()),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TaskListScreen(mainTask: e.id)));
              },
              child: ListItemCard(
                  title: e.title,
                  complete: e.complete,
                  leading: Checkbox(
                    // checkColor: , // color of tick Mark
                    activeColor: Colors.blueGrey,
                    value: e.complete,
                    onChanged: (_) {
                      Provider.of<TaskListModel>(context, listen: false)
                          .toggleTaskComplete(e);
                    },
                  )),
            ))
        .toList();
  }
}
