import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _confirmarContrasenaController =
      TextEditingController();

  Future<void> _registerUserToFirebase(BuildContext context) async {
    try {
      if (_nombreController.text.isEmpty ||
          _correoController.text.isEmpty ||
          _contrasenaController.text.isEmpty ||
          _apellidosController.text.isEmpty ||
          _confirmarContrasenaController.text.isEmpty) {
        _showErrorDialog(context, 'Por favor, completa todos los campos.');
        return;
      }

      if (_contrasenaController.text != _confirmarContrasenaController.text) {
        _showErrorDialog(context, 'Las contraseñas no coinciden.');
        return;
      }

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _correoController.text,
        password: _contrasenaController.text,
      );

      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(userCredential.user!.uid)
          .set({
        'nombre': _nombreController.text,
        'apellidos': _apellidosController.text,
        'correo': _correoController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Datos guardados correctamente.'),
        ),
      );
      await Future.delayed(Duration(seconds: 2));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } catch (e) {
      print('Error al registrar usuario: $e');
      _showErrorDialog(context,
          'Ocurrió un error al registrar al usuario. Por favor, inténtalo de nuevo más tarde.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error de registro'),
          content: Text(message),
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
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final screenHeight = MediaQuery.of(context).size.height;
          final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

          return SingleChildScrollView(
            child: Container(
              height: screenHeight - keyboardHeight,
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
                    children: <Widget>[
                      SizedBox(height: screenHeight * 0.05),
                      Text(
                        'Formulario de Registro',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      _buildForm(),
                      SizedBox(height: screenHeight * 0.05),
                      ElevatedButton(
                        onPressed: () {
                          _registerUserToFirebase(context);
                        },
                        child: Text('Enviar', style: TextStyle(fontSize: 18)),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Image.asset(
                        'assets/drj.png',
                        height: screenHeight * 0.1,
                        width: screenHeight * 0.1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(_nombreController, 'Nombre'),
            _buildDivider(),
            _buildTextField(_apellidosController, 'Apellidos'),
            _buildDivider(),
            _buildTextField(_correoController, 'Correo Electrónico'),
            _buildDivider(),
            _buildPasswordField(_contrasenaController, 'Contraseña'),
            _buildDivider(),
            _buildPasswordField(
                _confirmarContrasenaController, 'Confirmar Contraseña'),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white, fontSize: 18),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white, fontSize: 18),
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white, fontSize: 18),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey,
      height: 1,
    );
  }
}
