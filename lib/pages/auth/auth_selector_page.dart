import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../utils//extensions.dart';
import '../home_page.dart';
import 'email_auth_page.dart';

class AuthSelectorPage extends StatefulWidget {
  AuthSelectorPage({Key? key}) : super(key: key);

  @override
  _AuthSelectorPageState createState() => _AuthSelectorPageState();
}

class _AuthSelectorPageState extends State<AuthSelectorPage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Selectionnez une methode",
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextButton(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Anonyme"),
              ),
              style: TextButton.styleFrom(
                primary: Colors.white70,
                backgroundColor: Colors.grey.shade900,
              ),
              onPressed: () async {
                try {
                  await _auth.signInAnonymously();
                  context.showSuccessSnackbar("Authentification reussie");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                } catch (e) {
                  context.showErrorSnackbar(e.toString());
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextButton(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Google"),
              ),
              style: TextButton.styleFrom(
                primary: Colors.white70,
                backgroundColor: Colors.grey.shade900,
              ),
              onPressed: () async {
                try {
                  await _auth.signInWithGoogle();
                  context.showSuccessSnackbar("Authentification reussie");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                } catch (e) {
                  context.showErrorSnackbar(e.toString());
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextButton(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Email / Password"),
              ),
              style: TextButton.styleFrom(
                primary: Colors.white70,
                backgroundColor: Colors.grey.shade900,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmailAuthPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
