import 'dart:math';

import 'package:flutter/material.dart';

import 'paginaPrincipal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // Start a timer after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to SecondScreen after the delay
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PaginaPrincipal()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: max(1000, 2000),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/drj.png'),
            SizedBox(height: 20),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black, // Black background
              Colors.blueAccent, // Blue stripe at the top
            ],
            begin: Alignment.topCenter, // Gradient starts from the top center
            end: Alignment.bottomCenter, // Gradient ends at the bottom center
          ),
        ),
        ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
