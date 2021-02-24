import 'package:flutter_test/flutter_test.dart';
import 'package:what_when/model/TaskModel.dart';
import 'package:what_when/model/serializers.dart';

main() {
  test('creates a task from json', () {
    var taskData = {
      'id': 1,
      'parent': null,
      'prereqs': null,
      'title': 'Task App',
    };
    TaskModel taskModel =
        standardSerializers.deserializeWith(TaskModel.serializer, taskData);
    expect(taskModel, isNotNull);
  });
}
