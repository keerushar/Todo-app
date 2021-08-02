import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/todo.dart';
import 'dart:async';
import 'models/task.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'toodo.db'),
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, desc TEXT)',
        );
        await db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, taskId INTEGER, title TEXT, isChecked INTEGER)',
        );
        return;
      },
      version: 1,
    );
  }

  Future<int> insertTask(Task task) async {
    int taskId = 0;
    Database _db = await database();
    await _db
        .insert('tasks', task.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      taskId = value;
    });
    return taskId;
  }

  Future<void> insertTodo(Todo todo) async {
    Database _db = await database();
    await _db.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTaskTitle(int id, String title) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET title = '$title' WHERE id= '$id'");
  }

  Future<void> updateTaskDesc(int id, String desc) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET desc = '$desc' WHERE id= '$id'");
  }

  Future<List<Task>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('tasks');
    return List.generate(taskMap.length, (index) {
      return Task(
        id: taskMap[index]['id'],
        title: taskMap[index]['title'],
        desc: taskMap[index]['desc'],
      );
    });
  }

  Future<List<Todo>> getTodo(int taskId) async {
    Database _db = await database();
    List<Map<String, dynamic>> todoMap =
        await _db.rawQuery('SELECT * FROM todos WHERE taskId = $taskId');
    return List.generate(todoMap.length, (index) {
      return Todo(
        id: todoMap[index]['id'],
        taskId: todoMap[index]['taskId'],
        title: todoMap[index]['title'],
        isChecked: todoMap[index]['isChecked'],
      );
    });
  }

  Future<void> updateTodoDone(int id, int isChecked) async {
    Database _db = await database();
    await _db.rawUpdate(
        "UPDATE todos SET isChecked = '$isChecked' WHERE id = '$id'");
  }

  Future<void> deleteTask(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM tasks WHERE id = '$id'");
    await _db.rawDelete("DELETE FROM todos WHERE taskId = '$id'");
  }
}
