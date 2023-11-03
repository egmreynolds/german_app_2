import 'package:flutter/material.dart';
import 'package:german_app_2/home_screen.dart';
import 'package:german_app_2/listen_screen_1.dart';
//import 'package:german_app_2/listen_screen_2.dart';
//import 'package:german_app_2/listen_screen_3.dart';
//import 'package:german_app_2/celebration_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Player App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/home_screen':(context) => HomeScreen(),
        '/listen_screen_1.dart': (context) => ListenScreen1(),
        //'/listen_screen_2': (context) => ListenScreen2(data: data),
        //'/listen_screen_3': (context) => ListenScreen3(),
        //'celebration_screen': (context) => CelebrationScreen(),
      },
    );
  }
}


