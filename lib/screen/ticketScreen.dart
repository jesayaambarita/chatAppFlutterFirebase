import 'package:flutter/material.dart';
import 'package:projek_pertama/auth/login.dart';
import 'package:projek_pertama/helper/SignUpHelper.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Text("Keluar"),
          onTap: () {
            FirebaseAuthHelper.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }),
            );
          },
        ),
      ),
    );
  }
}
