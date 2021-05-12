import 'package:flutter_test/flutter_test.dart';
import 'package:what_when/model/TaskModel.dart';
import 'package:what_when/model/serializers.dart';
import 'package:what_when/model/task_list_model.dart';

main() {
  var taskData = {
    'id': 99,
    'parent': 98,
    'prereqs': [33, 44],
    'title': 'Find Wayne Gretzky',
  };

  test('creates a task from json', () {
    TaskModel? taskModel =
        standardSerializers.deserializeWith(TaskModel.serializer, taskData);
    expect(taskModel, isNotNull);
  });

  test('adds a task to the task list', () {
    TaskListModel taskListModel = TaskListModel();
    taskListModel.addTask(taskData);

    TaskModel? taskModel =
        standardSerializers.deserializeWith(TaskModel.serializer, taskData);

    expect(taskListModel.getTaskList.last == taskModel, true);
  });

  test('get the id of last task', () {
    TaskListModel taskListModel = TaskListModel();
    expect(taskListModel.getLastId == 10, true);
  });
}
