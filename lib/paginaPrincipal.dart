import 'package:flutter/material.dart';
import 'perfil.dart';
import 'cerrarSesion.dart';
import 'ejercicios.dart'; // Importa la página de Ejercicios
import 'invitarAmigo.dart';
import 'ubicacion.dart';
import 'planificacion.dart';
import 'ajuste.dart';
class PaginaPrincipal extends StatefulWidget {
  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fondo de pantalla
          Image(
            image: AssetImage('assets/fondo.jpg'),
            fit: BoxFit.cover,
          ),
          // Contenido central
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImageContainer('assets/pesaInicio.jpg', () {
                  // Navegar a EjerciciosPage al tocar la imagen de pesaInicio
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EjerciciosPage()),
                  );
                }),
                SizedBox(height: 120),
                _buildImageContainer('assets/calendarioInicio.jpg', () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlanificacionPage()),
                  );
                }),
              ],
            ),
          ),
          // AppBar personalizada
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Image.asset('assets/menuRayas.png'),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              actions: [
                IconButton(
                  icon: Image.asset('assets/ajusteMenu.png'),
                  onPressed: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AjustesPage()),
                );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      // Drawer (menú lateral)
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Color(0xFF5E5EF1)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Encabezado del menú
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 80.0, 0, 50.0),
                child: Text(
                  'Menú',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 40.0),
                ),
              ),
              // Opciones del menú
              _buildListTile('assets/casaMenu.png', 'Inicio', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaPrincipal()),
                );
              }),
              _buildListTile('assets/perfil.png', 'Perfil', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PerfilPage()),
                );
              }),
              _buildListTile('assets/iconoPesa.png', 'Añadir ejercicio', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EjerciciosPage()),
                );
              }),
              _buildListTile('assets/calendario.png', 'Planificación', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanificacionPage()),
                );
              }),
              _buildListTile('assets/ubicacion.png', 'Ubicación', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UbicacionPage()),
                );
              }),
              _buildListTile('assets/amigoMenu.png', 'Invitar Amigo', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InvitarAmigoPage()),
                );
              }),
              _buildListTile('assets/cerrarSesion.png', 'Cerrar sesión', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CerrarSesionPage()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir un contenedor de imagen con onTap
  Widget _buildImageContainer(String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // Llama a la función onTap cuando se toca la imagen
      child: Container(
        width: 350,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white.withOpacity(0.5), // Color de fondo con opacidad
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Image(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // Método para construir un elemento de ListTile para el menú
  Widget _buildListTile(String leadingImagePath, String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          leading: Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Image.asset(leadingImagePath, width: 60, height: 60),
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          onTap: onTap, // Ejecutar la acción al tocar el ListTile
        ),
        Divider(color: Colors.transparent), // Separador entre elementos de la lista
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PaginaPrincipal(),
  ));
}
