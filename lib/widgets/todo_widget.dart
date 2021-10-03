import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_aoo/model/todo_list.dart';
import 'package:todo_aoo/provider/todo_provider.dart';
import 'package:todo_aoo/screens/edit_todo_screen.dart';
import 'package:todo_aoo/utils.dart';
import 'package:intl/intl.dart';

class TodoWidget extends StatefulWidget {
  final TodoList todo;
  TodoWidget({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          key: Key(widget.todo.id),
          actions: [
            IconSlideAction(
              color: Colors.green,
              caption: 'Edit',
              icon: Icons.edit,
              onTap: () => editTodo(context, widget.todo),
            ),
          ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              caption: 'Delete',
              icon: Icons.delete,
              onTap: () => deleteTodo(context, widget.todo),
            ),
          ],
          child: buildTodo(context),
        ),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
        onTap: () => editTodo(context, widget.todo),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: widget.todo.description.isEmpty ? 150.0 : 200.0,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10.0,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.todo.title,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (widget.todo.description.isNotEmpty)
                          const SizedBox(height: 20.0),
                        Expanded(
                          child: Text(
                            widget.todo.description,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Created: ${DateFormat('dd-MM-yy').format(widget.todo.timeCreated!)}',
                          // 'Created: ${DateFormat('dd-MM-yy – kk:mm').format(todo.timeCreated!)}',

                          // DateFormat('yyyy-MM-dd – kk:mm')
                          //     .format(todo.timeCreated!),
                          // todo.timeCreated.toString(),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Reminder: ${widget.todo.reminderDate} at ${widget.todo.reminderTime}',
                          // 'Created: ${DateFormat('dd-MM-yy – kk:mm').format(todo.timeCreated!)}',

                          // DateFormat('yyyy-MM-dd – kk:mm')
                          //     .format(todo.timeCreated!),
                          // todo.timeCreated.toString(),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  primary: Colors.white,
                                ),
                                onPressed: () => editTodo(context, widget.todo),
                                icon: Icon(Icons.edit),
                                label: Text(
                                  'Edit',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  primary: Colors.white,
                                ),
                                onPressed: () =>
                                    deleteTodo(context, widget.todo),
                                icon: Icon(Icons.delete),
                                label: Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
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

    Utils.showSnackBar(context, 'Todo Deleted Sucessfully', () {
      // "TODO: | To fix undo feature";
      setState(() {
        final providerReAdd = Provider.of<TodoProvider>(context, listen: false);
        providerReAdd.addTodo(todo);
      });
    });
  }

  void editTodo(BuildContext context, TodoList todo) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return EditTodoScreen(todo: todo);
    }));
  }
}
