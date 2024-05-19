import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'paginaPrincipal.dart';

class DatosUsuario extends StatefulWidget {
  @override
  _DatosUsuarioState createState() => _DatosUsuarioState();
}

class _DatosUsuarioState extends State<DatosUsuario> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  String _sexo = 'Hombre'; // Valor predeterminado

  Future<void> _registerUserToFirebase(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _showErrorDialog(context, 'Error de autenticación',
            'No hay ningún usuario autenticado. Por favor, inicia sesión primero.');
        return;
      }

      await FirebaseFirestore.instance
          .collection('datosDeUsuario')
          .doc(user.uid)
          .set({
        'peso': _pesoController.text,
        'altura': _alturaController.text,
        'edad': _edadController.text,
        'sexo': _sexo,
        'uid': user.uid, // Add the user's UID as a foreign key
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PaginaPrincipal()),
      );
    } catch (e) {
      print('Error al registrar datos de usuario: $e');
      _showErrorDialog(context, 'Error de registro',
          'Ocurrió un error al registrar los datos del usuario. Por favor, inténtalo de nuevo más tarde.');
    }
  }

  void _showErrorDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
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
                          controller: _pesoController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Peso',
                            labelStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        TextFormField(
                          controller: _alturaController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Altura',
                            labelStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        TextFormField(
                          controller: _edadController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Edad',
                            labelStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        DropdownButtonFormField(
                          value: _sexo,
                          items: ['Hombre', 'Mujer'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _sexo = value!;
                            });
                          },
                          dropdownColor: Colors.black,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Sexo',
                            labelStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                          ),
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