import 'package:flutter/material.dart';

class AjustesPage extends StatefulWidget {
  @override
  _AjustesPageState createState() => _AjustesPageState();
}

class _AjustesPageState extends State<AjustesPage> {
  bool _notificacionesActivas = true; // Estado inicial del interruptor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
      ),
      body: Container(
        color: Colors.indigoAccent, // Color de fondo morado-azul
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Configuración de la aplicación',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Color del texto en blanco
                ),
              ),
              SizedBox(height: 20.0),
              ListTile(
                title: Text(
                  'Notificaciones',
                  style: TextStyle(color: Colors.white), // Color del texto en blanco
                ),
                subtitle: Text(
                  'Activar/desactivar notificaciones',
                  style: TextStyle(color: Colors.white70), // Color del texto en blanco (más claro)
                ),
                trailing: Switch(
                  value: _notificacionesActivas,
                  onChanged: (value) {
                    setState(() {
                      _notificacionesActivas = value; // Actualiza el estado del interruptor
                    });
                  },
                ),
              ),
              Divider(color: Colors.white), // Color del separador en blanco
              ListTile(
                title: Text(
                  'Idioma',
                  style: TextStyle(color: Colors.white), // Color del texto en blanco
                ),
                subtitle: Text(
                  'Seleccionar idioma de la aplicación',
                  style: TextStyle(color: Colors.white70), // Color del texto en blanco (más claro)
                ),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white), // Color del icono en blanco
                onTap: () {
                  // Acción al tocar la opción de idioma
                  // Por ejemplo, abrir una pantalla de selección de idioma
                },
              ),
              Divider(color: Colors.white), // Color del separador en blanco
              ListTile(
                title: Text(
                  'Tema',
                  style: TextStyle(color: Colors.white), // Color del texto en blanco
                ),
                subtitle: Text(
                  'Seleccionar tema de la aplicación',
                  style: TextStyle(color: Colors.white70), // Color del texto en blanco (más claro)
                ),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white), // Color del icono en blanco
                onTap: () {
                  // Acción al tocar la opción de tema
                  // Por ejemplo, abrir una pantalla de selección de tema
                },
              ),
              Divider(color: Colors.white), // Color del separador en blanco
              ListTile(
                title: Text(
                  'Borrar datos',
                  style: TextStyle(color: Colors.white), // Color del texto en blanco
                ),
                subtitle: Text(
                  'Eliminar todos los datos de la aplicación',
                  style: TextStyle(color: Colors.white70), // Color del texto en blanco (más claro)
                ),
                onTap: () {
                  // Acción al tocar la opción de borrar datos
                  // Por ejemplo, mostrar un diálogo de confirmación
                },
              ),
              Divider(color: Colors.white), // Color del separador en blanco
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AjustesPage(),
  ));
}
