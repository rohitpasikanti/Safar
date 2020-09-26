import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test2/Screens/AuthService.dart';
import 'package:flutter_test2/Screens/ProfileScreen.dart';
//import 'package:flutter_test2/Screens/Login.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

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
      title: 'Safar',
      debugShowCheckedModeBanner: false,
      home: AuthService().handleAuth(),
      //theme: ThemeProvider.of(context),
    );
  }
}
