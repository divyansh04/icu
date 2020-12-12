import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu/main.dart';
import 'package:icu/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:icu/constants/UIconstants.dart';
import 'package:icu/resources/auth_methods.dart';
import 'package:icu/utils/universal_variables.dart';
import 'package:icu/utils/popUp.dart';

class LogInWidget extends StatefulWidget {
  @override
  _LogInWidgetState createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  var _formKey = GlobalKey<FormState>();
  bool hide = true;
  bool forgotPassword = false;
  bool isLoginPressed = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthMethods _authMethods = AuthMethods();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return isLoginPressed
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: UniversalVariables.blackColor,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  !forgotPassword
                      ? Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Sign In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 60,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 48.0,
                              ),
                              Material(
                                borderRadius: BorderRadius.circular(10.0),
                                elevation: 0.0,
                                color: Colors.white.withOpacity(0.2),
                                child: TextFormField(
                                  cursorColor: Colors.white,
                                  controller: email,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.emailAddress,
                                  // ignore: missing_return
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "please enter a value";
                                    }
                                  },
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: kTextFieldDecoration.copyWith(
                                      hintText: 'Enter your email',
                                      prefixIcon: Icon(Icons.alternate_email,
                                          color: Colors.white)),
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Material(
                                borderRadius: BorderRadius.circular(10.0),
                                elevation: 0.0,
                                color: Colors.white.withOpacity(0.2),
                                child: TextFormField(
                                  cursorColor: Colors.white,
                                  controller: password,
                                  textAlign: TextAlign.center,
                                  obscureText: hide,
                                  // ignore: missing_return
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "The password field cannot be empty";
                                    }
                                  },
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Enter your password',
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.white,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        !hide
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.remove_red_eye,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          hide = !hide;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, right: 8, bottom: 8),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      forgotPassword = true;
                                    });
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 18.0,
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
                                          performLogin();
                                        }
                                      },
                                      minWidth: 200.0,
                                      height: 42.0,
                                      child: Text(
                                        'Sign In',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '-OR-',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'sign in with',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                ),
                              ),
                              googleSignInButton(),
                            ],
                          ))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
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
                                  controller: email,
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
                            SizedBox(
                              height: 18.0,
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
                                        ForgotPassword();
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, right: 8, bottom: 8),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      forgotPassword = false;
                                    });
                                  },
                                  child: Text(
                                    'Sign In',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ));
  }

  // ignore: non_constant_identifier_names
  void ForgotPassword() async {
    setState(() {
      isLoginPressed = true;
    });
    try {
      await _auth.sendPasswordResetEmail(email: email.text);
      setState(() {
        isLoginPressed = false;
      });
      Fluttertoast.showToast(
          msg: 'email sent successfully!!',
          textColor: Colors.black,
          backgroundColor: Colors.white);
      showSuccessDialog(context, "email Sent",
          'An email has been sent to your registered email id for resetting password',
          () {
        setState(() {
          forgotPassword = false;
        });
        Navigator.pop(context);
      });
    } catch (e) {
      setState(() {
        isLoginPressed = false;
      });
      Fluttertoast.showToast(
          msg: 'Please provide correct email',
          textColor: Colors.black,
          backgroundColor: Colors.white);
      print(e);
    }
  }

  Widget googleSignInButton() {
    return GestureDetector(
      onTap: () {
        performGoogleLogin();
      },
      child: Center(
        child: CircleAvatar(
          radius: 35.0,
          backgroundImage: AssetImage("assets/google.png"),
        ),
      ),
    );
  }

  void performGoogleLogin() async {
    setState(() {
      isLoginPressed = true;
    });

    FirebaseUser user = await _authMethods.signInWithGoogle();

    if (user != null) {
      authenticateUser(user);
    }
    setState(() {
      isLoginPressed = false;
    });
  }

  void performLogin() async {
    setState(() {
      isLoginPressed = true;
    });

    FirebaseUser user = await _authMethods.signIn(email, password);

    if (user != null) {
      authenticateUser(user);
    }
    setState(() {
      isLoginPressed = false;
    });
  }

  void authenticateUser(FirebaseUser user) {
    _authMethods.authenticateUser(user).then((isNewUser) {
      setState(() {
        isLoginPressed = false;
      });

      if (isNewUser) {
        _authMethods.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeWidget();
          }));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeWidget();
        }));
      }
    });
  }
}
