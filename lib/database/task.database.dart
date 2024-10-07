import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:untitled/database/scripts.dart';

import '../domain/task.dart';

class TaskDatabase {
    static final TaskDatabase instance = TaskDatabase._init();

    static Database? _database;

    TaskDatabase._init();

    Future<Database> get database async{
      if (_database !=null){
        return _database!;
      }
      _database = await _initDatabase("myapp");
      return _database!;
    }

    Future<Database> _initDatabase(String filePath) async {
          final dbPath = await getDatabasesPath();
          final pathLocal = join(dbPath, filePath);
          return await openDatabase(
              pathLocal,
              version: 1,
              onCreate: _onCreate);

    }

    Future<void> _onCreate(Database db, int version) async {
      await db.execute(createTable);

    }

    Future<int> insert(Task value) async{
      final db = await instance.database;
      return db.insert("tasks", value.toJson());
    }

    Future<List<Task>> readAll() async{
      final db = await instance.database;
      final result = await db.query("tasks");
      return result.map((taskJson) => Task.fromJson(taskJson)).toList();
    }

}