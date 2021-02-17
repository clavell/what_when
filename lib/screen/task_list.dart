import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_when/model/TaskModel.dart';
import 'package:what_when/model/task_list_model.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskListModel>(
      builder: (context, tasks, child) {
        UnmodifiableListView<TaskModel> subtasks = tasks.getSubtasksFor(1);
        return Scaffold(
          body: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {},
                  title: Text('${subtasks[index].title}'),
                  leading: Checkbox(
                    onChanged: (newValue) {},
                    value: false,
                  ),
                ),
              );
            },
            itemCount: tasks.getSubtasksFor(3).length,
            // separatorBuilder: (context, index) {
            //   return Divider();
            // },
          ),
        );
        // return Center(
        //   child: Text("Number of tasks: ${tasks.getListLength}"),
      },
    );
  }
}
