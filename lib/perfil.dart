import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_service.dart';
import 'editarPerfil.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String nombreUsuario = 'Nombre de Usuario';
  String apellidosUsuario = 'Apellidos del Usuario';
  String correoElectronico = 'usuario@example.com';
  int edad = 0;
  double altura = 0.0;
  double peso = 0.0;
  String sexo = 'Sexo';
  String userId = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      userId = user.uid;
      print("User ID: $userId");

      // Cargar datos de la colección usuarios
      Map<String, dynamic>? usuarioData = await getUsuario(userId);
      print("Datos del usuario desde Firestore (usuarios): $usuarioData");

      // Cargar datos de la colección datosDeUsuario
      Map<String, dynamic>? datosDeUsuarioData =
          await getDatosDeUsuario(userId);
      print(
          "Datos del usuario desde Firestore (datosDeUsuario): $datosDeUsuarioData");

      if (usuarioData != null) {
        setState(() {
          nombreUsuario = usuarioData['nombre'] ?? 'Nombre de Usuario';
          apellidosUsuario = usuarioData['apellidos'] ?? 'Apellidos del Usuario';
          correoElectronico = user.email ?? 'usuario@example.com';
        });
      } else {
        print("El documento del usuario no existe en Firestore.");
      }

      if (datosDeUsuarioData != null) {
        setState(() {
          edad = datosDeUsuarioData['edad'] ?? 0;
          altura = (datosDeUsuarioData['altura'] ?? 0.0).toDouble();
          peso = (datosDeUsuarioData['peso'] ?? 0.0).toDouble();
          sexo = datosDeUsuarioData['sexo'] ?? 'Sexo';
        });
      } else {
        print("El documento de datosDeUsuario no existe en Firestore.");
      }
    } else {
      print("El usuario no ha iniciado sesión.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF5E5EF1)],
          ),
        ),
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(screenWidth * 0.04),
            children: [
              ListTile(
                title: Text(
                  'Perfil',
                  style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                leading: CircleAvatar(
                  radius: screenWidth * 0.09,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
              ),
              _buildPerfilInfo('Nombre', nombreUsuario, screenWidth),
              _buildPerfilInfo('Apellidos', apellidosUsuario, screenWidth),
              _buildPerfilInfo(
                  'Correo Electrónico', correoElectronico, screenWidth),
              _buildPerfilInfo('Edad', edad.toString(), screenWidth),
              _buildPerfilInfo('Altura', altura.toString(), screenWidth),
              _buildPerfilInfo('Peso', peso.toString(), screenWidth),
              _buildPerfilInfo('Sexo', sexo, screenWidth),
              SizedBox(height: screenHeight * 0.02),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditarPerfilPage(
                        nombreUsuario: nombreUsuario,
                        apellidosUsuario: apellidosUsuario,
                        correoElectronico: correoElectronico,
                        edad: edad,
                        altura: altura,
                        peso: peso,
                        sexo: sexo,
                      ),
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      nombreUsuario = result['nombreUsuario'];
                      apellidosUsuario = result['apellidosUsuario'];
                      correoElectronico = result['correoElectronico'];
                      edad = int.tryParse(result['edad']) ?? 0;
                      altura = double.tryParse(result['altura']) ?? 0.0;
                      peso = double.tryParse(result['peso']) ?? 0.0;
                      sexo = result['sexo'];

                      updateDatosDeUsuario(userId, {
                        'edad': edad,
                        'altura': altura,
                        'peso': peso,
                        'sexo': sexo,
                      });   
                    });
                  }
                },
                child: Text('Editar Perfil'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPerfilInfo(String label, String value, double screenWidth) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
            fontSize: screenWidth * 0.038,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: PerfilPage(),
  ));
}
