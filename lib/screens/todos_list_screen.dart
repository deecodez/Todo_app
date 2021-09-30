import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_aoo/provider/todo_provider.dart';
import 'package:todo_aoo/widgets/todo_widget.dart';

class TodosListScreen extends StatelessWidget {
  const TodosListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final todos = provider.todo;

    return todos.isEmpty
        ? Center(
            child: Text(
              'No Todos Yet, Add One',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          )
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16.0),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoWidget(todo: todo);
            },
          );
    // return TodoWidget(
    //   todo: TodoList(dateTime: DateTime.now(), title: 'Travelling to Milan'),
    // );
  }
}
