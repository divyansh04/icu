import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:icu/enum/user_state.dart';
import 'package:icu/provider/user_provider.dart';
import 'package:icu/resources/auth_methods.dart';
import 'package:icu/resources/local_db/repository/log_repository.dart';
import 'package:icu/screens/callscreens/pickup/pickup_layout_patient.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class PatientScreen extends StatefulWidget {
  @override
  _PatientScreenState createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen>
    with WidgetsBindingObserver {
  bool logout;
  UserProvider userProvider;
  PageController pageController;
  final AuthMethods _authMethods = AuthMethods();
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
    return PickupLayoutPatient(
      scaffold: Scaffold(
        body: Stack(children: [
          Center(
            child: Text(
              "You'll be fine Soon..",
              style: TextStyle(color: Colors.white,fontSize: 26),
            ),
          ),
          Positioned(
            top: 35,
            right: 8,
            child: FlatButton(
              child: Text(
                'logOut',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                logOut();
              },
            ),
          ),
        ]),
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
