import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/src/core/utils/constants.dart';

import '../models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<bool> createTodo(TodoModel todoModel);

  Future<bool> updateTodo(TodoModel todoModel);

  Future<bool> deleteTodo(TodoModel todoModel);

  Future<List<TodoModel>> getTodos();
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final FirebaseFirestore firestore;

  TodoRemoteDataSourceImpl({required this.firestore});

  @override
  Future<bool> createTodo(TodoModel todoModel) async {
    await firestore.collection(Keys.todoTable).doc().set(todoModel.toJson());
    return true;
  }

  @override
  Future<bool> deleteTodo(TodoModel todoModel) async {
    final data = await firestore
        .collection(Keys.todoTable)
        .where(Keys.id, isEqualTo: todoModel.id)
        .limit(1)
        .get();

    if (data.docs.isNotEmpty) {
      DocumentReference documentReference = data.docs[0].reference;
      await documentReference.delete();
    }

    return true;
  }

  @override
  Future<List<TodoModel>> getTodos() async {
    final queryList = (await firestore.collection(Keys.todoTable).get()).docs;

    return List.generate(
      queryList.length,
      (index) => TodoModel.fromJson(
        queryList[index],
      ),
    );
  }

  @override
  Future<bool> updateTodo(TodoModel todoModel) async {
    final data = await firestore
        .collection(Keys.todoTable)
        .where(Keys.id, isEqualTo: todoModel.id)
        .limit(1)
        .get();

    if (data.docs.isNotEmpty) {
      DocumentReference documentReference = data.docs[0].reference;
      await documentReference.update(todoModel.toJson());
    }
    return true;

    // .where('id', isEqualTo: todoModel.id).;
  }
}
