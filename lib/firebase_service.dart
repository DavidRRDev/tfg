import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<Map<String, dynamic>?> getUsuario(String userId) async {
  try {
    DocumentSnapshot docSnapshot =
        await db.collection('usuarios').doc(userId).get();
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
    DocumentSnapshot docSnapshot =
        await db.collection('datosDeUsuario').doc(userId).get();
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

Future<void> saveTrenSuperiorData(Map<String, dynamic> data) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await db
          .collection('trenSuperior')
          .doc(user.uid)
          .collection('ejercicios')
          .add(data);
    } else {
      print("No se encontró un usuario autenticado.");
    }
  } catch (e) {
    print("Error guardando datos en trenSuperior: $e");
  }
}

Future<List<Map<String, dynamic>>> getTrenSuperiorData() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await db
          .collection('trenSuperior')
          .doc(user.uid)
          .collection('ejercicios')
          .get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } else {
      print("No se encontró un usuario autenticado.");
      return [];
    }
  } catch (e) {
    print("Error obteniendo datos de trenSuperior: $e");
    return [];
  }
}

Future<void> saveTrenInferiorData(Map<String, dynamic> data) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await db
          .collection('trenInferior')
          .doc(user.uid)
          .collection('ejercicios')
          .add(data);
    } else {
      print("No se encontró un usuario autenticado.");
    }
  } catch (e) {
    print("Error guardando datos en trenInferior: $e");
  }
}

Future<List<Map<String, dynamic>>> getTrenInferiorData() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await db
          .collection('trenInferior')
          .doc(user.uid)
          .collection('ejercicios')
          .get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } else {
      print("No se encontró un usuario autenticado.");
      return [];
    }
  } catch (e) {
    print("Error obteniendo datos de trenInferior: $e");
    return [];
  }
}


Future<void> updateDatosDeUsuario(
    String userId, Map<String, dynamic> data) async {
  try {
    await db.collection('datosDeUsuario').doc(userId).update(data);
  } catch (e) {
    print("Error actualizando datos de datosDeUsuario: $e");
  }
}
Future<void> deleteAllTrenSuperiorData() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await db
          .collection('trenSuperior')
          .doc(user.uid)
          .collection('ejercicios')
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } else {
      print("No se encontró un usuario autenticado.");
    }
  } catch (e) {
    print("Error eliminando datos de trenSuperior: $e");
  }
}
Future<void> deleteAllInferiorData() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await db
          .collection('trenInferior')
          .doc(user.uid)
          .collection('ejercicios')
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } else {
      print("No se encontró un usuario autenticado.");
    }
  } catch (e) {
    print("Error eliminando datos de trenSuperior: $e");
  }
}