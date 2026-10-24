import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  String? id;
  String name;
  String email;
  int age;
  String gender;
  DateTime createdAt;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "age": age,
      "gender": gender,
      "createdAt": Timestamp.fromDate(
        createdAt,
      ), //hacemos esta tranformación para que firestore lo reconozca como fecha
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    Timestamp timeFiretore = map["createdAt"] ?? Timestamp.now();

    return UserModel(
      name: map["name"],
      email: map["email"],
      age: map["age"],
      gender: map["gender"],
      createdAt: timeFiretore.toDate(),
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    String id = doc.id;

    return UserModel(
      id: id,
      name: (data["name"] ?? "") as String,
      email: (data["email"] ?? "") as String,
      age: (data["age"] ?? "") as int,
      gender: (data["gender"] ?? "") as String,
      createdAt: (data["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
