import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(child: Icon(Icons.add)),
          ),
        ],
      ),
      body: Padding(
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
                      Text('Football'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                                'We are the pride of london, we just thrash spurs 3-1,We are the pride of london, we just thrash spurs 3-1'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: addTodos,
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget addTodos() {
  return AlertDialog(
    backgroundColor: Colors.red,
    title: Text('Hello'),
    content: Text('wanna'),
  );
}
