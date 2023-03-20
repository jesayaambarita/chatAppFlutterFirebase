import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projek_pertama/auth/register.dart';
import 'package:projek_pertama/helper/SignUpHelper.dart';
import 'package:projek_pertama/helper/helper_function.dart';
import 'package:projek_pertama/screen/btm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
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
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Login",
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
                      controller: _email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
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
                      onTap: () {
                        loginUser(
                            context, _email.text.trim(), _password.text.trim());
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => PilihKursi()),
                        // );
                        checkUserLoggedIn(context);
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
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                        child: Text(
                          "Belum Punya Akun? Daftar",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // Memeriksa apakah pengguna sudah login atau belum saat aplikasi dimuat kembali
  void checkUserLoggedIn(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    prefs.getString('nama');

    if (isLoggedIn == true) {
      // Langsung navigasikan pengguna ke halaman utama jika sudah login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return BottomBar();
        }),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }),
      );
    }
  }

  void loginUser(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      checkUserLoggedIn(context);
      User? user = userCredential.user;
      setState(() {
        _isLoading = true;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return BottomBar();
        }),
      );
      QuerySnapshot snapshot = await FirebaseAuthHelper.gettingUserData(email);
      await HelperFunction.saveUserLoggedInStatus(true);

      await HelperFunction.saveUserEmailSF(email);
      await HelperFunction.saveUserNameSF(snapshot.docs[0]['nama']);
      // if (user != null) {
      //   // Navigasikan pengguna ke halaman utama
      //   QuerySnapshot snapshot =
      //       await FirebaseAuthHelper.gettingUserData(email);
      //   await HelperFunction.saveUserLoggedInStatus(true);

      //   await HelperFunction.saveUserEmailSF(email);
      //   await HelperFunction.saveUserNameSF(snapshot.docs[0]['nama']);
      // }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
