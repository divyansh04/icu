import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icu/main.dart';
import 'package:flutter/material.dart';
import 'package:icu/constants/UIconstants.dart';
import 'package:icu/resources/auth_methods.dart';
import 'package:icu/screens/tabBarWidgets/forgotPassword.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:icu/widgets/Customised_Progress_Indicator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:icu/widgets/standard_custom_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formKey = GlobalKey<FormState>();
  bool hide = true;
  bool isLoginPressed = false;
  String fcmToken;
  final AuthMethods _authMethods = AuthMethods();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseMessaging messaging = FirebaseMessaging();
  @override
  void initState() {
    messaging.configure(
      onLaunch: (Map<String, dynamic> event) {
        return null;
      },
      onResume: (Map<String, dynamic> event) {
        return null;
      },
      onMessage: (Map<String, dynamic> event) {
        return null;
      },
    );
    messaging.getToken().then((value) => {
          setState(() {
            fcmToken = value.toString();
          }),
          print(value)
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          SystemNavigator.pop();
        },
        child: ModalProgressHUD(
          progressIndicator: CustomisedProgressIndicator(),
          inAsyncCall: isLoginPressed,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    kGradientColorStart,
                    kGradientColorEnd
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    color: kBlackColor.withOpacity(0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Form(
                      key: _formKey,
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/images/icu-logo.svg',
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),

                            SvgPicture.asset(
                              'assets/images/i-cu-text.svg',
                              // width: MediaQuery.of(context).size.width * 0.5,
                            ),
                            // Text(
                            //   'Sign In',
                            //   style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 60,
                            //       fontWeight: FontWeight.w700),
                            //   textAlign: TextAlign.center,
                            // ),
                            SizedBox(
                              height: 45.0,
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(10.0),
                              elevation: 0.0,
                              color: kBlackColor,
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
                                    prefixIcon: Icon(
                                      Icons.alternate_email,
                                      color: Colors.white,
                                      size: 15.0,
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(10.0),
                              elevation: 0.0,
                              color: kBlackColor,
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
                                    size: 15.0,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      !hide
                                          ? Icons.remove_red_eye_outlined
                                          : Icons.remove_red_eye,
                                      color: Colors.white,
                                      size: 15.0,
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
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ForgotPassword();
                                  }));
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
                                child: Container(
                                  height:50.0,
                                  child: StandardCustomButton(
                                    onTap: () async {
                                      if (_formKey.currentState.validate()) {
                                        performLogin();
                                      }
                                    },
                                    label: "Sign in",
                                  ),
                                )

                                ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
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
        _authMethods.addDataToDb(user, fcmToken).then((value) {
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
