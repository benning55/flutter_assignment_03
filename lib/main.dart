
import 'package:flutter/material.dart';
import './ui/Task.dart';
import './ui/NewSubject.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        "/": (context) => Task(),
        "/newSub": (context) => NewSubject()
      }
    );
  }
}