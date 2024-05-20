import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa Firebase Core
import 'package:tfg/login.dart';
import 'firebase_options.dart'; // Asegúrate de importar las opciones de configuración de Firebase

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Asegura que los Widgets de Flutter estén inicializados
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

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
  const MyHomePage({Key? key, required this.title});

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
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF000000), // Black background
                  Color(0xFF1414B8), // Blue stripe in the middle
                  Color(0xFF000000), // Black background
                ],
                begin:
                    Alignment.topCenter, // Gradient starts from the top center
                end: Alignment
                    .bottomCenter, // Gradient ends at the bottom center
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/drj.png',
                      height: constraints.maxHeight *
                          0.4, // Adjust height based on screen size
                      width: constraints.maxWidth *
                          0.8, // Adjust width based on screen size
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
