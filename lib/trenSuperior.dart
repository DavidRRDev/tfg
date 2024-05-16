import 'package:flutter/material.dart';

class TrenSuperiorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tren Superior'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Text(
          'Contenido del Tren Superior',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
