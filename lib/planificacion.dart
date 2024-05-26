import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_service.dart';

class PlanificacionPage extends StatefulWidget {
  @override
  _PlanificacionPageState createState() => _PlanificacionPageState();
}

class _PlanificacionPageState extends State<PlanificacionPage> {
  Map<String, List<Map<String, dynamic>>> _recordsByDay = {
    'Lunes': [],
    'Martes': [],
    'Miércoles': [],
    'Jueves': [],
    'Viernes': [],
    'Sábado': [],
    'Domingo': [],
  };

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
      await _loadTrenSuperiorData();
      await _loadTrenInferiorData(); // Cargar los datos del tren inferior
    }
  }

  Future<void> _loadTrenSuperiorData() async {
    List<Map<String, dynamic>> data = await getTrenSuperiorData();
    setState(() {
      _recordsByDay = {
        'Lunes': [],
        'Martes': [],
        'Miércoles': [],
        'Jueves': [],
        'Viernes': [],
        'Sábado': [],
        'Domingo': [],
      };
      for (var record in data) {
        String day = record['day'];
        _recordsByDay[day]?.add(record);
      }
    });
  }

  Future<void> _loadTrenInferiorData() async {
    List<Map<String, dynamic>> data = await getTrenInferiorData();
    setState(() {
      for (var record in data) {
        String day = record['day'];
        _recordsByDay[day]?.add(record);
      }
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _mostrarDialogoConfirmacion();
            },
            color: Colors.white,
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/fondo.jpg'),
                  fit: BoxFit.cover,
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
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ExpansionTile(
        title: Text(
          day,
          style: TextStyle(color: Colors.white),
        ),
        children: _recordsByDay[day]
                ?.map((record) => ListTile(
                      title: Text(
                        "${record['exercise']} - ${record['reps']} reps - ${record['series']} series - Descanso: ${record['descanso']}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
                ?.toList() ??
            [],
      ),
    );
  }

  void _mostrarDialogoConfirmacion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación'),
          content:
              Text('¿Seguro que desea eliminar todos los datos registrados?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo sin hacer nada
              },
            ),
            TextButton(
              child: Text('Aceptar'),
              onPressed: () async {
                await deleteAllInferiorData();
                await deleteAllTrenSuperiorData(); // Eliminar todos los registros
                Navigator.of(context)
                    .pop(); // Cerrar el diálogo después de aceptar
                _mostrarMensajeExito(); // Mostrar mensaje de éxito
                await _loadUserData(); // Actualizar los datos después de eliminar
                setState(() {}); // Forzar un redibujado manual
              },
            ),
          ],
        );
      },
    );
  }

  void _mostrarMensajeExito() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Éxito'),
          content: Text('Datos eliminados correctamente'),
          actions: [
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Cerrar el diálogo después de aceptar
              },
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PlanificacionPage(),
  ));
}
