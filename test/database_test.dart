import 'package:sembast/sembast.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/utils/database_utils.dart';
import 'package:what_when/model/TaskModel.dart';
import 'package:what_when/model/app_database.dart';
import 'package:what_when/model/task_dao.dart';

main() {
  test('test database', () async {
    // File path to a file in the current directory
    String dbPath = 'sample.db';
    DatabaseFactory dbFactory = databaseFactoryIo;

// We use the database factory to open the database
    Database db = await dbFactory.openDatabase(dbPath);
    // dynamically typed store
    var store = StoreRef.main();
// Easy to put/get simple values or map
// A key can be of type int or String and the value can be anything as long as it can
// be properly JSON encoded/decoded
    var chicken = await store.record('title').put(db, 'Simple application');
    await store.record('version').put(db, 10);
    await store.record('settings').put(db, {'offline': true});

// read values
    var title = await store.record('title').get(db) as String;
    var version = await store.record('version').get(db) as int;
    var settings = await store.record('settings').get(db) as Map;

// ...and delete
    await store.record('version').delete(db);

    // what are the store names
    var whatever = getNonEmptyStoreNames(db);
    print(whatever);
  });

  test('database persistence', () async {
    String dbpath = 'sample.db';
    DatabaseFactory dbFactory = databaseFactoryIo;

    Database db = await dbFactory.openDatabase(dbpath);
    var store = StoreRef.main();
    expect({'offline': true}, await store.record('settings').get(db) as Map);
  });

  test('adding something to the database.. adds something to the database',
      () async {
    var store = intMapStoreFactory.store('store');
    var db = await AppDatabase.instance.database;
    await store.record(1).add(db, {'value': 'poutine'});
    var test = await store.record(1).get(db);
    expect({'value': 'poutine'}, test);
  });

  test('task added to database can be retrieved as a task', () async {
    TaskModel task = TaskModel((b) => b
      ..id = 1
      ..title = 'wah a krof'
      ..parent = 0);
    await TaskDAO.instance.insert(task);
    TaskModel retrieved = await TaskDAO.instance.getTaskById(1);
    expect(task, retrieved);
  });
}
