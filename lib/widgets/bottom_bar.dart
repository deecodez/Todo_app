import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_aoo/api/firebase_api.dart';
import 'package:todo_aoo/model/todo_list.dart';
import 'package:todo_aoo/provider/todo_provider.dart';
import 'package:todo_aoo/screens/todos_list_screen.dart';

import 'addtodo_widget.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int pageIndex = 0;

  List<Widget> pageList = <Widget>[
    TodosListScreen(),
    Container(
      child: Text('2'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // centerTitle: true,
        title: Text(
          'Todo App',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              child: Icon(Icons.add),
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AddTodoWidget()),
              // child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<TodoList>>(
        stream: FirebaseApi.fetchTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Something Went Wrong, Try Again Later'),
                );
              } else {
                final todos = snapshot.data;
                final provider = Provider.of<TodoProvider>(context);
                provider.setTodos(todos!);
                return pageList[pageIndex];
              }
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        // selectedItemColor: AppColors.primaryColor,
        elevation: 20,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Completed',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => AddTodoWidget()),
        child: Icon(Icons.add),
      ),
    );
  }
}
