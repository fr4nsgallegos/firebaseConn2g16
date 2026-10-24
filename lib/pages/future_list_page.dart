import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseconn2g16/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FutureListPage extends StatelessWidget {
  FutureListPage({super.key});

  CollectionReference userReference = FirebaseFirestore.instance.collection(
    "users",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Future List Page")),
      body: Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            FutureBuilder(
              future: userReference.get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                QuerySnapshot querySnapshot = snapshot.data;
                List<QueryDocumentSnapshot> docs = querySnapshot.docs;
                List<UserModel> userModelList = docs.map((e) {
                  return UserModel.fromMap(e.data() as Map<String, dynamic>);
                }).toList();

                return Expanded(
                  child: ListView.builder(
                    itemCount: userModelList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Text(userModelList[index].name),
                          subtitle: Text(userModelList[index].email),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
