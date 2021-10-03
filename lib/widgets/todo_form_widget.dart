import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final String reminderDate;
  final String reminderTime;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDecription;
  final ValueChanged<String> onChangedReminderDate;
  final ValueChanged<String> onChangedReminderTime;
  final VoidCallback onSavedTodos;
  const TodoFormWidget(
      {this.title = '',
      this.description = '',
      this.reminderDate = '',
      this.reminderTime = '',
      required this.onChangedTitle,
      required this.onChangedDecription,
      required this.onChangedReminderDate,
      required this.onChangedReminderTime,
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
          selectReminderdate(),
          const SizedBox(height: 20.0),
          selectReminderTime(),
          const SizedBox(height: 20.0),
          saveButton(),
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

  Widget selectReminderdate() => DateTimePicker(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
          hintText: 'Select Reminder Date',
          // helperText: 'Keep it short, this is just a demo.',
          labelText: 'Date',
        ),
        initialValue: reminderDate,
        // initialDate: ,
        // initialTime: ,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        dateLabelText: 'Date',
        onChanged: onChangedReminderDate,
        // onChanged: (val) => print(val),
        validator: (val) {
          print(val);
          return null;
        },
        onSaved: (val) => print(val),
      );
  Widget selectReminderTime() => DateTimePicker(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
          hintText: 'Select Reminder Time',
          // helperText: 'Keep it short, this is just a demo.',
          labelText: 'Time',
        ),
        type: DateTimePickerType.time,
        initialValue: reminderTime,
        // initialTime: ,
        // firstDate: DateTime(2000),
        // lastDate: DateTime(2100),
        timeLabelText: 'Time',
        onChanged: onChangedReminderTime,
        // onChanged: (val) => print(val),
        validator: (val) {
          print(val);
          return null;
        },
        onSaved: (val) => print(val),
      );
  Widget saveButton() => SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: onSavedTodos,
        child: Text('Save'),
      ));
}
