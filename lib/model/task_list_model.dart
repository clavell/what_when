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

  int get getListLength => _tasks.length;

  UnmodifiableListView<TaskModel> get getTaskList =>
      UnmodifiableListView(_tasks);

  get getLastId {
    return _tasks.isNotEmpty ? _tasks.last.id : 0;
  }

  ///getComplete is telling the function to get tasks that are complete or not
  UnmodifiableListView<TaskModel> getSubtasksFor(
    int id,
    // bool getComplete
  ) {
    List<TaskModel> subtasks = [];

    // bool tasksToChoose;

    for (TaskModel task in _tasks) {
      if (task.parent == id
          // && task.complete == getComplete
          ) {
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
          'complete': false,
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

  Future<void> deleteTask(int id) async {
    // Delete this task from the db
    await _taskStore.record(id).delete(await _db);

    // Refresh tasks list for UI
    await getAllTasks();

    return;
  }

  Future<List<TaskModel>> getAllTasks() async {
    final taskSnapshots = await _taskStore.find(await _db);

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

  Future<void> toggleTaskComplete(TaskModel task) async {
    task = task.rebuild((b) => b..complete = !b.complete);
    Map<String, dynamic> taskData =
        standardSerializers.serializeWith(TaskModel.serializer, task);

    await _taskStore.record(task.id).put(await _db, taskData);
    await getAllTasks();

    getAllTasks();
  }
}
