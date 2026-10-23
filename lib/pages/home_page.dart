import 'package:cloud_firestore/cloud_firestore.dart';
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
          ],
        ),
      ),
    );
  }
}
