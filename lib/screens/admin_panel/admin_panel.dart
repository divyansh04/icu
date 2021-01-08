import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:icu/screens/login_screen.dart';
import 'package:icu/widgets/CustomAppBar.dart';

import 'package:icu/widgets/standard_custom_button.dart';
import 'package:icu/resources/auth_methods.dart';
import 'package:icu/screens/admin_panel/view_elements.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final AuthMethods _authMethods = AuthMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: Text(
          'Admin Panel',
        ),
        actions: [],
        leading: null,
        showGradient: true,
      ),
      body: Column(children: [
        SizedBox(
          height: 40.0,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ViewElements(
                        role: 'Doctors',
                      )));
            },
            child: Container(
              child: Center(
                child: Text(
                  'Manage Doctors',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
              margin: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Color(0xFF1D1E33),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ViewElements(
                        role: 'Patients',
                      )));
            },
            child: Container(
              child: Center(
                child: Text(
                  'Manage Patients',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
              margin: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Color(0xFF1D1E33),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
      ]),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Container(
          height: 50.0,
          child: StandardCustomButton(
            onTap: () {
              logOut();
            },
            label: 'Log Out',
          ),
        ),
      ),
    );
  }

  logOut() async {
    try {
      await _auth.signOut();
      Fluttertoast.showToast(
          msg: 'Logged out Successfully',
          textColor: Colors.black,
          backgroundColor: Colors.white);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: 'Log out Failed',
          textColor: Colors.black,
          backgroundColor: Colors.white);
      print(e);
    }
  }
}
