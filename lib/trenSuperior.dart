import 'package:flutter/material.dart';

class TrenSuperiorPage extends StatefulWidget {
  @override
  _TrenSuperiorPageState createState() => _TrenSuperiorPageState();
}

class _TrenSuperiorPageState extends State<TrenSuperiorPage> {
  // Lista de días de la semana
  final List<String> days = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];

  // Lista de ejercicios
  final List<String> ejercicios = [
    'Remo horizontal con mancuernas',
    'Press militar',
    'Flexiones',
    'Curl de Bíceps',
    'Remo unilateral',
    'Elevaciones laterales con elevaciones frontales',
    'Press con mancuernas',
    'Curl de triceps overhead',
    'Elevaciones laterales inclinadas',
    'Balanceo con pesas rusas',
  ];

  // Listas de repeticiones, series y tiempos de descanso
  final List<int> repeticiones = List<int>.generate(20, (i) => i + 1);
  final List<int> series = List<int>.generate(6, (i) => i + 1);
  final List<String> descansos = [
    '0.30s',
    '0.45s',
    '1.00m',
    '1.15m',
    '1.30m',
    '1.45m',
    '2.00m',
    '2.15m',
    '2.30m',
    '2.45m',
    '3.00m',
  ];

  String? selectedDay;
  String? selectedExercise;
  int? selectedReps;
  int? selectedSeries;
  String? selectedDescanso;

  // Función para manejar la acción al seleccionar un día
  void _onDaySelected(String? day) {
    setState(() {
      selectedDay = day;
      print('Día seleccionado: $day');
    });
  }

  // Función para manejar la acción al seleccionar un ejercicio
  void _onExerciseSelected(String? ejercicio) {
    setState(() {
      selectedExercise = ejercicio;
      print('Ejercicio seleccionado: $ejercicio');
    });
  }

  // Función para manejar la acción al seleccionar repeticiones
  void _onRepsSelected(int? reps) {
    setState(() {
      selectedReps = reps;
      print('Repeticiones seleccionadas: $reps');
    });
  }

  // Función para manejar la acción al seleccionar series
  void _onSeriesSelected(int? series) {
    setState(() {
      selectedSeries = series;
      print('Series seleccionadas: $series');
    });
  }

  // Función para manejar la acción al seleccionar tiempo de descanso
  void _onDescansoSelected(String? descanso) {
    setState(() {
      selectedDescanso = descanso;
      print('Descanso seleccionado: $descanso');
    });
  }

  // Función para enviar los datos seleccionados y mostrar la notificación de éxito o fracaso
  void _sendData() {
    // Verificar si todos los datos están seleccionados
    if (selectedDay != null &&
        selectedExercise != null &&
        selectedReps != null &&
        selectedSeries != null &&
        selectedDescanso != null) {
      // Aquí puedes enviar los datos a donde desees
      print('Datos enviados:');
      print('Día: $selectedDay');
      print('Ejercicio: $selectedExercise');
      print('Repeticiones: $selectedReps');
      print('Series: $selectedSeries');
      print('Descanso: $selectedDescanso');

      // Mostrar notificación de éxito
      _showNotification('Datos enviados correctamente', Colors.green);
    } else {
      // Mostrar notificación de error
      _showNotification('Por favor, selecciona todos los campos', Colors.red);
    }
  }

  // Función para mostrar la notificación
  void _showNotification(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tren Superior', style: TextStyle(color: Colors.white)),
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
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selecciona un día', style: TextStyle(color: Colors.white, fontSize: 16.0)),
                    _buildDropdown(
                      context: context,
                      value: selectedDay,
                      hint: 'Selecciona un día',
                      items: days,
                      onChanged: _onDaySelected,
                    ),
                    SizedBox(height: 16.0), // Espacio entre subtítulos
                    Text('Selecciona un ejercicio', style: TextStyle(color: Colors.white, fontSize: 16.0)),
                    _buildDropdown(
                      context: context,
                      value: selectedExercise,
                      hint: 'Selecciona un ejercicio',
                      items: ejercicios,
                      onChanged: _onExerciseSelected,
                    ),
                    SizedBox(height: 16.0), // Espacio entre subtítulos
                    Text('Selecciona repeticiones', style: TextStyle(color: Colors.white, fontSize: 16.0)),
                    _buildDropdown(
                      context: context,
                      value: selectedReps,
                      hint: 'Selecciona repeticiones',
                      items: repeticiones,
                      onChanged: _onRepsSelected,
                    ),
                    SizedBox(height: 16.0), // Espacio entre subtítulos
                    Text('Selecciona series', style: TextStyle(color: Colors.white, fontSize: 16.0)),
                    _buildDropdown(
                      context: context,
                      value: selectedSeries,
                      hint: 'Selecciona series',
                      items: series,
                      onChanged: _onSeriesSelected,
                    ),
                    SizedBox(height: 16.0), // Espacio entre subtítulos
                    Text('Selecciona descanso', style: TextStyle(color: Colors.white, fontSize: 16.0)),
                    _buildDropdown(
                      context: context,
                      value: selectedDescanso,
                      hint: 'Selecciona descanso',
                      items: descansos,
                      onChanged: _onDescansoSelected,
                    ),
                    SizedBox(height: 32.0), // Espacio entre los dropdowns y el botón
                    Center(
                      child: ElevatedButton(
                        onPressed: _sendData,
                        child: Text('Enviar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown<T>({
    required BuildContext context,
    required T? value,
    required String hint,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      margin: EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: DropdownButton<T>(
        dropdownColor: Colors.black,
        value: value,
        hint: Text(hint, style: TextStyle(color: Colors.white)),
        isExpanded: true,
        underline: SizedBox(),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<T>>((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(value.toString(), style: TextStyle(color: Colors.white)),
          );
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TrenSuperiorPage(),
  ));
}
