import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';

import 'package:what_when/model/app_database.dart';
import 'package:what_when/model/serializers.dart';
import 'package:what_when/model/TaskModel.dart';

class TaskListModel extends ChangeNotifier {
  static const String TASK_STORE_NAME = 'tasks';
  final _taskStore = intMapStoreFactory.store(TASK_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.

  Future<Database> get _db async => await AppDatabase.instance.database;

  List<TaskModel> _tasks = [];
  // List<TaskModel> _tasks = [
  //   {
  //     'id': 1,
  //     'parent': null,
  //     'prereqs': null,
  //     'title': 'Task App',
  //   }, // TaskModel(1, 'Task App', null, null),
  //   {
  //     'id': 2,
  //     'parent': 1,
  //     'prereqs': [3],
  //     'title': 'Scheduler',
  //   }, // TaskModel(2, 'Scheduler', 1, [3]),
  //
  //   {
  //     'id': 3,
  //     'parent': 1,
  //     'prereqs': null,
  //     'title': 'Store Tasks',
  //   }, // TaskModel(3, 'Store Tasks', 1, null),
  //   {
  //     'id': 5,
  //     'parent': 1,
  //     'prereqs': [3],
  //     'title': 'Hierarchy View',
  //   }, // TaskModel(5, 'Hierarchy View', 1, [3]),
  //
  //   {
  //     'id': 4,
  //     'parent': 1,
  //     'prereqs': [3],
  //     'title': 'Create Tasks',
  //   }, // TaskModel(4, 'Create Tasks', 1, [3]),
  //
  //   {
  //     'id': 6,
  //     'parent': 3,
  //     'prereqs': null,
  //     'title': 'Create Provider',
  //   }, // TaskModel(6, 'Create Provider', 3, null),
  //
  //   {
  //     'id': 7,
  //     'parent': 6,
  //     'prereqs': null,
  //     'title': 'Research Provider',
  //   }, // TaskModel(7, 'Research Provider', 6, null),
  //
  //   {
  //     'id': 8,
  //     'parent': 3,
  //     'prereqs': null,
  //     'title': 'Store the task list',
  //   }, // TaskModel(8, 'Store the task list', 3, null),
  //
  //   {
  //     'id': 9,
  //     'parent': 3,
  //     'prereqs': null,
  //     'title': 'Create a list view',
  //   }, // TaskModel(9, 'Create a list view', 3, null),
  //
  //   {
  //     'id': 10,
  //     'parent': 3,
  //     'prereqs': null,
  //     'title': 'Write some unit tests',
  //   }, // TaskModel(10, 'Write Some Unit Tests', 3, null),
  // ]
  //     .map((e) => standardSerializers.deserializeWith(TaskModel.serializer, e))
  //     .toList();

  int get getListLength => _tasks.length;

  UnmodifiableListView<TaskModel> get getTaskList =>
      UnmodifiableListView(_tasks);

  get getLastId {
    return _tasks.isNotEmpty ? _tasks.last.id : 0;
  }

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

  addTask(Map<String, dynamic> taskData) async {
    // _tasks.add(
    //     standardSerializers.deserializeWith(TaskModel.serializer, taskData));
    await _taskStore.record(taskData["id"]).put(await _db, taskData);
    await getAllTasks();

    getAllTasks();
  }

  Future<List<TaskModel>> getAllTasks() async {
    // Finder allows for filtering / sorting
    // final finder = Finder(sortOrders: [SortOrder('name')]);

    // Get the data using our finder for sorting
    final taskSnapshots = await _taskStore.find(
      await _db,
      // finder: finder,
    );

    List<TaskModel> tasks = taskSnapshots.map((snapshot) {
      final task = standardSerializers.deserializeWith(
          TaskModel.serializer, snapshot.value);
      return task;
    }).toList();

    // Update UI
    _tasks = tasks;
    notifyListeners();

    return tasks;
  }
}
