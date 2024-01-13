import 'package:sqflite/sqflite.dart';
import 'package:todo_list/src/core/utils/constants.dart';

import '../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<bool> createTodo(TodoModel todoModel);

  Future<bool> updateTodo(TodoModel todoModel);

  Future<bool> deleteTodo(TodoModel todoModel);

  Future<List<TodoModel>> getTodos();
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final Database db;

  TodoLocalDataSourceImpl({required this.db});

  @override
  Future<bool> createTodo(TodoModel todoModel) async {
    int id = await db.insert(Keys.todoTable, todoModel.toJson());
    return id != 0;
  }

  @override
  Future<List<TodoModel>> getTodos() async {
    final queryList = await db.query(Keys.todoTable, orderBy: "id desc");
    return List.generate(
      queryList.length,
      (index) => TodoModel.fromJson(
        queryList[index],
      ),
    );
  }

  @override
  Future<bool> updateTodo(TodoModel todoModel) async {
    int count = await db.update(Keys.todoTable, todoModel.toJson(),
        where: 'id = ?', whereArgs: [todoModel.id]);

    return count != 0;
  }

  @override
  Future<bool> deleteTodo(TodoModel todoModel) async {
    int count = await db
        .delete(Keys.todoTable, where: 'id = ?', whereArgs: [todoModel.id]);

    return count != 0;
  }
}
