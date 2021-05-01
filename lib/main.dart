import 'package:bluestorm/pages/auth/auth_selector_page.dart';
import 'package:bluestorm/pages/home_page.dart';
import 'package:bluestorm/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluestorm',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: AuthService().getUser == null ? AuthSelectorPage() : HomePage(),
    );
  }
}
