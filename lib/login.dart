import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Column(
          children: <Widget>[
            SizedBox(height: 90),
            Text('Introduce  tu usuario  y contraseña',
                style: TextStyle(color: Colors.white,fontSize: 30),),
            SizedBox(height: 20),
            Text('Correo electroinico',
                style: TextStyle(color: Colors.white),),
            SizedBox(height: 20),
            TextFormField(),
            Text('Contraseña',
                style: TextStyle(color: Colors.white),),
            SizedBox(height: 20),
            TextField(),
            SizedBox(height: 20),
            Text("¿te has olvidado la contraseña?",
                style: TextStyle(color: Colors.white),),
            SizedBox(height: 20),
            Button(),
            Image.asset('assets/drj.png',height: 300,),
            SizedBox(height: 20),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black, // Black background
              Colors.blueAccent, // Blue stripe at the top
            ],
            begin: Alignment.topCenter, // Gradient starts from the top center
            end: Alignment.bottomCenter, // Gradient ends at the bottom center
          ),
        ),
      ),
    );
  }
}