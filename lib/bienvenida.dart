import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario de Registro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Bienvenida(),
    );
  }
}

class Bienvenida extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF000000), Color(0xFF1414B8)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Bienvenid@',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Edad',
                            labelStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Peso (kg)',
                            labelStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Altura (cm)',
                            labelStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Sexo',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: false,
                              onChanged: (bool? value) {},
                            ),
                            Text('Masculino', style: TextStyle(color: Colors.black)),
                            Checkbox(
                              value: false,
                              onChanged: (bool? value) {},
                            ),
                            Text('Femenino', style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Aquí puedes agregar la lógica para enviar los datos
                    // a tu backend una vez que se presiona el botón
                  },
                  child: Text('Confirmar'),
                ),
                SizedBox(height: 10),
                Image.asset(
                  'assets/drj.png',
                  height: 300,
                  width: 300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}