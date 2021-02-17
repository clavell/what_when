import 'dart:collection';

import 'package:flutter/material.dart';
import 'TaskModel.dart';

class TaskListModel extends ChangeNotifier {
  final List<TaskModel> _tasks = [
    TaskModel(1, 'Task App', null, null),
    TaskModel(2, 'Scheduler', 1, [3]),
    TaskModel(3, 'Store Tasks', 1, null),
    TaskModel(5, 'Hierarchy View', 1, [3]),
    TaskModel(4, 'Create Tasks', 1, [3]),
    TaskModel(6, 'Create Provider', 3, null),
    TaskModel(7, 'Research Provider', 6, null),
    TaskModel(8, 'Store the task list', 3, null),
    TaskModel(9, 'Create a list view', 3, null),
    TaskModel(10, 'Write Some Unit Tests', 3, null),
  ];

  int get getListLength => _tasks.length;

  UnmodifiableListView<TaskModel> get getTaskList =>
      UnmodifiableListView(_tasks);

  UnmodifiableListView<TaskModel> getSubtasksFor(int id) {
    List<TaskModel> subtasks = [];

    for (TaskModel task in _tasks) {
      if (task.parent == id) {
        subtasks.add(task);
      }
    }

    return UnmodifiableListView(subtasks);
  }
}
