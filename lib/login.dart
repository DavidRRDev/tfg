import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'paginaPrincipal.dart';
import 'datosUsuario.dart';
import 'recuperarContrasena.dart';
import 'registro.dart';

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
        '/pagina_principal': (context) => PaginaPrincipal(),
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
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text(
                        'Introduce tu usuario y contraseña',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      _buildTextWithInput(
                        'Correo electrónico',
                        TextInputType.emailAddress,
                        _emailController,
                        _emailFocusNode,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildPasswordInput(
                        'Contraseña',
                        _passwordController,
                        _passwordFocusNode,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecuperarContrasena(),
                            ),
                          );
                        },
                        child: const Text(
                          "¿Has olvidado la contraseña?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16, // Aumentar el tamaño de la letra
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      ElevatedButton(
                        onPressed: () {
                          _signInWithEmailAndPassword();
                        },
                        child: const Text('Iniciar',
                            style: TextStyle(
                                fontSize: 18)), // Aumentar el tamaño de la letra
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Registro()),
                          );
                        },
                        child: const Text('Registrarse',
                            style: TextStyle(
                                fontSize: 18)), // Aumentar el tamaño de la letra
                      ),
                      Spacer(),
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                        child: Image.asset(
                          'assets/drj.png',
                          height: screenHeight * 0.12,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextWithInput(
    String label,
    TextInputType keyboardType,
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18, // Aumentar el tamaño de la letra
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18), // Aumentar el tamaño de la letra
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: 'Ingrese su $label',
            hintStyle: const TextStyle(
                color: Colors.white70,
                fontSize: 16), // Aumentar el tamaño de la letra
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

  Widget _buildPasswordInput(
    String label,
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18, // Aumentar el tamaño de la letra
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18), // Aumentar el tamaño de la letra
          keyboardType: TextInputType.visiblePassword,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: 'Ingrese su $label',
            hintStyle: const TextStyle(
                color: Colors.white70,
                fontSize: 16), // Aumentar el tamaño de la letra
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
      if (userCredential.user != null) {
        print('Inicio de sesión exitoso: ${userCredential.user!.uid}');
        _checkUserData(userCredential.user!.uid);
      }
    } catch (e) {
      print('Error al iniciar sesión: $e');
    }
  }

  Future<void> _checkUserData(String uid) async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection('datosDeUsuario')
          .doc(uid)
          .get();
      if (userData.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PaginaPrincipal()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DatosUsuario()),
        );
      }
    } catch (e) {
      print('Error al comprobar datos de usuario: $e');
    }
  }
}
