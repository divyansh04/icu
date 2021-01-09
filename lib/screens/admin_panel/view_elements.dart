import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icu/models/user.dart';
import 'package:icu/resources/auth_methods.dart';
import 'package:icu/widgets/Customised_Progress_Indicator.dart';
import 'package:icu/widgets/custom_tile.dart';
import 'package:icu/widgets/standard_custom_button.dart';
import 'package:icu/constants/UIconstants.dart';
import 'package:icu/widgets/CustomAppBar.dart';
import 'package:icu/screens/admin_panel/manage_elements.dart';

class ViewElements extends StatefulWidget {
  final String role;

  const ViewElements({Key key, @required this.role}) : super(key: key);
  @override
  _ViewElementsState createState() => _ViewElementsState();
}

class _ViewElementsState extends State<ViewElements> {
  List<int> serviceElementList = [1, 2, 3];
  final AuthMethods _authMethods = AuthMethods();
  FirebaseUser currentUser;
  bool loading = false;
  List<User> userList = null;
  getUsersList(String userRole) async {
    setState(() {
      loading = true;
    });
    try {
      await _authMethods.getCurrentUser().then((FirebaseUser user) {
        setState(() {
          currentUser = user;
        });
        userRole=='Doctors'?_authMethods.fetchDoctors(currentUser).then((List<User> list) {
          setState(() {
            userList = list;
            loading = false;
            //userList.toList().sort((a, b) => a.name.compareTo(b.name));
          });
        }):_authMethods.fetchPatients(currentUser).then((List<User> list) {
          setState(() {
            userList = list;
            loading = false;
            //userList.toList().sort((a, b) => a.name.compareTo(b.name));
          });
        });
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
  @override
  void initState() {
    setState(() {
      loading = true;
    });
    getUsersList(widget.role);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: Text(
          widget.role,
        ),
        actions: [],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        showGradient: true,
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: StandardCustomButton(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ManageElements(
                      role: widget.role,
                    )));
          },
          shape: BoxShape.circle,
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body:loading?CustomisedProgressIndicator():Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: userList == null || userList.isEmpty
            ? Center(
                child: Text(
                'No ${widget.role} Added',
                style: TextStyle(
                    color: kGreyColor, fontSize: 30.0),
              ))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: userList.length,
                itemBuilder: ((context, index) {
                  return CustomTile(
                    mini: false,
                    onTap: () {},
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(userList[index].imageUrl.isEmpty?
                          'https://firebasestorage.googleapis.com/v0/b/icu-call.appspot.com/o/profile.jpg?alt=media&token=0c06cf85-d3c6-4575-a464-f214faa8b9c4':'${userList[index].imageUrl}'),
                      backgroundColor: Colors.grey,
                    ),
                    title: Text(
                      '${userList[index].name}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${userList[index].email}',
                      style: TextStyle(color: kGreyColor),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ManageElements(
                                  role: widget.role,user: userList[index],
                                )));
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 30,
                        color: kBlackColor,
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}
