import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SharedPreferenceUtil.isDoctor();
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.access_alarm_rounded,
            //some icon,
            ),
      ),
    );
  }
}
