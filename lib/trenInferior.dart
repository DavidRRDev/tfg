import 'package:flutter/material.dart';

class TrenInferiorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tren Inferior'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Text(
          'Contenido del Tren Inferior',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
