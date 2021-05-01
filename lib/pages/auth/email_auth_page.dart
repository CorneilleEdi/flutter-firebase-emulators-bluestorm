import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../utils/extensions.dart';
import '../home_page.dart';

class EmailAuthPage extends StatefulWidget {
  EmailAuthPage({Key? key}) : super(key: key);

  @override
  _EmailAuthPageState createState() => _EmailAuthPageState();
}

class _EmailAuthPageState extends State<EmailAuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService auth = AuthService();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white70,
                    backgroundColor: Colors.grey.shade900,
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    //Hide keybord to show snackbar on error
                    FocusScope.of(context).requestFocus(FocusNode());

                    try {
                      await auth.signInWithEmailPassword(
                          _emailController.text.trim(),
                          _passwordController.text.trim());
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
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white70,
                    backgroundColor: Colors.grey.shade900,
                  ),
                  child: Text(
                    'Create account',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    //Hide keybord to show snackbar on error
                    FocusScope.of(context).requestFocus(FocusNode());

                    try {
                      await auth.createUserWithEmailAndPassword(
                          _emailController.text.trim(),
                          _passwordController.text.trim());
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
