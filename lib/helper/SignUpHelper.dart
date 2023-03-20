import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projek_pertama/helper/helper_function.dart';
import 'package:projek_pertama/screen/btm.dart';
import 'package:projek_pertama/screen/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthHelper {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference chattingCollection =
      FirebaseFirestore.instance.collection("messages");
  String? uid;
  // static Future<User?> registerUsingEmailPassword({
  //   required String name,
  //   required String tanggal,
  //   required String email,
  //   required String password,
  // }) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   FirebaseFirestore _db = FirebaseFirestore.instance;
  //   User? user;

  //   try {
  //     UserCredential userCredential = await auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     // Save user data to Firestore
  //     // await _db.collection('users').doc(userCredential.user!.uid).set({
  //     //   'email': email,
  //     //   'tanggal': tanggal,
  //     //   'nama': name,
  //     //   'createdAt': FieldValue.serverTimestamp(),
  //     // });
  //     user = userCredential.user;
  //     user = auth.currentUser;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }

  //   return user;
  // }

  static navigateToHome(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return BottomBar();
    }));
  }

  // Menyimpan status login pengguna ke dalam SharedPreferences
  static void saveUserLoggedInStatus(bool isLoggedIn, String nama) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setString('nama', nama);
  }

  static Future<User?> signUp(
      String nama, String tanggal, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;

      if (user != null) {
        await _db.collection('users').doc(result.user!.uid).set({
          'email': email,
          'tanggal': tanggal,
          'nama': nama,
          'profilePic': '',
          'chats': [],
          'createdAt': FieldValue.serverTimestamp(),
          'uid': result.user!.uid,
        });
        await HelperFunction.saveUserLoggedInStatus(true);
        await HelperFunction.saveUserNameSF(nama);
        await HelperFunction.saveUserEmailSF(email);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }

    // static Future<User?> signInUsingEmailPassword({
    //   required String email,
    //   required String password,
    // }) async {
    //   FirebaseAuth auth = FirebaseAuth.instance;
    //   User? user;

    //   try {
    //     UserCredential userCredential = await auth.signInWithEmailAndPassword(
    //       email: email,
    //       password: password,
    //     );
    //     user = userCredential.user;
    //   } on FirebaseAuthException catch (e) {
    //     if (e.code == 'user-not-found') {
    //       print('No user found for that email.');
    //     } else if (e.code == 'wrong-password') {
    //       print('Wrong password provided.');
    //     }
    //   }

    //   return user;
    // }
  }

  getUserChat() async {
    return chattingCollection.doc(_auth.currentUser!.uid).snapshots();
  }

  static Future signOut() async {
    try {
      await HelperFunction.saveUserLoggedInStatus(false);
      await HelperFunction.saveUserNameSF("");
      await HelperFunction.saveUserEmailSF("");
      await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  static Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await _db.collection('users').where('email', isEqualTo: email).get();
    return snapshot;
  }
}
