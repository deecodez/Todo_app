import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_aoo/model/todo_list.dart';
import 'package:todo_aoo/provider/todo_provider.dart';
import 'package:todo_aoo/widgets/todo_form_widget.dart';

import '../utils.dart';

class EditTodoScreen extends StatefulWidget {
  final TodoList todo;
  const EditTodoScreen({required this.todo, Key? key}) : super(key: key);

  @override
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  String? title;
  String? description;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    title = widget.todo.title;
    description = widget.todo.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                final provider =
                    Provider.of<TodoProvider>(context, listen: false);
                provider.deleteTodo(widget.todo);

                Utils.showSnackBar(context, 'Todo Deleted Sucessfully');
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete),
            ),

            // GestureDetector(child: Icon(Icons.add)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TodoFormWidget(
            title: title!,
            description: description!,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDecription: (description) =>
                setState(() => this.description = description),
            onSavedTodos: editTodo,
          ),
        ),
      ),
    );
  }

  void editTodo() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TodoProvider>(context, listen: false);
      provider.editTodo(widget.todo, title!, description!);
      Navigator.pop(context);
    }
  }
}
