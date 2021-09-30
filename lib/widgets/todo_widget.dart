import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_aoo/model/todo_list.dart';
import 'package:todo_aoo/provider/todo_provider.dart';
import 'package:todo_aoo/screens/edit_todo_screen.dart';
import 'package:todo_aoo/utils.dart';

class TodoWidget extends StatelessWidget {
  final TodoList todo;
  const TodoWidget({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          key: Key(todo.id),
          actions: [
            IconSlideAction(
              color: Colors.green,
              caption: 'Edit',
              icon: Icons.edit,
              onTap: () => editTodo(context, todo),
            ),
          ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              caption: 'Delete',
              icon: Icons.delete,
              onTap: () => deleteTodo(context, todo),
            ),
          ],
          child: buildTodo(context),
        ),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
        onTap: () => editTodo(context, todo),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                // height: 250.0,
                child: Card(
                  elevation: 10.0,
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(todo.title),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (todo.description.isNotEmpty)
                              Expanded(
                                child: Text(todo.description),
                              ),
                            const SizedBox(width: 8.0),
                            Column(
                              children: [
                                Icon(Icons.edit),
                                const SizedBox(height: 5.0),
                                Icon(Icons.delete),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void deleteTodo(BuildContext context, TodoList todo) {
    final provider = Provider.of<TodoProvider>(context, listen: false);
    provider.deleteTodo(todo);

    Utils.showSnackBar(context, 'Todo Deleted Sucessfully');
  }

  void editTodo(BuildContext context, TodoList todo) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return EditTodoScreen(todo: todo);
    }));
  }
}
