import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/database/task.database.dart';

import '../domain/task.dart';

class TaskDataSource {
  late SharedPreferences _preference;
  final TaskDatabase _database = TaskDatabase.instance;
  final Rx<List<Task>?> _tasks = Rx(null);

  initPreference() async {
    _preference = await SharedPreferences.getInstance();
  }

  String? load(String key) {
    return _preference.getString(key);
  }

  save(String key, String value){
    _preference.setString(key, value);
  }

  saveTask(Task task){
    _database.insert(task);
  }
  loadTasks() async{
   _tasks.value = await _database.readAll();
  }


}