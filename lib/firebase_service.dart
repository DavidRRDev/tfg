import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<Map<String, dynamic>?> getUsuario(String userId) async {
  try {
    DocumentSnapshot docSnapshot = await db.collection('usuarios').doc(userId).get();
    if (docSnapshot.exists) {
      return docSnapshot.data() as Map<String, dynamic>?;
    } else {
      print("El documento no existe.");
    }
  } catch (e) {
    print("Error obteniendo datos del usuario: $e");
  }
  return null;
}
