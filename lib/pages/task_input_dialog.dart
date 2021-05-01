import 'package:flutter/material.dart';

import '../models/tasks.dart';
import '../services/tasks_service.dart';

displayDialog({
  required BuildContext context,
  required TaskService taskService,
}) async {
  final TextEditingController textEditingController = TextEditingController();

  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Add a task'),
        content: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            labelText: 'title',
            filled: true,
            hintText: "Enter a title",
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'Add',
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              final message = textEditingController.text;

              final task = Task(
                title: message,
              );
              await taskService.addTask(task);
              textEditingController.clear();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
