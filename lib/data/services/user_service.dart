// ignore_for_file: invalid_return_type_for_catch_error, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:opaku_app/data/model/user.dart';

class UserService {
  static Future<void> addUser(String username, String email, String password) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users.add({
      'username': username,
      'email': email,
      'password': password,
    }).then((value) async {
      await SessionManager().set("username", username);
      print("User added successfully!");
    }).catchError((error) => print("Failed to add user: $error"));
  }

  static Future loginUser(String username, String password) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users
        .where("username", isEqualTo: username)
        .where("password", isEqualTo: password)
        .get()
        .then((QuerySnapshot snapshot) async {
      snapshot.docs.forEach((doc) {
        User.fromMap(doc.data() as Map<String, dynamic>);
      });
      await SessionManager().set("username", username);
    }).catchError((error) => print("Failed to fetch users: $error"));

    // return users
    //     .add({
    //       'username': username,
    //       'email': email,
    //       'password': password,
    //     })
    //     .then((value) => print("User added successfully!"))
    //     .catchError((error) => print("Failed to add user: $error"));
  }

  static Future<void> fetchUsers() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        print('${doc.id} => ${doc.data()}');
      });
    }).catchError((error) => print("Failed to fetch users: $error"));
  }
}
