import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_service.dart';

class TrenSuperiorPage extends StatefulWidget {
  @override
  _TrenSuperiorPageState createState() => _TrenSuperiorPageState();
}

class _TrenSuperiorPageState extends State<TrenSuperiorPage> {
  final List<String> days = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];

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
    }
  }

  void _sendData() async {
    if (selectedDay != null &&
        selectedExercise != null &&
        selectedReps != null &&
        selectedSeries != null &&
        selectedDescanso != null) {
      print('Datos enviados:');
      print('Día: $selectedDay');
      print('Ejercicio: $selectedExercise');
      print('Repeticiones: $selectedReps');
      print('Series: $selectedSeries');
      print('Descanso: $selectedDescanso');

      await saveTrenSuperiorData({
        'day': selectedDay,
        'exercise': selectedExercise,
        'reps': selectedReps,
        'series': selectedSeries,
        'descanso': selectedDescanso,
      });

      _showNotification('Datos enviados correctamente', Colors.green);
    } else {
      _showNotification('Por favor, selecciona todos los campos', Colors.red);
    }
  }

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
                  image: AssetImage(
                      'assets/fondo.jpg'), // Ruta de la imagen de fondo
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
                    Text('Selecciona un día',
                        style: TextStyle(color: Colors.white, fontSize: 16.0)),
                    _buildDropdown(
                      value: selectedDay,
                      hint: 'Selecciona un día',
                      items: days,
                      onChanged: (day) {
                        setState(() {
                          selectedDay = day;
                        });
                      },
                    ),
                    SizedBox(height: 16.0), // Espacio entre subtítulos
                    Text('Selecciona un ejercicio',
                        style: TextStyle(color: Colors.white, fontSize: 16.0)),
                    _buildDropdown(
                      value: selectedExercise,
                      hint: 'Selecciona un ejercicio',
                      items: ejercicios,
                      onChanged: (exercise) {
                        setState(() {
                          selectedExercise = exercise;
                        });
                      },
                    ),
                    SizedBox(height: 16.0), // Espacio entre subtítulos
                    Text('Selecciona repeticiones',
                        style: TextStyle(color: Colors.white, fontSize: 16.0)),
                    _buildDropdown(
                      value: selectedReps != null ? selectedReps.toString() : null,
                      hint: 'Selecciona repeticiones',
                      items: repeticiones.map((rep) => rep.toString()).toList(),
                      onChanged: (reps) {
                        setState(() {
                          selectedReps = int.tryParse(reps ?? '');
                        });
                      },
                    ),

                    SizedBox(height: 16.0), // Espacio entre subtítulos
                    Text('Selecciona series',
                        style: TextStyle(color: Colors.white, fontSize: 16.0)),
                    _buildDropdown(
                      value: selectedSeries != null ? selectedSeries.toString() : null,
                      hint: 'Selecciona series',
                      items: series.map((s) => s.toString()).toList(),
                      onChanged: (series) {
                        setState(() {
                          selectedSeries = int.tryParse(series ?? '');
                        });
                      },
                    ),

                    SizedBox(height: 16.0), // Espacio entre subtítulos
                    Text('Selecciona descanso',
                        style: TextStyle(color: Colors.white, fontSize: 16.0)),
                    _buildDropdown(
                      value: selectedDescanso,
                      hint: 'Selecciona descanso',
                      items: descansos,
                      onChanged: (descanso) {
                        setState(() {
                          selectedDescanso = descanso;
                        });
                      },
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
    required T? value,
    required String hint,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(      padding: EdgeInsets.symmetric(horizontal: 16.0),
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
            child:
                Text(value.toString(), style: TextStyle(color: Colors.white)),
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

