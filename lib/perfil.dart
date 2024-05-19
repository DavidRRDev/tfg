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
  String edad = 'Edad';
  String altura = 'Altura';
  String peso = 'Peso';
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

      Map<String, dynamic>? userData = await getUsuario(userId);
      print("Datos del usuario desde Firestore: $userData");

      if (userData != null) {
        setState(() {
          nombreUsuario = userData['nombre'] ?? 'Nombre de Usuario';
          apellidosUsuario = userData['apellidos'] ?? 'Apellidos del Usuario';
          correoElectronico = user.email ?? 'usuario@example.com';
          edad = userData['edad'] ?? 'Edad';
          altura = userData['altura'] ?? 'Altura';
          peso = userData['peso'] ?? 'Peso';
          sexo = userData['sexo'] ?? 'Sexo';
        });
      } else {
        print("El documento del usuario no existe en Firestore.");
      }
    } else {
      print("El usuario no ha iniciado sesión.");
    }
  }

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.all(16.0),
            children: [
              ListTile(
                title: Text(
                  'Foto de Perfil',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
              ),
              _buildPerfilInfo('Nombre', nombreUsuario),
              _buildPerfilInfo('Apellidos', apellidosUsuario),
              _buildPerfilInfo('Correo Electrónico', correoElectronico),
              _buildPerfilInfo('Edad', edad),
              _buildPerfilInfo('Altura', altura),
              _buildPerfilInfo('Peso', peso),
              _buildPerfilInfo('Sexo', sexo),
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
                      edad = result['edad'];
                      altura = result['altura'];
                      peso = result['peso'];
                      sexo = result['sexo'];

                      updateUsuario(userId, {
                        'nombre': nombreUsuario,
                        'apellidos': apellidosUsuario,
                        'correo': correoElectronico,
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

  Widget _buildPerfilInfo(String label, String value) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
      subtitle: Text(
        value,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
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
