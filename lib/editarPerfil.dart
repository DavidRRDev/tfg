import 'package:flutter/material.dart';

class EditarPerfilPage extends StatefulWidget {
  final String nombreUsuario;
  final String correoElectronico;
  final String direccion;
  final int edad;
  final double peso;

  EditarPerfilPage({
    required this.nombreUsuario,
    required this.correoElectronico,
    required this.direccion,
    required this.edad,
    required this.peso,
  });

  @override
  _EditarPerfilPageState createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  late TextEditingController _nombreController;
  late TextEditingController _correoController;
  late TextEditingController _direccionController;
  late TextEditingController _edadController;
  late TextEditingController _pesoController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.nombreUsuario);
    _correoController = TextEditingController(text: widget.correoElectronico);
    _direccionController = TextEditingController(text: widget.direccion);
    _edadController = TextEditingController(text: widget.edad.toString());
    _pesoController = TextEditingController(text: widget.peso.toStringAsFixed(1));
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _direccionController.dispose();
    _edadController.dispose();
    _pesoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
        backgroundColor: Colors.transparent,
        elevation: 0, // Sin sombra en el AppBar
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
                  'Editar Información',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('assets/avatar.png'), // Foto de perfil del usuario
                ),
              ),
              _buildEditablePerfilInfo('Nombre', _nombreController),
              _buildEditablePerfilInfo('Correo Electrónico', _correoController),
              _buildEditablePerfilInfo('Dirección', _direccionController),
              _buildEditablePerfilInfo('Edad', _edadController, keyboardType: TextInputType.number),
              _buildEditablePerfilInfo('Peso', _pesoController, keyboardType: TextInputType.number),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'nombreUsuario': _nombreController.text,
                    'correoElectronico': _correoController.text,
                    'direccion': _direccionController.text,
                    'edad': int.parse(_edadController.text),
                    'peso': double.parse(_pesoController.text),
                  });
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditablePerfilInfo(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
      subtitle: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EditarPerfilPage(
      nombreUsuario: 'Nombre de Usuario',
      correoElectronico: 'usuario@example.com',
      direccion: '123 Calle Principal, Ciudad',
      edad: 30,
      peso: 70.5,
    ),
  ));
}
