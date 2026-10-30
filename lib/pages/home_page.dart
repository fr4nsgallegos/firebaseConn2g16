import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseconn2g16/pages/future_list_page.dart';
import 'package:firebaseconn2g16/pages/maps/maps1_page.dart';
import 'package:firebaseconn2g16/pages/maps/maps2_page.dart';
import 'package:firebaseconn2g16/pages/streams/stream_page.dart';
import 'package:firebaseconn2g16/user_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  CollectionReference userReference = FirebaseFirestore.instance.collection(
    "users",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Conexión automática a firebase")),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Consulta de todos los documentos
                await userReference.get().then((value) {
                  List<QueryDocumentSnapshot> docs = value.docs;
                  // docs.forEach((element) => print(element.data()));

                  List<UserModel> userModelList = docs.map((e) {
                    return UserModel.fromMap(e.data() as Map<String, dynamic>);
                  }).toList();

                  userModelList.forEach((usermodel) {
                    print("******************");
                    print(usermodel.name);
                    print(usermodel.createdAt);
                    print(usermodel.email);
                  });
                });
                print("-------------------------");

                // Consulta de documento en específico
                await userReference.doc("V2T4Zk1Uj1EUvomZReEn").get().then((
                  value,
                ) {
                  print(value.data());
                });
              },
              child: Text("Get data"),
            ),

            ElevatedButton(
              onPressed: () async {
                userReference
                    .where("age", isLessThan: 26)
                    .where("gender", isEqualTo: "F")
                    .get()
                    .then((value) {
                      List<QueryDocumentSnapshot> docs = value.docs;
                      List<UserModel> userModelList = docs.map((e) {
                        return UserModel.fromMap(
                          e.data() as Map<String, dynamic>,
                        );
                      }).toList();

                      userModelList.forEach((usuario) {
                        print("**********************************");
                        print(usuario.name);
                        print(usuario.email);
                        print(usuario.age);
                        print(usuario.gender);
                        print(usuario.createdAt);
                      });
                    });
              },
              child: Text("Obtener data filtrada"),
            ),
            ElevatedButton(
              onPressed: () {
                // Agregar usuario desde map
                // userReference
                //     .add({
                //       "name": "Lucas",
                //       "email": "mlus@gmaiolñ.com",
                //       "gender": "M",
                //       "age": 80,
                //       "createdAt": Timestamp.now(),
                //     })
                //     .then((value) {
                //       print("Usuario agregado correctamnte");
                //       print(value);
                //       print(value.id);
                //     })
                //     .catchError((error) {
                //       print("Error al agregar el usuario: $error");
                //     });

                // Agregar usuarios desde un modelo
                UserModel newUser = UserModel(
                  name: "mARIA",
                  email: "cMARITA@gmail.com",
                  age: 18,
                  gender: "F",
                  createdAt: DateTime.now(),
                );

                userReference
                    .add(newUser.toMap())
                    .then((value) {
                      print("Usuario agregado correctamnte");
                      print(value);
                      print(value.id);
                    })
                    .catchError((error) {
                      print("Error al agregar el usuario: $error");
                    });
                ;
              },
              child: Text("Agregar un usuario"),
            ),

            ElevatedButton(
              onPressed: () {
                UserModel newUser = UserModel(
                  name: "MELISA",
                  email: "lLOSA",
                  age: 23,
                  gender: "F",
                  createdAt: DateTime.now(),
                );
                userReference
                    .doc("uid0000010")
                    .set(newUser.toMap())
                    .then((value) {
                      print("Ususuario agregado con el id específico");
                    })
                    .catchError((error) {
                      print(error);
                    });
              },
              child: Text("Agregar usuario co id en específico"),
            ),

            ElevatedButton(
              onPressed: () {
                userReference
                    .doc("uid0000010")
                    .update({"email": "peruananito@gmail.com"})
                    .then((value) {
                      print("Actualizacion de usuario realizada");
                    })
                    .catchError((error) {
                      print("Error al agrea usuario $error");
                    });
              },
              child: Text("Actualizar usuario"),
            ),
            ElevatedButton(
              onPressed: () {
                userReference
                    .doc("uid0000010")
                    .set({"email": "peruananito@gmail.com"})
                    .then((value) {
                      print("Actualizacion de usuario realizada");
                    })
                    .catchError((error) {
                      print("Error al agrea usuario $error");
                    });
              },
              child: Text("Actualizar usuario chancando info"),
            ),
            ElevatedButton(
              onPressed: () {
                userReference
                    .doc("uid0000010")
                    .delete()
                    .then((value) {
                      print("Elminación de usuario realizada");
                    })
                    .catchError((error) {
                      print("Error al eliminar usuario $error");
                    });
              },
              child: Text("Eliminar un usuario"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StreamPage()),
                );
              },
              child: Text("Stream Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FutureListPage()),
                );
              },
              child: Text("Future list  Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Maps1Page()),
                );
              },
              child: Text("Maps 1"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Maps2Page()),
                );
              },
              child: Text("Maps 2"),
            ),
          ],
        ),
      ),
    );
  }
}
