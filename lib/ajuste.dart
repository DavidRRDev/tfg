import 'package:flutter/material.dart';
import 'firebase_service.dart';
class AjustesPage extends StatefulWidget {
  @override
  _AjustesPageState createState() => _AjustesPageState();
}

class _AjustesPageState extends State<AjustesPage> {
  bool _notificacionesActivas = true; // Estado inicial del interruptor
  String _idiomaSeleccionado = 'Español'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor: Colors.transparent, // Color de fondo del AppBar
      ),
      
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF5E5EF1)],
          ),
        ),
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
                  _mostrarDialogoIdioma(); // Mostrar diálogo de selección de idioma
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
                  _mostrarDialogoConfirmacion(); // Mostrar diálogo de confirmación para borrar datos
                },
              ),
              Divider(color: Colors.white), // Color del separador en blanco
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarDialogoIdioma() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seleccionar idioma'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Español'),
                onTap: () {
                  setState(() {
                    _idiomaSeleccionado = 'Español';
                  });
                  Navigator.of(context).pop();
                },
                trailing: _idiomaSeleccionado == 'Español'
                    ? Icon(Icons.check, color: Colors.blue)
                    : null,
              ),
              ListTile(
                title: Text('Inglés'),
                onTap: () {
                  setState(() {
                    _idiomaSeleccionado = 'Inglés';
                  });
                  Navigator.of(context).pop();
                },
                trailing: _idiomaSeleccionado == 'Inglés'
                    ? Icon(Icons.check, color: Colors.blue)
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }

    void _mostrarDialogoConfirmacion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación'),
          content: Text('¿Seguro que desea eliminar todos los datos registrados?'),
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
                Navigator.of(context).pop(); // Cerrar el diálogo después de aceptar
                _mostrarMensajeExito(); // Mostrar mensaje de éxito
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
                Navigator.of(context).pop(); // Cerrar el diálogo después de aceptar
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
    home: AjustesPage(),
  ));
}
