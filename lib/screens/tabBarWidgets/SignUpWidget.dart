import 'package:flutter/material.dart';
import 'package:icu/constants/UIconstants.dart';
import 'package:icu/main.dart';
import 'package:icu/resources/auth_methods.dart';
import 'package:icu/screens/home_screen.dart';
import 'package:icu/utils/universal_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  var _formKey = GlobalKey<FormState>();
  final AuthMethods _authMethods = AuthMethods();
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  Map value;
  bool isSignUpPressed = false;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return isSignUpPressed
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: UniversalVariables.blackColor,
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 80,
                        ),
                        Text(
                          'Sign up',
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
                            controller: name,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
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
                                hintText: 'Enter username',
                                prefixIcon:
                                    Icon(Icons.person, color: Colors.white)),
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
                            controller: password,
                            textAlign: TextAlign.center,
                            obscureText: hidePassword,
                            // ignore: missing_return, non_constant_identifier_names
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "please enter a value";
                              } else if (value.length < 6) {
                                return 'password must be of atleast 6 characters';
                              }
                            },
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'set password',
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.white,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  !hidePassword
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.remove_red_eye,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                              ),
                            ),
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
                            controller: _confirmPasswordTextController,
                            textAlign: TextAlign.center,
                            obscureText: hideConfirmPassword,
                            // ignore: missing_return
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "please enter a value";
                              } else if (password.text != value) {
                                return "the passwords doesn't match ";
                              }
                            },
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Confirm password',
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.white,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  !hideConfirmPassword
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.remove_red_eye,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    hideConfirmPassword = !hideConfirmPassword;
                                  });
                                },
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
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    performSignUp();
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }

  void performSignUp() async {
    setState(() {
      isSignUpPressed = true;
    });

    FirebaseUser user = await _authMethods.signUp(email, password);

    if (user != null) {
      authenticateUser(user);
    }
    setState(() {
      isSignUpPressed = false;
    });
  }

  void authenticateUser(FirebaseUser user) {
    _authMethods.authenticateUser(user).then((isNewUser) {
      setState(() {
        isSignUpPressed = false;
      });

      if (isNewUser) {
        _authMethods.addDataToDataBase(user, name.text).then((value) {
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
