import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_service.dart'; // Asegúrate de importar el servicio
import 'editarPerfil.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String nombreUsuario = 'Nombre de Usuario';
  String apellidosUsuario = 'Apellidos del Usuario';
  String correoElectronico = 'usuario@example.com';
  String direccion = '123 Calle Principal, Ciudad';
  int edad = 30;
  double peso = 70.5;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      String userEmail = user.email ?? 'usuario@example.com';
      Map<String, dynamic>? userData = await getUsuario(userId);

      print("Datos del usuario desde Firestore: $userData");

      if (userData != null) {
        setState(() {
          nombreUsuario = userData['nombre'] ?? 'Nombre de Usuario';
          apellidosUsuario = userData['apellidos'] ?? 'Apellidos del Usuario';
          correoElectronico = userEmail;
          direccion = userData['direccion'] ?? '123 Calle Principal, Ciudad';
          edad = userData['edad'] ?? 30;
          peso = userData['peso'] ?? 70.5;
        });
      } else {
        setState(() {
          nombreUsuario = 'Nombre de Usuario';
          apellidosUsuario = 'Apellidos del Usuario';
          correoElectronico = userEmail;
          direccion = '123 Calle Principal, Ciudad';
          edad = 30;
          peso = 70.5;
        });
      }
    }
  }

  Future<void> _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombreUsuario', nombreUsuario);
    await prefs.setString('apellidosUsuario', apellidosUsuario);
    await prefs.setString('correoElectronico', correoElectronico);
    await prefs.setString('direccion', direccion);
    await prefs.setInt('edad', edad);
    await prefs.setDouble('peso', peso);
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
              _buildPerfilInfo('Dirección', direccion),
              _buildPerfilInfo('Edad', edad.toString()),
              _buildPerfilInfo('Peso', peso.toStringAsFixed(1) + ' kg'),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditarPerfilPage(
                        nombreUsuario: nombreUsuario,
                        apellidosUsuario: apellidosUsuario,
                        correoElectronico: correoElectronico,
                        direccion: direccion,
                        edad: edad,
                        peso: peso,
                      ),
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      nombreUsuario = result['nombreUsuario'];
                      apellidosUsuario = result['apellidosUsuario'];
                      correoElectronico = result['correoElectronico'];
                      direccion = result['direccion'];
                      edad = result['edad'];
                      peso = result['peso'];
                      _saveUserData();
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
