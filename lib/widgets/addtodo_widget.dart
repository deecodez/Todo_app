import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_aoo/model/todo_list.dart';
import 'package:todo_aoo/provider/todo_provider.dart';

import 'todo_form_widget.dart';

class AddTodoWidget extends StatefulWidget {
  const AddTodoWidget({Key? key}) : super(key: key);

  @override
  _AddTodoWidgetState createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String reminderDate = '';
  String reminderTime = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add A Todo',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            TodoFormWidget(
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDecription: (description) =>
                  setState(() => this.description = description),
              onChangedReminderDate: (reminderDate) =>
                  setState(() => this.reminderDate = reminderDate),
              onChangedReminderTime: (reminderTime) =>
                  setState(() => this.reminderTime = reminderTime),
              onSavedTodos: addTodo,
            )
          ],
        ),
      ),
    );
  }

  void addTodo() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final todo = TodoList(
          timeCreated: DateTime.now(),
          id: DateTime.now().toString(),
          description: description,
          title: title,
          reminderDate: reminderDate,
          reminderTime: reminderTime);
      final provider = Provider.of<TodoProvider>(context, listen: false);
      provider.addTodo(todo);
      Navigator.pop(context);
    }
  }
}
