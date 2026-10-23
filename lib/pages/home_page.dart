import 'package:cloud_firestore/cloud_firestore.dart';
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
                  docs.forEach((element) => print(element.data()));
                });
              },
              child: Text("Get data"),
            ),
          ],
        ),
      ),
    );
  }
}
