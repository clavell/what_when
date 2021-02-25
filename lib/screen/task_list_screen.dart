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
  int mainTask = 3;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskListModel>(
      builder: (context, tasks, child) {
        UnmodifiableListView<TaskModel> subtasks =
            tasks.getSubtasksFor(mainTask);
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text('Lists',
                style: GoogleFonts.solway(
                    fontSize: 25, fontWeight: FontWeight.w900)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: subtasks
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
          // body: ListView.builder(
          //   itemBuilder: (context, index) {
          //     return Card(
          //       child: ListTile(
          //         tileColor: Color(0xFF22292E),
          //         minVerticalPadding: 30,
          //         onTap: () {},
          //         onLongPress: () {
          //           setState(() {
          //             mainTask = subtasks[index].id;
          //           });
          //         },
          //         title: Center(
          //           child: Text(
          //             '${subtasks[index].title}',
          //             style: TextStyle(
          //               fontSize: 20,
          //               color: Colors.white,
          //             ),
          //           ),
          //         ),
          //
          //         // leading: Checkbox(
          //         //   onChanged: (newValue) {},
          //         //   value: false,
          //         // ),
          //       ),
          //     );
          //   },
          //   itemCount: tasks.getSubtasksFor(mainTask).length,
          //   // separatorBuilder: (context, index) {
          //   //   return Divider();
          //   // },
          // ),
        );
        // return Center(
        //   child: Text("Number of tasks: ${tasks.getListLength}"),
      },
    );
  }
}
