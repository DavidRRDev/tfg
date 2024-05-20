import 'package:flutter/material.dart';
import 'perfil.dart';
import 'cerrarSesion.dart';
import 'ejercicios.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fondo de pantalla
          Image(
            image: AssetImage('assets/fondo.jpg'),
            fit: BoxFit.cover,
            width: screenWidth,
            height: screenHeight,
          ),
          // Contenido central
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImageContainerWithIcon('assets/pesaInicio.jpg', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EjerciciosPage()),
                  );
                }, screenHeight, screenWidth),
                SizedBox(height: screenHeight * 0.1),
                _buildImageContainer('assets/calendarioInicio.jpg', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlanificacionPage()),
                  );
                }, screenHeight, screenWidth),
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
                icon: Image.asset('assets/menuRayas.png',
                    height: screenHeight * 0.04),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              actions: [
                IconButton(
                  icon: Image.asset('assets/ajusteMenu.png',
                      height: screenHeight * 0.04),
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
                padding: EdgeInsets.fromLTRB(
                    0, screenHeight * 0.1, 0, screenHeight * 0.05),
                child: Text(
                  'Menú',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: screenHeight * 0.05),
                ),
              ),
              // Opciones del menú
              _buildListTile('assets/casaMenu.png', 'Inicio', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaPrincipal()),
                );
              }, screenHeight),
              _buildListTile('assets/perfil.png', 'Perfil', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PerfilPage()),
                );
              }, screenHeight),
              _buildListTile('assets/iconoPesa.png', 'Añadir ejercicio', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EjerciciosPage()),
                );
              }, screenHeight),
              _buildListTile('assets/calendario.png', 'Planificación', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanificacionPage()),
                );
              }, screenHeight),
              _buildListTile('assets/ubicacion.png', 'Ubicación', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UbicacionPage()),
                );
              }, screenHeight),
              _buildListTile('assets/amigoMenu.png', 'Invitar Amigo', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InvitarAmigoPage()),
                );
              }, screenHeight),
              _buildListTile('assets/cerrarSesion.png', 'Cerrar sesión', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CerrarSesionPage()),
                );
              }, screenHeight),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir un contenedor de imagen con onTap y un icono de "+"
  Widget _buildImageContainerWithIcon(String imagePath, VoidCallback onTap,
      double screenHeight, double screenWidth) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: screenWidth * 0.8,
            height: screenHeight * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth * 0.06),
              color: Colors.white.withOpacity(0.5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.06),
              child: Image(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.02,
            right: screenWidth * 0.02,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: screenHeight * 0.04,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para construir un contenedor de imagen con onTap
  Widget _buildImageContainer(String imagePath, VoidCallback onTap,
      double screenHeight, double screenWidth) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.06),
          color: Colors.white.withOpacity(0.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(screenWidth * 0.06),
          child: Image(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // Método para construir un elemento de ListTile para el menú
  Widget _buildListTile(String leadingImagePath, String title,
      VoidCallback onTap, double screenHeight) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: screenHeight * 0.02), // Reducir el padding horizontal
          leading: Padding(
            padding: EdgeInsets.only(right: screenHeight * 0.02),
            child: Image.asset(
              leadingImagePath,
              width: screenHeight * 0.06, // Ajustar el tamaño de la imagen
              height: screenHeight * 0.06, // Ajustar el tamaño de la imagen
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenHeight * 0.025, // Ajustar el tamaño del texto
            ),
          ),
          onTap: onTap,
        ),
        Divider(color: Colors.transparent),
      ],
    );
  }
}
