import 'dart:async';
import 'dart:collection';

import 'package:animations/animations.dart';
import 'package:what_when/widgets/bouncing_button.dart';
import 'package:what_when/widgets/list_item_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:what_when/model/TaskModel.dart';
import 'package:what_when/model/task_list_model.dart';
import 'package:what_when/screen/add_task_screen.dart';

import '../constants.dart';

class TaskListScreen extends StatefulWidget {
  final int? mainTask;
  final int _duration = 500;

  TaskListScreen({this.mainTask});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late UnmodifiableListView<TaskModel?> subTasks;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 3 * widget._duration),
      vsync: this,
    )..addListener(() {
        print(_controller.value);
      });
    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //get the list of tasks from the database
    Provider.of<TaskListModel>(context, listen: false).getAllTasks();

    ColorTween background = ColorTween(
      begin: Color(0xFF22292E),
      end: Colors.black,
    );

    return Consumer<TaskListModel>(
      builder: (context, tasks, child) {
        subTasks = tasks.getSubtasksFor(
          widget.mainTask,
          // false
        );
        //
        // UnmodifiableListView<TaskModel> completedSubTasks =
        //     tasks.getSubtasksFor(widget.mainTask, true);

        TaskModel task = tasks.getTaskById(widget.mainTask)!;

        return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Scaffold(
                persistentFooterButtons: [],
                backgroundColor: background
                    .evaluate(AlwaysStoppedAnimation(_controller.value)),
                appBar: AppBar(
                  backgroundColor: background
                      .evaluate(AlwaysStoppedAnimation(_controller.value)),
                  leading: task.id == 0
                      ? null
                      : IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context, false),
                        ),
                  actions: task.id == kIdForTopLevel
                      ? []
                      : [
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
                                showDeleteDialog(context, task);
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
                    data: Theme.of(context)
                        .copyWith(canvasColor: Colors.transparent),
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
            });
      },
    );
  }

  Future showDeleteDialog(BuildContext context, TaskModel task) {
    return showDialog(
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

                Navigator.pop(context);
                Navigator.pop(context, true);
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
  }

  List<Widget> buildTaskList(
      // UnmodifiableListView<TaskModel> completedSubTasks,
      UnmodifiableListView<TaskModel?> subTasks,
      BuildContext context,
      int? parentid) {
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

  List<GestureDetector> generateSubTasksList(
      {required UnmodifiableListView<TaskModel?> subTasks, bool? complete}) {
    return subTasks
        .map((e) => GestureDetector(
              key: Key(e!.id.toString()),
              onTap: () async {
                bool shouldDelete = await (Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TaskListScreen(mainTask: e.id)))
                    // as FutureOr<bool>
                    );
                print(shouldDelete);

                if (shouldDelete) {
                  await Future.delayed(Duration(milliseconds: 2000));
                  Provider.of<TaskListModel>(context, listen: false)
                      .deleteTask(e.id);
                }
              },
              child: OpenContainer(
                onClosed: (bool? shouldDelete) async {
                  if (shouldDelete != null && shouldDelete) {
                    await Future.delayed(Duration(
                        milliseconds: (1.5 * widget._duration).toInt()));
                    Provider.of<TaskListModel>(context, listen: false)
                        .deleteTask(e.id);
                  }
                },
                transitionType: ContainerTransitionType.fadeThrough,
                openShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                openBuilder: (BuildContext context, VoidCallback _) {
                  return TaskListScreen(mainTask: e.id);
                },
                transitionDuration: Duration(milliseconds: widget._duration),
                closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                middleColor: Color(0xFF22292E),
                closedColor: Color(0xFF22292E),
                openColor: Color(0xFF22292E),
                closedBuilder: (BuildContext context, void Function() action) {
                  return ListItemCard(
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
                      ));
                },
              ),
            ))
        .toList();
  }
}
