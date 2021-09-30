import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_aoo/model/todo_list.dart';
import 'package:todo_aoo/utils.dart';

class FirebaseApi {
  static Future<String> createTodo(TodoList todo) async {
    final firebaseDoc =
        FirebaseFirestore.instance.collection('todoLists').doc();
    todo.id = firebaseDoc.id;
    await firebaseDoc.set(todo.toJson());
    return firebaseDoc.id;
  }

  static Stream<List<TodoList>> fetchTodos() => FirebaseFirestore.instance
      .collection('todoLists')
      .orderBy(TodoField.timeCreated, descending: true)
      .snapshots()
      .transform(
        Utils.transformer(TodoList.fromJson).cast(), //Used .cast
      );

  static Future updateTodo(TodoList todo) async {
    final firebaseDoc =
        FirebaseFirestore.instance.collection('todoLists').doc(todo.id);
    await firebaseDoc.update(todo.toJson());
  }

  static Future deleteTodo(TodoList todo) async {
    final firebaseDoc =
        FirebaseFirestore.instance.collection('todoLists').doc(todo.id);

    await firebaseDoc.delete();
  }
}
