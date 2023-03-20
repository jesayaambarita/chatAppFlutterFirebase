import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projek_pertama/auth/login.dart';
import 'package:projek_pertama/helper/SignUpHelper.dart';
import 'package:projek_pertama/helper/database_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String nama = "";
  String email = "";
  String tanggal = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  final current = FirebaseAuth.instance.currentUser!.uid;

  getUsers() async {
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUser()
        .then((snapshot) {
      setState(() {
        nama = snapshot;
      });
    });

    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getEmail()
        .then(
      (val) {
        email = val;
      },
    );
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getTanggal()
        .then(
      (val) {
        tanggal = val;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Profile"),
        actions: <Widget>[
          Icon(
            Icons.edit_outlined,
            color: Colors.white,
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: () {
              FirebaseAuthHelper.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }),
              );
            },
            child: Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 16,
          ),
        ],
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.orange,
                    Colors.orange.shade500,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              top: 0.0,
              right: 0.0,
              left: 0.0,
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  "images/backgroundAppbar.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://img.freepik.com/free-vector/memphis-blue-background-with-halftone-line-elements_1017-33622.jpg?t=st=1678625637~exp=1678626237~hmac=16d54b71a1ae04f41539ca6f2ee69f7714e2842a06aa0b23846c5023bb04126b"),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: CircleAvatar(
                    child: Text(
                      "",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.orange,
                    radius: 40,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      nama,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
