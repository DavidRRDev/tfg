import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_share/social_share.dart';

class InvitarAmigoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final enlace = 'https://tu-aplicacion.com'; // Enlace que deseas compartir

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Invitar Amigo',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF5E5EF1)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '¡Invita a tus amigos a usar nuestra aplicación!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _compartirEnlace(enlace);
                },
                child: Text('Invitar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _compartirEnlace(String enlace) {
    SocialShare.shareOptions(enlace).then((data) {
      print('Compartido exitosamente');
    }).catchError((error) {
      print('Error al compartir: $error');
    });
  }
}
