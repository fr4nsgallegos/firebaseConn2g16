import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseconn2g16/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StreamPage extends StatelessWidget {
  StreamPage({super.key});

  Stream<int> generarNumeros() async* {
    for (int i = 0; i < 5; i++) {
      await Future.delayed(Duration(seconds: 2));
      yield i;
    }
  }

  Stream<String> generarMensajes() async* {
    yield "Hola";
    await Future.delayed(Duration(seconds: 2));

    yield "Binvenidos";
    await Future.delayed(Duration(seconds: 2));

    yield "Estamos aprendiendo streams";
  }

  // Este tipo de conexión devuelve la info en forma de Map
  final CollectionReference userReference = FirebaseFirestore.instance
      .collection("users");

  // Este tipo de conexción devuelve la info en forma de usermodel
  final userRefTipada = FirebaseFirestore.instance
      .collection("users")
      .withConverter(
        fromFirestore: (snapshot, options) => UserModel.fromFirestore(snapshot),
        toFirestore: (value, options) => value.toMap(),
      );

  Future<void> addUser() async {
    final user = UserModel(
      name: "Juanitpo",
      email: "Juan@gmail,com",
      age: 16,
      gender: "M",
      createdAt: DateTime.now(),
    );

    await userRefTipada.add(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addUser();
        },
      ),
      appBar: AppBar(title: Text("Stream Page")),
      body: Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            ElevatedButton(
              onPressed: () async {
                print("Iiniciando Steam....");
                await for (final numero in generarNumeros()) {
                  print("Número recibido: $numero");
                }
                print("Stream finalizado");
              },
              child: Text("Iniciar stream generarNumeros"),
            ),
            ElevatedButton(
              onPressed: () async {
                generarMensajes().listen(
                  (mensaje) {
                    print("recibido: $mensaje");
                  },
                  onError: (error) {
                    print("Huibo un error: $error");
                  },
                  onDone: () {
                    print("No llegarán más mensajes");
                  },
                );
              },
              child: Text("Iniciar stream generarMensajes"),
            ),

            // TRABAJANDO CON STREAMS Y FIRESTORE
            Expanded(
              child: StreamBuilder(
                stream: userReference.snapshots(),
                builder: (context, snapshot) {
                  final List docs = snapshot.data?.docs ?? [];
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (docs.isEmpty) {
                    return Center(child: Text("No hay usuarios"));
                  } else {
                    final List userList = docs.map((e) => e.data()).toList();

                    return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Trasnformamos la infor porque se tra en forma de map
                        final UserModel u = UserModel.fromMap(userList[index]);

                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(child: Text(u.name[0])),
                            title: Text(u.name),
                            subtitle: Text(
                              "${u.email} / ${u.createdAt.toString().substring(0, 11)}",
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
