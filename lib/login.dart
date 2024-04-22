import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Column(
          children: <Widget>[
            Text('Introduce  tu usuario  y contraseña'),
            Text('Correo electroinico'),
            TextField(),
            Text('Contraseña'),
            TextField(),
          ],
        )


      ),
    );
  }
}