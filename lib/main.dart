import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth_serve.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: AuthService().handleAuthState(),
    );
  }
}
