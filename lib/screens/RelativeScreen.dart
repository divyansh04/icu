import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu/models/call.dart';
import 'package:icu/models/user.dart';
import 'package:icu/provider/user_provider.dart';
import 'package:icu/resources/local_db/repository/log_repository.dart';
import 'package:icu/screens/Join_Call_Screen.dart';
import 'package:icu/screens/callscreens/pickup/pickup_layout.dart';
import 'package:icu/utils/call_utilities_relative.dart';
import 'package:icu/utils/permissions.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import 'package:flutter/scheduler.dart';

class RelativeScreen extends StatefulWidget {
  @override
  _RelativeScreenState createState() => _RelativeScreenState();
}

class _RelativeScreenState extends State<RelativeScreen>
    with WidgetsBindingObserver {
  Call call;
  User sender;
  DocumentSnapshot relative;
  bool logout;
  UserProvider userProvider;
  PageController pageController;
  TextEditingController code = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.refreshUser();

      LogRepository.init(
        isHive: true,
        dbName: userProvider.getUser.uid,
      );
      callRelativeDetails();
    });

    WidgetsBinding.instance.addObserver(this);

    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
  Future<DocumentSnapshot> getRelativeDetails() async =>
      await Firestore.instance.collection('users').document(userProvider.getUser.uid).get().then((snaps) {
        return snaps;
      });
  callRelativeDetails()async{
    relative =
    await getRelativeDetails();  }
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
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 2.0,
                        child: MaterialButton(
                          onPressed: () async {
                            await Permissions
                                .cameraAndMicrophonePermissionsGranted()
                                ? {
                              // ignore: unnecessary_statements
                              CallUtilsRelative.dial(
                                relative: relative,
                                context: this.context,
                              )
                            }
                                : {};
                          },
                          minWidth: 200.0,
                          height: 42.0,
                          child: Text(
                            'Make a call',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )),
                 // Padding(
                  //                       padding: EdgeInsets.symmetric(vertical: 16.0),
                  //                       child: Material(
                  //                         color: Colors.white,
                  //                         borderRadius: BorderRadius.circular(30.0),
                  //                         elevation: 2.0,
                  //                         child: MaterialButton(
                  //                           onPressed: () {
                  //                             Navigator.push(context,
                  //                                 MaterialPageRoute(builder: (context) {
                  //                               return JoinCall();
                  //                             }));
                  //                           },
                  //                           minWidth: 200.0,
                  //                           height: 42.0,
                  //                           child: Text(
                  //                             'Join a call',
                  //                             style: TextStyle(color: Colors.black),
                  //                           ),
                  //                         ),
                  //                       )),
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
          msg: 'Log out failed',
          textColor: Colors.black,
          backgroundColor: Colors.white);
      print(e);
    }
  }
}
