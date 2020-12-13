import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'login_screen.dart';

class Empty extends StatefulWidget {
  @override
  _EmptyState createState() => _EmptyState();
}

class _EmptyState extends State<Empty> {
  bool logout;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Scaffold(
          body: Center(
              child: FlatButton(
            child: Text('logOut'),
            onPressed: () {
              logOut();
            },
          )),
        ));
  }

  logOut() async {
    try {
      await _auth.signOut();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }));
    } catch (e) {
      Navigator.pop(context);
      print(e);
    }
  }
}
