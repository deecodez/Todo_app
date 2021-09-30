import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDecription;
  final VoidCallback onSavedTodos;
  const TodoFormWidget(
      {this.title = '',
      this.description = '',
      required this.onChangedTitle,
      required this.onChangedDecription,
      required this.onSavedTodos,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          titleFormField(),
          const SizedBox(height: 30.0),
          descriptionFormField(),
          const SizedBox(height: 20.0),
          saveButton()
        ],
      ),
    );
  }

  Widget titleFormField() => TextFormField(
        maxLines: 1,
        initialValue: title,
        onChanged: onChangedTitle,
        validator: (title) {
          if (title!.isEmpty) {
            return 'Please Enter a title';
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
          hintText: 'Enter Title',
          // helperText: 'Keep it short, this is just a demo.',
          labelText: 'Title',
        ),
      );
  Widget descriptionFormField() => TextFormField(
        maxLines: 3,
        initialValue: description,
        onChanged: onChangedDecription,
        // validator: (title) {
        //   if (title!.isEmpty) {
        //     return 'Please Enter a title';
        //   }
        //   return null;
        // },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
          hintText: 'Enter Description',
          // helperText: 'Keep it short, this is just a demo.',
          labelText: 'Description',
        ),
      );
  Widget saveButton() => SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: onSavedTodos,
        child: Text('Save'),
      ));
}
