import 'package:icu/screens/tabBarWidgets/LogInWidget.dart';
import 'package:flutter/material.dart';
import 'package:icu/screens/tabBarWidgets/SignUpWidget.dart';
import 'package:icu/utils/universal_variables.dart';


class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isLoginPressed = false;

  @override
  Widget build(BuildContext context) {
    return isLoginPressed
        ? Center(
      child: CircularProgressIndicator(),
    ) :DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        appBar: AppBar(
          backgroundColor: UniversalVariables.blackColor,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Sign In',),
              Tab(text: 'Sign Up',),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LogInWidget(),
            SignUpWidget()
          ],
        ),
      ),
    );
  }
}
