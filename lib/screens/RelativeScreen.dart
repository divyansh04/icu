import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icu/constants/UIconstants.dart';
import 'package:icu/enum/user_state.dart';
import 'package:icu/provider/user_provider.dart';
import 'package:icu/resources/auth_methods.dart';
import 'package:icu/resources/local_db/repository/log_repository.dart';
import 'package:icu/screens/callscreens/pickup/pickup_layout.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import 'package:flutter/scheduler.dart';
class RelativeScreen extends StatefulWidget {
  @override
  _RelativeScreenState createState() => _RelativeScreenState();
}

class _RelativeScreenState extends State<RelativeScreen> with WidgetsBindingObserver {
  bool logout;
  UserProvider userProvider;
  PageController pageController;
  final AuthMethods _authMethods = AuthMethods();
  TextEditingController code = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.refreshUser();

      _authMethods.setUserState(
        userId: userProvider.getUser.uid,
        userState: UserState.Online,
      );

      LogRepository.init(
        isHive: true,
        dbName: userProvider.getUser.uid,
      );
    });

    WidgetsBinding.instance.addObserver(this);

    pageController = PageController();
  }
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        body: Form(
          key: _formKey,
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: ListView(children: [
                SizedBox(
                  height: 300.0,
                ),
                Material(
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 0.0,
                  color: Colors.white.withOpacity(0.2),
                  child: TextFormField(
                    cursorColor: Colors.white,
                    controller: code,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "please enter code";
                      }
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter the code here',
                        prefixIcon: Icon(Icons.link, color: Colors.white)),
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
                            //joining process
                          }
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'join',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )),
              ]),
            ),
            Positioned(
              top: 35,
              right: 8,
              child: MaterialButton(
                onPressed: () {
                  logOut();
                },
                child: Text(
                  'Log Out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  logOut() async {
    try {
      await _auth.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    } catch (e) {
      Navigator.pop(context);
      print(e);
    }
  }
}
