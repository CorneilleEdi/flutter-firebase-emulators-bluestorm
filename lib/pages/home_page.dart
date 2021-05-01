import 'package:flutter/material.dart';

import '../models/tasks.dart';
import '../services/auth_service.dart';
import '../services/tasks_service.dart';
import '../utils/extensions.dart';
import 'auth/auth_selector_page.dart';
import 'task_input_dialog.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskService _taskService = TaskService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluestorm"),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await AuthService().signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthSelectorPage(),
                  ),
                );
              } catch (e) {
                context.showErrorSnackbar(e.toString());
              }
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: StreamBuilder<List<Task>>(
          stream: _taskService.getTasks(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return ListView(
                  children: makeListWidget(snapshot),
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.playlist_add),
        onPressed: () async {
          displayDialog(
            context: context,
            taskService: _taskService,
          );
        },
      ),
    );
  }

  makeListWidget(AsyncSnapshot snapshot) {
    return snapshot.data.map<Widget>((Task task) {
      return Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Card(
          elevation: 2.0,
          child: ListTile(
            onLongPress: () {},
            title: Text(
              task.title,
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            trailing: IconButton(
              onPressed: () async {
                await _taskService.deleteTask(task.id!);
              },
              icon: Icon(
                Icons.remove_circle,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
