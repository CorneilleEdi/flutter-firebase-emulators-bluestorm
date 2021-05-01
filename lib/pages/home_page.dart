import 'package:bluestorm/pages/auth/auth_selector_page.dart';
import 'package:bluestorm/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../utils/extensions.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    );
  }
}
