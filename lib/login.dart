
import 'package:flutter/material.dart';
import 'recuperarContrasena.dart'; // Importa la clase RecuperarContrasena
import 'registro.dart'; // Importa la clase Registro desde el archivo registro.dart
import 'paginaPrincipal.dart';
void main() {
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
      home: Login(),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF000000), Color(0xFF1414B8)],
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
                  'Introduce tu usuario y contraseña',
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Correo Electrónico',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),

                          decoration: InputDecoration(

                            border: InputBorder.none,
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 20,
                        ),
                        Text(
                          'Contraseña',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          obscureText: true,

                          decoration: InputDecoration(

                            border: InputBorder.none,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),
                
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => PaginaPrincipal()),
                    );
                  },
                  child: Text('Iniciar Sesión'),
                ),

                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registro()), // Navega a la clase Registro
                    );
                  },
                  child: Text(
                    '¿No tienes cuenta? Regístrate aquí',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecuperarContrasena()), // Navega a la clase RecuperarContrasena
                    );
                  },
                  child: Text(
                    '¿Has olvidado tu contraseña?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Image.asset(
                  'assets/drj.png',
                  height: 200,
                  width: 200,
                ),
                SizedBox(height: 20),

              ],
            )
          ),
        ),
      ),
    );
  }
}
