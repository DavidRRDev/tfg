import 'package:flutter/material.dart';

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
          Image(
            image: AssetImage('assets/fondo.jpg'), // Ruta de tu imagen de fondo
            fit: BoxFit.cover, // Ajusta la imagen para que cubra toda la pantalla
          ),
          Positioned(
            left: 20, // Ajusta la posición izquierda de la imagen
            top: 20, // Ajusta la posición superior de la imagen
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer(); // Abre el cajón lateral al hacer clic en la imagen
              },
              child: Image(
                image: AssetImage('assets/menuRayas.png'), // Ruta de la imagen
                width: 50, // Ancho de la imagen
                height: 50, // Altura de la imagen
              ),
            ),
          ),
           Positioned(
            right: 20, // Ajusta la posición derecha de la imagen
            top: 20, // Ajusta la posición superior de la imagen
            child: Image(
              image: AssetImage('assets/ajusteMenu.png'), // Ruta de la imagen
              width: 50, // Ancho de la imagen
              height: 50, // Altura de la imagen
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImageContainer('assets/pesaInicio.jpg'),
                SizedBox(height: 120),
                _buildImageContainer('assets/comidaInicio.jpg'),
                
                
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Color(0xFF5E5EF1)],
            ),
          ), // Color de fondo del menú
           child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          alignment: Alignment.center, // Centra el contenido del container
          padding: EdgeInsets.fromLTRB(0, 80.0, 0, 50.0),
          child: Text(
            'Menú', // Contenido del encabezado del menú
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 40.0),
          ),
        ),
              _buildListTile('assets/casaMenu.png', 'Inicio'),
              _buildListTile('assets/perfil.png', 'Perfil'),
              _buildListTile('assets/iconoPesa.png', 'Añadir ejercicio'),
              _buildListTile('assets/manzana.png', 'Calcular Kcal'),
              _buildListTile('assets/calendario.png', 'Planificación'),
              _buildListTile('assets/ubicacion.png', 'Ubicación'),
              _buildListTile('assets/amigoMenu.png', 'Invitar Amigo'),
              _buildListTile('assets/cerrarSesion.png', 'Cerrar sesión'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageContainer(String imagePath) {
    return Container(
      width: 350, // Ancho deseado de la imagen
      height: 180, // Altura deseada de la imagen (más larga)
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0), // Radio de borde redondeado
        child: Image(
          image: AssetImage(imagePath),
          fit: BoxFit.cover, // Ajusta la imagen dentro del contenedor
        ),
      ),
    );
  }

  Widget _buildListTile(String leadingImagePath, String title) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Espaciado interno del ListTile
          leading: Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Image.asset(leadingImagePath, width: 60, height: 60), // Imagen a la izquierda
          ),
          title: Text(
            title, // Texto de la opción del menú
            style: TextStyle(color: Colors.white), // Color blanco para el texto
          ),
          onTap: () {
            // Acción al tocar la opción del menú
          },
        ),
       Divider(color: Colors.transparent),// Separador entre elementos de la lista
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PaginaPrincipal(),
  ));
}
