import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu/screens/login_screen.dart';
import 'package:icu/constants/UIconstants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:icu/utils/universal_variables.dart';

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
            backgroundColor: Colors.transparent,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    UniversalVariables.gradientColorStart,
                    UniversalVariables.gradientColorEnd,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    color: UniversalVariables.blackColor.withOpacity(0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/images/i-cu-text.svg',
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          SizedBox(height: 40.0),
                          Material(
                            borderRadius: BorderRadius.circular(10.0),
                            elevation: 0.0,
                            color: UniversalVariables.blackColor,
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
                                    prefixIcon: Icon(
                                      Icons.alternate_email,
                                      color: Colors.white,
                                      size: 15.0,
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Container(
                              height: 50.0,
                              child: RaisedButton(
                                elevation: 2.0,
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    continueButton();
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          UniversalVariables.gradientColorStart,
                                          UniversalVariables.gradientColorEnd
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: Container(
                                    constraints:
                                        BoxConstraints(minHeight: 50.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Continue",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.arrow_back),
                                  Text(
                                    '  return to Log In',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
