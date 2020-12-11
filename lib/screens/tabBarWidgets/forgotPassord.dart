import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu/screens/login_screen.dart';
import 'package:icu/constants/UIconstants.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var _formKey = GlobalKey<FormState>();
  bool getSpinner = false;
  TextEditingController _emailTextController = TextEditingController();

  void continueButton() async {
    setState(() {
      getSpinner = true;
    });
    try {
      await _auth.sendPasswordResetEmail(email: _emailTextController.text);

      setState(() {
        getSpinner = false;
      });
      Fluttertoast.showToast(
          msg: 'Email sent to your id successfully',
          textColor: Colors.black,
          backgroundColor: Colors.white);
    } catch (e) {
      print(e);
      setState(() {
        getSpinner = false;
      });
      Fluttertoast.showToast(
          msg: 'Please enter a valid email id ',
          textColor: Colors.black,
          backgroundColor: Colors.white);
    }
  }

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return getSpinner
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 0.0,
                    color: Colors.white.withOpacity(0.2),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        // ignore: missing_return
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "please enter a value";
                          }
                        },
                        controller: _emailTextController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your email',
                            prefixIcon: Icon(Icons.alternate_email,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 2.0,
                        child: MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              continueButton();
                            }
                          },
                          minWidth: 200.0,
                          height: 42.0,
                          child: Text(
                            'Continue',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
