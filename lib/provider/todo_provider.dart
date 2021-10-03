import 'package:flutter/cupertino.dart';
import 'package:todo_aoo/api/firebase_api.dart';
import 'package:todo_aoo/model/todo_list.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoList> _todosList = [
    // TodoList(
    //   timeCreated: DateTime.now(),
    //   title: 'Travelling to Milan',
    //   id: DateTime.now().toString(),
    // ),
    // TodoList(
    //   timeCreated: DateTime.now(),
    //   title: 'To Visit Mummy',
    //   description: 'Going from PH',
    //   id: DateTime.now().toString(),
    // ),
    // TodoList(
    //   timeCreated: DateTime.now(),
    //   title: 'To Subcribe TV',
    //   description: 'Pay Cable Newtork',
    //   id: DateTime.now().toString(),
    // ),
    // TodoList(
    //   timeCreated: DateTime.now(),
    //   title: 'Holiday Trip to Paris',
    //   id: DateTime.now().toString(),
    // ),
    // TodoList(
    //   timeCreated: DateTime.now(),
    //   title: 'Preimership Start',
    //   description: 'Arsenal vs Watford',
    //   id: DateTime.now().toString(),
    // ),
  ];

  List<TodoList> get todo {
    //another alternative for filtering between showing favorite and all
    // if (_showFavoriteOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._todosList];
  }

  void setTodos(List<TodoList> todos) =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _todosList = todos;
        notifyListeners();
      });

  // void addTodo(TodoList todo) {
  //   _todosList.add(todo);
  //   notifyListeners();
  // }
  void addTodo(TodoList todo) => FirebaseApi.createTodo(todo);

  // void deleteTodo(TodoList todo) {
  //   _todosList.remove(todo);
  //   notifyListeners();
  // }
  void deleteTodo(TodoList todo) => FirebaseApi.deleteTodo(todo);

  void editTodo(TodoList todo, String title, String description,
      String reminderDate, String reminderTime) {
    todo.title = title;
    todo.description = description;
    todo.reminderDate = reminderDate;
    todo.reminderTime = reminderTime;
    FirebaseApi.updateTodo(todo);
    // notifyListeners();
  }

  // List<TodoList> get todosList => _todosList.where((todo) => todo == false).toList();
}
