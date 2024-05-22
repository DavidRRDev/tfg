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

  // Lista para mantener los registros por día
  Map<String, List<String>> _recordsByDay = {
    'Lunes': [],
    'Martes': [],
    'Miércoles': [],
    'Jueves': [],
    'Viernes': [],
    'Sábado': [],
    'Domingo': [],
  };

  // Función para cambiar el estado de la expansión de un día
  void _toggleExpansion(String day) {
    setState(() {
      _expansionState.updateAll((key, value) => false); // Cerrar todos los días
      _expansionState[day] = true; // Abrir el día seleccionado
    });
  }

  // Función para agregar un registro al día seleccionado
  void _addRecord(String day, String record) {
    setState(() {
      _recordsByDay[day]?.add(record); // Agregar el registro al día correspondiente
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
              _buildDayTile('Lunes'),
              _buildDayTile('Martes'),
              _buildDayTile('Miércoles'),
              _buildDayTile('Jueves'),
              _buildDayTile('Viernes'),
              _buildDayTile('Sábado'),
              _buildDayTile('Domingo'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayTile(String day) {
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
          ..._recordsByDay[day]?.map((record) => ListTile(
            title: Text(
              record,
              style: TextStyle(color: Colors.white),
            ),
          ))?.toList() ?? [],
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
