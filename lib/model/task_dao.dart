import 'dart:async';

import 'package:sembast/sembast.dart';
import 'package:what_when/model/app_database.dart';
import 'package:what_when/model/serializers.dart';
import 'package:what_when/model/TaskModel.dart';

class TaskDAO {
  static const String taskStoreName = 'tasks';
  final StoreRef<int?, Map<String, Object?>> _taskStore =
      intMapStoreFactory.store(taskStoreName);

  static final TaskDAO _singleton = TaskDAO._();

  static TaskDAO get instance => _singleton;
  TaskDAO._();
  //simple name for the database
  Future<Database> get _db async => await AppDatabase.instance.database;

  //insert into database method
  Future insert(TaskModel task) async {
    await _taskStore.record(task.id).put(
        await _db,
        standardSerializers.serializeWith(TaskModel.serializer, task)
            as Map<String, Object?>);
  }

  Future getAll() async {
    return await _taskStore.find(await _db);
  }

  Future<TaskModel?> getTaskById(int id) async {
    var task = await (_taskStore.record(id).get(await _db)
        as FutureOr<Map<String, Object>?>);
    return standardSerializers.deserializeWith(TaskModel.serializer, task);
  }

  Future<void> deleteTask(int id) async {
    // Delete this task from the db
    await _taskStore.record(id).delete(await _db);

    // Refresh tasks list for UI
    await getAll();

    return;
  }
}
