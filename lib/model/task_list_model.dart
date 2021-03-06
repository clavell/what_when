import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:what_when/model/serializers.dart';
import 'package:what_when/model/TaskModel.dart';

class TaskListModel extends ChangeNotifier {
  List<TaskModel> _tasks = [
    {
      'id': 1,
      'parent': null,
      'prereqs': null,
      'title': 'Task App',
    }, // TaskModel(1, 'Task App', null, null),
    {
      'id': 2,
      'parent': 1,
      'prereqs': [3],
      'title': 'Scheduler',
    }, // TaskModel(2, 'Scheduler', 1, [3]),

    {
      'id': 3,
      'parent': 1,
      'prereqs': null,
      'title': 'Store Tasks',
    }, // TaskModel(3, 'Store Tasks', 1, null),
    {
      'id': 5,
      'parent': 1,
      'prereqs': [3],
      'title': 'Hierarchy View',
    }, // TaskModel(5, 'Hierarchy View', 1, [3]),

    {
      'id': 4,
      'parent': 1,
      'prereqs': [3],
      'title': 'Create Tasks',
    }, // TaskModel(4, 'Create Tasks', 1, [3]),

    {
      'id': 6,
      'parent': 3,
      'prereqs': null,
      'title': 'Create Provider',
    }, // TaskModel(6, 'Create Provider', 3, null),

    {
      'id': 7,
      'parent': 6,
      'prereqs': null,
      'title': 'Research Provider',
    }, // TaskModel(7, 'Research Provider', 6, null),

    {
      'id': 8,
      'parent': 3,
      'prereqs': null,
      'title': 'Store the task list',
    }, // TaskModel(8, 'Store the task list', 3, null),

    {
      'id': 9,
      'parent': 3,
      'prereqs': null,
      'title': 'Create a list view',
    }, // TaskModel(9, 'Create a list view', 3, null),

    {
      'id': 10,
      'parent': 3,
      'prereqs': null,
      'title': 'Write some unit tests',
    }, // TaskModel(10, 'Write Some Unit Tests', 3, null),
  ]
      .map((e) => standardSerializers.deserializeWith(TaskModel.serializer, e))
      .toList();

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

  TaskModel getTaskById(int id) {
    if (id == null) {
      return [
        {
          'id': 0,
          'parent': null,
          'prereqs': null,
          'title': 'Tasks',
        }
      ]
          .map((e) =>
              standardSerializers.deserializeWith(TaskModel.serializer, e))
          .toList()
          .first;
    }

    return _tasks.firstWhere((task) => task.id == id);
  }

  addTask(Map<String, dynamic> taskData) {
    _tasks.add(
        standardSerializers.deserializeWith(TaskModel.serializer, taskData));
  }
}
