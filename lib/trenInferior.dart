import 'package:flutter/material.dart';

class TrenInferiorPage extends StatelessWidget {
  // Función para manejar la acción al presionar un botón
  void _onDayPressed(BuildContext context, String day) {
    print('Día seleccionado: $day');
    // Aquí puedes agregar la lógica que necesitas al presionar un día
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tren Inferior',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 4.0), // Espacio entre el título y el subtítulo
            Text(
              '¿Qué día de la semana quieres registrar?',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
              _buildDayButton(context, 'Lunes'),
              _buildDayButton(context, 'Martes'),
              _buildDayButton(context, 'Miércoles'),
              _buildDayButton(context, 'Jueves'),
              _buildDayButton(context, 'Viernes'),
              _buildDayButton(context, 'Sábado'),
              _buildDayButton(context, 'Domingo'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayButton(BuildContext context, String day) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5), // Color oscuro semitransparente
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextButton(
        onPressed: () {
          _onDayPressed(context, day);
        },
        child: Text(
          day,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TrenInferiorPage(),
  ));
}
