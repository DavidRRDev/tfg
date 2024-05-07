import 'package:flutter/material.dart';

class CerrarSesionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fondo de pantalla
          Image(
            image: AssetImage('assets/fondo.jpg'),
            fit: BoxFit.cover,
          ),
          // Contenido centrado
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.exit_to_app,
                  size: 80.0,
                  color: Colors.red,
                ),
                SizedBox(height: 20.0),
                Text(
                  '¿Estás seguro de que deseas cerrar sesión?',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white, // Cambia el color del texto a blanco
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Acción para cerrar sesión
                    // Aquí puedes agregar la lógica para cerrar la sesión actual
                    Navigator.of(context).pop(); // Regresar a la pantalla anterior
                  },
                  child: Text('Cerrar Sesión'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CerrarSesionPage(),
  ));
}
