import 'dart:async';

import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  final String DB_NAME = 'demo.db';
  //only want one instance of the database
  static final AppDatabase _singleton = AppDatabase._();

  static AppDatabase get instance => _singleton;
  Completer<Database> _dbOpenCompleter;

  AppDatabase._();
  Database _database;
  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }
    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    final database = await databaseFactoryIo.openDatabase(DB_NAME);
    _dbOpenCompleter.complete(database);
  }
}
