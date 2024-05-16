import 'package:flutter/material.dart';

class PlanificacionPage extends StatefulWidget {
  @override
  _PlanificacionPageState createState() => _PlanificacionPageState();
}

class _PlanificacionPageState extends State<PlanificacionPage> {
  // Mapa para mantener el estado de la expansión de cada día
  Map<String, bool> _expansionState = {
    'Lunes': false,
    'Martes': false,
    'Miércoles': false,
    'Jueves': false,
    'Viernes': false,
    'Sábado': false,
    'Domingo': false,
  };

  // Función para cambiar el estado de la expansión de un día
  void _toggleExpansion(String day) {
    setState(() {
      _expansionState.updateAll((key, value) => false); // Cerrar todos los días
      _expansionState[day] = true; // Abrir el día seleccionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calendario Semanal',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Center(
            child: Container(
             
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/fondo.jpg'), // Ruta de la imagen de fondo
                  fit: BoxFit.cover, // Ajustar la imagen
                ),
              ),
            ),
          ),
          ListView(
            children: [
              _buildDayTile('Lunes', ['Registro 1', 'Registro 2']),
              _buildDayTile('Martes', ['Registro 3', 'Registro 4', 'Registro 5']),
              _buildDayTile('Miércoles', ['Registro 6', 'Registro 7']),
              _buildDayTile('Jueves', ['Registro 8', 'Registro 9', 'Registro 10']),
              _buildDayTile('Viernes', ['Registro 11']),
              _buildDayTile('Sábado', ['Registro 12', 'Registro 13']),
              _buildDayTile('Domingo', ['Registro 14']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayTile(String day, List<String> records) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5), // Color oscuro semitransparente
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ExpansionTile(
        title: Text(
          day,
          style: TextStyle(color: Colors.white),
        ),
        initiallyExpanded: _expansionState[day] ?? false,
        children: [
          for (var record in records)
            ListTile(
              title: Text(
                record,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                print('Registro: $record');
              },
            ),
        ],
        onExpansionChanged: (expanded) {
          if (expanded) {
            _toggleExpansion(day);
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PlanificacionPage(),
  ));
}
