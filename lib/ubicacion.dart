import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'paginaPrincipal.dart';

class UbicacionPage extends StatefulWidget {
  @override
  _UbicacionPageState createState() => _UbicacionPageState();
}

class _UbicacionPageState extends State<UbicacionPage> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'El servicio de ubicación está deshabilitado.';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PaginaPrincipal()),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PaginaPrincipal()),
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print('Error obteniendo la ubicación: $e');
    }
  }

  Future<void> _launchMap() async {
    final url = 'https://www.google.com/maps/search/?api=1&query=gimnasio';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'No se puede abrir la aplicación de mapas.';
      }
    } catch (e) {
      print('Error al lanzar el mapa: $e');
    }
  }

  Future<void> _launchGymSearch() async {
    final url = 'https://www.google.com/maps/search/?api=1&query=GYM';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'No se puede abrir Google Maps.';
      }
    } catch (e) {
      print('Error al abrir Google Maps: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicación'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            ElevatedButton(
              onPressed: () {
                _launchGymSearch();
              },
              child: Text('Buscar GYM en Google Maps'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _launchMap();
        },
        child: Icon(Icons.location_on),
      ),
    );
  }
}
