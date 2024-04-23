import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Evitar ajuste automático del Scaffold cuando aparece el teclado
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black, // Fondo negro
              Colors.blueAccent, // Franja azul en la parte superior
            ],
            begin: Alignment.topCenter, // El gradiente comienza desde la parte superior central
            end: Alignment.bottomCenter, // El gradiente termina en la parte inferior central
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 60),
                Text(
                  'Introduce tu usuario y contraseña',
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                _buildTextWithInput('Correo electrónico', TextInputType.emailAddress),
                SizedBox(height: 20),
                _buildTextWithInput('Contraseña', TextInputType.visiblePassword),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Aquí puedes manejar la lógica para recuperar la contraseña
                    print('¿Has olvidado la contraseña?');
                  },
                  child: Text(
                    "¿Has olvidado la contraseña?",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para iniciar sesión
                    print('Iniciar sesión');
                  },
                  child: Text('Iniciar', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para registrar usuario
                    print('Registrarse');
                  },
                  child: Text('Registrarse', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Image.asset(
                      'assets/drj.png',
                      fit: BoxFit.contain, // Ajustar la imagen dentro del espacio disponible
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextWithInput(String label, TextInputType keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        TextFormField(
          style: TextStyle(color: Colors.white),
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: 'Ingrese su $label',
            hintStyle: TextStyle(color: Colors.white70),
            fillColor: Colors.white.withOpacity(0.2),
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}
