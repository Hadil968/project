import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Use the 'super' parameter here.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Math Quiz App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home:const  HomeScreen(),
    );
  }
}







