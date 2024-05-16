import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Agregado para autenticación

import 'login.dart'; // Suponiendo que tienes una pantalla de inicio de sesión separada

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario de Registro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Registro(),
    );
  }
}

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final TextEditingController _confirmarContrasenaController =
  TextEditingController();

  Future<void> _registerUserToFirebase(BuildContext context) async {
    try {
      // Validar si las contraseñas coinciden
      if (_contrasenaController.text != _confirmarContrasenaController.text) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error de registro'),
              content: Text('Las contraseñas no coinciden.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Aceptar'),
                ),
              ],
            );
          },
        );
        return;
      }

      // Registrar el usuario en Firebase Firestore
      await FirebaseFirestore.instance.collection('usuarios').add({
        'nombre': _nombreController.text,
        'correo': _correoController.text,
        // Agrega más campos según sea necesario
      });

      // Registrar el usuario en Firebase Authentication
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _correoController.text,
        password: _contrasenaController.text,
      );

      // Redirigir al usuario al menú principal (en este caso, al inicio de sesión)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } catch (e) {
      print('Error al registrar usuario: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error de registro'),
            content: Text(
                'Ocurrió un error al registrar al usuario. Por favor, inténtalo de nuevo más tarde.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.blueAccent,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Formulario de Registro',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nombreController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                            labelStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        TextFormField(
                          controller: _correoController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Correo Electrónico',
                            labelStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        TextFormField(
                          controller: _contrasenaController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            labelStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                          ),
                          obscureText: true,
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        TextFormField(
                          controller: _confirmarContrasenaController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Confirmar Contraseña',
                            labelStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                          ),
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _registerUserToFirebase(context);
                  },
                  child: Text('Enviar'),
                ),
                SizedBox(height: 10),
                Image.asset(
                  'assets/drj.png',
                  height: 200,
                  width: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
