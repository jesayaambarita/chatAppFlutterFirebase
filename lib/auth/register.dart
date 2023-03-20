import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:projek_pertama/helper/helper_function.dart';
import 'package:projek_pertama/provider/constant.dart';
import 'package:projek_pertama/provider/constant.dart';
import 'package:projek_pertama/screen/btm.dart';

import '../helper/SignUpHelper.dart';
import '../screen/homeScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _date = TextEditingController();
  TextEditingController _nama = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://img.okezone.com/content/2020/10/05/408/2288632/menikmati-keindahan-danau-toba-dari-3-bukit-ini-sangat-menakjubkan-FyS99UvKQf.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Registrasi",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your nama';
                          }
                          return null;
                        },
                        controller: _nama,
                        onChanged: (nama) {},
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.person_2_outlined,
                            color: Colors.white,
                          ),
                          labelText: "Nama",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your tanggal';
                          }
                          return null;
                        },
                        controller: _date,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          prefixIcon: Icon(
                            Icons.date_range_outlined,
                            color: Colors.white,
                          ),
                          labelText: "Tanggal Lahir",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1000),
                            lastDate: DateTime(2045),
                          );
                          if (picked != null) {
                            _date.text = picked.toString().substring(0, 10);
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => PilihKursi()),
                          // );
                          if (_formKey.currentState!.validate()) {
                            final String email = _email.text.trim();
                            final String password = _password.text.trim();
                            final String nama = _nama.text.trim();
                            final String tanggal = _date.text.trim();

                            setState(() {
                              _isLoading = true;
                            });

                            await FirebaseAuthHelper.signUp(
                                    nama, tanggal, email, password)
                                .then((value) async {
                              nextScreen(context, BottomBar());
                              if (value == true) {
                                nextScreen(context, BottomBar());
                              } else {
                                // showSnackbar(context, Colors.red, value);
                                setState(() => {_isLoading = false});
                              }
                            });

                            // User? user =
                            //     await FirebaseAuthHelper.registerUsingEmailPassword(
                            //         name: _nama.text,
                            //         tanggal: _date.text,
                            //         email: _email.text,
                            //         password: _password.text);
                            // if (user != null) {
                            //   Navigator.of(context).pushAndRemoveUntil(
                            //     MaterialPageRoute(
                            //       builder: (context) => HomeScreen(),
                            //     ),
                            //     ModalRoute.withName('/'),
                            //   );
                            // }
                          }
                          ;
                        },
                        child: Container(
                          height: 48,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Daftar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
