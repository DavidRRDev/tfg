import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<Map<String, dynamic>?> getUsuario(String userId) async {
  try {
    DocumentSnapshot docSnapshot = await db.collection('usuarios').doc(userId).get();
    if (docSnapshot.exists) {
      return docSnapshot.data() as Map<String, dynamic>?;
    } else {
      print("El documento del usuario no existe en Firestore.");
    }
  } catch (e) {
    print("Error obteniendo datos del usuario: $e");
  }
  return null;
}

Future<Map<String, dynamic>?> getDatosDeUsuario(String userId) async {
  try {
    DocumentSnapshot docSnapshot = await db.collection('datosDeUsuario').doc(userId).get();
    if (docSnapshot.exists) {
      return docSnapshot.data() as Map<String, dynamic>?;
    } else {
      print("El documento de datosDeUsuario no existe en Firestore.");
    }
  } catch (e) {
    print("Error obteniendo datos de datosDeUsuario: $e");
  }
  return null;
}

Future<void> updateDatosDeUsuario(String userId, Map<String, dynamic> data) async {
  try {
    await db.collection('datosDeUsuario').doc(userId).update(data);
  } catch (e) {
    print("Error actualizando datos de datosDeUsuario: $e");
  }
}