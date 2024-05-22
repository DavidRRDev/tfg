import 'package:flutter/material.dart';

class EditarPerfilPage extends StatefulWidget {
  final String nombreUsuario;
  final String apellidosUsuario;
  final String correoElectronico;
  final int edad;
  final double altura;
  final double peso;
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
    _edadController = TextEditingController(text: widget.edad.toString());
    _alturaController = TextEditingController(text: widget.altura.toString());
    _pesoController = TextEditingController(text: widget.peso.toString());
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
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            _buildEditablePerfilInfo('Nombre', _nombreController),
            _buildEditablePerfilInfo('Apellidos', _apellidosController),
            _buildEditablePerfilInfo('Correo Electrónico', _correoController),
            _buildEditablePerfilInfo('Edad', _edadController, isNumeric: true),
            _buildEditablePerfilInfo('Altura', _alturaController, isNumeric: true),
            _buildEditablePerfilInfo('Peso', _pesoController, isNumeric: true),
            _buildEditablePerfilInfo('Sexo', _sexoController),
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
    );
  }

  Widget _buildEditablePerfilInfo(String label, TextEditingController controller, {bool isNumeric = false}) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
      subtitle: TextField(
        controller: controller,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        keyboardType: isNumeric ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
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
