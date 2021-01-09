import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu/models/call.dart';
import 'package:icu/models/user.dart';
import 'package:icu/resources/auth_methods.dart';
import 'package:icu/screens/callscreens/call_screen.dart';
import 'package:icu/screens/login_screen.dart';
import 'package:icu/utils/call_utilities.dart';
import 'package:icu/utils/permissions.dart';
import 'package:icu/utils/universal_variables.dart';
import 'package:icu/widgets/CustomAppBar.dart';
import 'package:icu/widgets/Customised_Progress_Indicator.dart';
import 'package:icu/widgets/custom_tile.dart';
import 'package:icu/resources/call_methods.dart';

class DoctorScreen extends StatefulWidget {
  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final AuthMethods _authMethods = AuthMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User sender;
  bool loading = false;
  List<User> userList = null;
  String query = "";
  Stream snapshot = null;
  FirebaseUser currentUser;
  CallMethods callMethods = CallMethods();
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    getUsersList();
    super.initState();
  }

  getUsersList() async {
    setState(() {
      loading = true;
    });
    try {
      await _authMethods.getUserDetails().then(
          (value) => _authMethods.getCurrentUser().then((FirebaseUser user) {
                setState(() {
                  currentUser = user;
                });
                _authMethods.fetchPatients(user).then((List<User> list) {
                  setState(() {
                    userList = list;
                    sender = User(
                      uid: user.uid.toString(),
                      name: value.name,
                    );
                    userList.toList().sort((a, b) => a.name.compareTo(b.name));
                  });
                });
              }));
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: 'please check internet connection!!',
          backgroundColor: Colors.black,
          textColor: Colors.white);
      setState(() {
        loading = false;
      });
    }
  }

  joinCall(Call call) async {
    int users = call.users.toInt() + 1;
    await callMethods.joinCall(call: call, user: users);
    Navigator.pop(context);
    await Permissions.cameraAndMicrophonePermissionsGranted()
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CallScreen(call: call),
            ))
        : {};
  }

  makeCall(User searchedUser) async {
    Navigator.pop(context);
    await CallUtils.dial(
      from: sender,
      to: searchedUser,
      context: this.context,
    );
  }

  runCall(User searchedUser) async {
    DocumentSnapshot doctorSnapshot = await Firestore.instance
        .collection('call')
        .document(currentUser.uid)
        .get();
    DocumentSnapshot patientSnapshot = await Firestore.instance
        .collection('call')
        .document(searchedUser.uid)
        .get();
    if (doctorSnapshot.data != null) {
      Call call = Call.fromMap(doctorSnapshot.data);
      if (call.patientId == searchedUser.uid) {
        joinCall(call);
      } else {
        if (patientSnapshot.data != null) {
          Call call1 = Call.fromMap(patientSnapshot.data);
          await Firestore.instance
              .collection('call')
              .document(currentUser.uid)
              .updateData({
            'channel_id': call1.channelId,
            'patient_id': call1.patientId,
            'patient_name': call1.patientName,
            'relative_id': call1.relativeId,
            'relative_name': call1.relativeName
          });
          DocumentSnapshot doctorSnapshot = await Firestore.instance
              .collection('call')
              .document(currentUser.uid)
              .get();
          setState(() {
            Call call3 = Call.fromMap(doctorSnapshot.data);
            joinCall(call3);
          });
        } else {
          makeCall(searchedUser);
        }
      }
    } else {
      if (patientSnapshot.data != null) {
        Call call1 = Call.fromMap(patientSnapshot.data);
        DocumentSnapshot relativeSnapshot = await Firestore.instance
            .collection('call')
            .document(call1.relativeId)
            .get();
        Call call2 = Call.fromMap(relativeSnapshot.data);
        if (call2.hasDialled == true) {
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: '${searchedUser.name} is on another call');
        } else {
          Call call = Call(
            doctorId: currentUser.uid,
            doctorName: call1.doctorName,
            patientId: call1.patientId,
            patientName: call1.patientName,
            relativeId: call1.relativeId,
            relativeName: call1.relativeName,
            users: 1,
            channelId: call1.channelId,
          );
          call.hasDialled = true;
          Map<String, dynamic> hasDialledMap = call.toMap(call);
          await Firestore.instance
              .collection('call')
              .document(call.doctorId)
              .setData(hasDialledMap);
          joinCall(call);
        }
      } else {
        makeCall(searchedUser);
      }
    }
  }

  searchAppBar(BuildContext context) {
    return CustomAppBar(
      showGradient: true,
      title: Text('Doctor Portal'),
      actions: [
        MaterialButton(
          onPressed: () {
            logOut();
          },
          child: Text(
            'Log Out',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
      leading: null,
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: TextField(
            controller: searchController,
            onChanged: (val) {
              setState(() {
                query = val;
              });
            },
            cursorColor: UniversalVariables.blackColor,
            autofocus: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 35,
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => searchController.clear());
                },
              ),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Color(0x88ffffff),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildSuggestions(String query) {
    final List<User> suggestionList = query.isEmpty
        ? userList
        : userList != null
            ? userList.where((User user) {
                String _getUsername = user.username.toLowerCase();
                String _query = query.toLowerCase();
                String _getName = user.name.toLowerCase();
                bool matchesUsername = _getUsername.contains(_query);
                bool matchesName = _getName.contains(_query);

                return (matchesUsername || matchesName);

                // (User user) => (user.username.toLowerCase().contains(query.toLowerCase()) ||
                //     (user.name.toLowerCase().contains(query.toLowerCase()))),
              }).toList()
            : [];

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: ((context, index) {
        User searchedUser = User(
          uid: suggestionList[index].uid,
          name: suggestionList[index].name,
          username: suggestionList[index].username,
          relativeName: suggestionList[index].relativeName,
          relativeUid: suggestionList[index].relativeUid,
        );

        return CustomTile(
          mini: false,
          onTap: () {
            showDialog(
                useRootNavigator: false,
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0)), //this right here
                    child: Container(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Proceed to call ${searchedUser.name} ?",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.red,
                                ),
                                SizedBox(width: 10),
                                RaisedButton(
                                  elevation: 2.5,
                                  onPressed: () async {
                                    await Permissions
                                            .cameraAndMicrophonePermissionsGranted()
                                        ? runCall(searchedUser)
                                        : {};
                                  },
                                  child: Text(
                                    "Call",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.lightBlue,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(searchedUser.imageUrl.isEmpty
                ? 'https://firebasestorage.googleapis.com/v0/b/icu-call.appspot.com/o/profile.jpg?alt=media&token=0c06cf85-d3c6-4575-a464-f214faa8b9c4'
                : searchedUser.imageUrl.toString()),
            backgroundColor: Colors.grey,
          ),
          title: Text(
            searchedUser.name,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            searchedUser.username.toString(),
            style: TextStyle(color: UniversalVariables.greyColor),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //UniversalVariables.blackColor,
      appBar: searchAppBar(context),
      body: userList == null
          ? CustomisedProgressIndicator()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: buildSuggestions(query),
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
