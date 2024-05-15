import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'editarPerfil.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  late String nombreUsuario;
  late String correoElectronico;
  late String direccion;
  late int edad;
  late double peso;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nombreUsuario = prefs.getString('nombreUsuario') ?? 'Nombre de Usuario';
      correoElectronico = prefs.getString('correoElectronico') ?? 'usuario@example.com';
      direccion = prefs.getString('direccion') ?? '123 Calle Principal, Ciudad';
      edad = prefs.getInt('edad') ?? 30;
      peso = prefs.getDouble('peso') ?? 70.5;
    });
  }

  Future<void> _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombreUsuario', nombreUsuario);
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
        elevation: 0, // Sin sombra en la AppBar
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

void main() {
  runApp(MaterialApp(
    home: PerfilPage(),
  ));
}
