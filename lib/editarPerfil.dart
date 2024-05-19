import 'package:flutter/material.dart';

class EditarPerfilPage extends StatefulWidget {
  final String nombreUsuario;
  final String apellidosUsuario;
  final String correoElectronico;
  final String edad;
  final String altura;
  final String peso;
  final String sexo;

  EditarPerfilPage({
    required this.nombreUsuario,
    required this.apellidosUsuario,
    required this.correoElectronico,
    required this.edad,
    required this.altura,
    required this.peso,
    required this.sexo,
  });

  @override
  _EditarPerfilPageState createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  late TextEditingController _nombreController;
  late TextEditingController _apellidosController;
  late TextEditingController _correoController;
  late TextEditingController _edadController;
  late TextEditingController _alturaController;
  late TextEditingController _pesoController;
  late TextEditingController _sexoController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.nombreUsuario);
    _apellidosController = TextEditingController(text: widget.apellidosUsuario);
    _correoController = TextEditingController(text: widget.correoElectronico);
    _edadController = TextEditingController(text: widget.edad);
    _alturaController = TextEditingController(text: widget.altura);
    _pesoController = TextEditingController(text: widget.peso);
    _sexoController = TextEditingController(text: widget.sexo);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    _correoController.dispose();
    _edadController.dispose();
    _alturaController.dispose();
    _pesoController.dispose();
    _sexoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
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
                  'Editar Información',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
              ),
              _buildEditablePerfilInfo('Nombre', _nombreController),
              _buildEditablePerfilInfo('Apellidos', _apellidosController),
              _buildEditablePerfilInfo('Correo Electrónico', _correoController),
              _buildEditablePerfilInfo('Edad', _edadController),
              _buildEditablePerfilInfo('Altura', _alturaController),
              _buildEditablePerfilInfo('Peso', _pesoController),
              _buildEditablePerfilInfo('Sexo', _sexoController),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'nombreUsuario': _nombreController.text,
                    'apellidosUsuario': _apellidosController.text,
                    'correoElectronico': _correoController.text,
                    'edad': _edadController.text,
                    'altura': _alturaController.text,
                    'peso': _pesoController.text,
                    'sexo': _sexoController.text,
                  });
                },
                child: Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditablePerfilInfo(String label, TextEditingController controller) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
      subtitle: TextField(
        controller: controller,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
