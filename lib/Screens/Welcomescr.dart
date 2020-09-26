import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test2/Utilities/design.dart';
import 'package:flutter_test2/Screens/SignUp.dart';

class WelcomScreen extends StatefulWidget {
  @override
  _WelcomScreen createState() => _WelcomScreen();
}

class _WelcomScreen extends State<WelcomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Welcome'),
      ),
    );
  }
}
