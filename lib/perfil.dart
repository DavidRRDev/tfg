import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo del usuario (puedes reemplazar con datos reales)
    String nombreUsuario = 'Nombre de Usuario';
    String correoElectronico = 'usuario@example.com';
    String direccion = '123 Calle Principal, Ciudad';
    int edad = 30;
    double peso = 70.5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Container(
        color: Colors.indigoAccent, // Color de fondo morado-azul
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
                  backgroundImage: AssetImage('assets/avatar.jpg'), // Foto de perfil del usuario
                ),
              ),
              _buildPerfilInfo('Nombre', nombreUsuario),
              _buildPerfilInfo('Correo Electrónico', correoElectronico),
              _buildPerfilInfo('Dirección', direccion),
              _buildPerfilInfo('Edad', edad.toString()),
              _buildPerfilInfo('Peso', peso.toStringAsFixed(1) + ' kg'),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Acción para editar perfil
                },
                child: Text('Editar Perfil'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir un ListTile de información de perfil
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
