import 'package:flutter/material.dart';
import 'package:tfg/paginaPrincipal.dart';
import 'recuperarContrasena.dart';
import 'registro.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      routes: {
        '/pagina_principal': (context) => PaginaPrincipal(), // Definir la ruta a la página principal
      },
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.blueAccent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 60),
                const Text(
                  'Introduce tu usuario y contraseña',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _buildTextWithInput(
                  'Correo electrónico',
                  TextInputType.emailAddress,
                  _emailController,
                ),
                SizedBox(height: 20),
                _buildPasswordInput('Contraseña', _passwordController),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecuperarContrasena(),
                      ),
                    );
                  },
                  child: Text(
                    "¿Has olvidado la contraseña?",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _signInWithEmailAndPassword();
                  },
                  child: Text('Iniciar', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Registro()),
                    );
                  },
                  child: Text('Registrarse', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Image.asset(
                      'assets/drj.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextWithInput(String label, TextInputType keyboardType,
      TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: 'Ingrese su $label',
            hintStyle: TextStyle(color: Colors.white70),
            fillColor: Colors.white.withOpacity(0.2),
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.visiblePassword,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: 'Ingrese su $label',
            hintStyle: TextStyle(color: Colors.white70),
            fillColor: Colors.white.withOpacity(0.2),
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Verificamos si el usuario está autenticado
      if (userCredential.user != null) {
        // Aquí puedes navegar a la siguiente pantalla o realizar otras acciones después de iniciar sesión correctamente.
        print('Inicio de sesión exitoso: ${userCredential.user!.uid}');
        // Navegar a la página principal después del inicio de sesión exitoso
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PaginaPrincipal()),
        );
      }
    } catch (e) {
      print('Error al iniciar sesión: $e');
      // Aquí puedes mostrar un mensaje de error al usuario si el inicio de sesión falla.
    }
  }
}

// Página principal después de iniciar sesión exitosamente

