import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:icu/models/user.dart';
import 'package:icu/resources/auth_methods.dart';
import 'package:icu/screens/callscreens/pickup/pickup_layout.dart';
import 'package:icu/screens/login_screen.dart';
import 'package:icu/utils/call_utilities.dart';
import 'package:icu/utils/permissions.dart';
import 'package:icu/utils/universal_variables.dart';
import 'package:icu/widgets/custom_tile.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final AuthMethods _authMethods = AuthMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User sender;
  List<User> userList;
  String query = "";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _authMethods.getCurrentUser().then((FirebaseUser user) {
      _authMethods.fetchAllotedPatients(user).then((List<User> list) {
        setState(() {
          userList = list;
          sender = User(
            uid: user.uid.toString(),
            name: user.displayName,
          );
        });
      });
    });
  }

  searchAppBar(BuildContext context) {
    return GradientAppBar(
      centerTitle: true,
      title: Text('Doctor Portal'),
      actions:[
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
            gradient: LinearGradient(
        colors: [
          UniversalVariables.gradientColorStart,
          UniversalVariables.gradientColorEnd,
        ],
      ),
      elevation: 0,
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
        ? []
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
                                        ? {
                                            Navigator.pop(context),
                                            CallUtils.dial(
                                              from: sender,
                                              to: searchedUser,
                                              context: this.context,
                                            )
                                          }
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
             backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/icu-call.appspot.com/o/profile.jpg?alt=media&token=0c06cf85-d3c6-4575-a464-f214faa8b9c4'),
             backgroundColor: Colors.grey,
           ),
          title: Text(
            searchedUser.name,
            style: TextStyle(
              color: Colors.white,
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
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        appBar: searchAppBar(context),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: buildSuggestions(query),
        ),
      ),
    );
  }
  logOut() async {
    try {
      await _auth.signOut();
      Fluttertoast.showToast(msg: 'Logged out Successfully',textColor: Colors.black,backgroundColor: Colors.white);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Log out Failed',textColor: Colors.black,backgroundColor: Colors.white);
      print(e);
    }
  }
}
