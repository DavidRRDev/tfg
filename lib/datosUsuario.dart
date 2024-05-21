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

      // Validar que todos los campos estén llenos
      if (_pesoController.text.isEmpty ||
          _alturaController.text.isEmpty ||
          _edadController.text.isEmpty ||
          _sexo.isEmpty) {
        _showErrorDialog(context, 'Error de registro',
            'Por favor, completa todos los campos.');
        return;
      }

      // Validar que los campos numéricos sean válidos
      final peso = double.tryParse(_pesoController.text);
      final altura = double.tryParse(_alturaController.text);
      final edad = int.tryParse(_edadController.text);

      if (peso == null || altura == null || edad == null) {
        _showErrorDialog(context, 'Error de registro',
            'Por favor, ingresa valores numéricos válidos para peso, altura y edad.');
        return;
      }

      await FirebaseFirestore.instance
          .collection('datosDeUsuario')
          .doc(user.uid)
          .set({
        'peso': peso,
        'altura': altura,
        'edad': edad,
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Formulario de Registro',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(screenWidth * 0.06),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _pesoController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: screenHeight * 0.025),
                          decoration: InputDecoration(
                            labelText: 'Peso',
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight * 0.025),
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        TextFormField(
                          controller: _alturaController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: screenHeight * 0.025),
                          decoration: InputDecoration(
                            labelText: 'Altura',
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight * 0.025),
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        TextFormField(
                          controller: _edadController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: screenHeight * 0.025),
                          decoration: InputDecoration(
                            labelText: 'Edad',
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight * 0.025),
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
                              child: Text(value,
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.025)),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _sexo = value!;
                            });
                          },
                          dropdownColor: Colors.black,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: screenHeight * 0.025),
                          decoration: InputDecoration(
                            labelText: 'Sexo',
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight * 0.025),
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                ElevatedButton(
                  onPressed: () {
                    _registerUserToFirebase(context);
                  },
                  child: Text('Enviar',
                      style: TextStyle(fontSize: screenHeight * 0.025)),
                ),
                SizedBox(height: screenHeight * 0.02),
                Image.asset(
                  'assets/drj.png',
                  height: screenHeight * 0.15,
                  width: screenHeight * 0.15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
