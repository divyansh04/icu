import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  static const String ONBOARDING_FLAG = 'onboarding flag';

  static Future<void> markOnboardingAsSeen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(ONBOARDING_FLAG, true);
  }
 Future isDoctor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
 bool isDoctor = prefs.getBool('isDoctor');
 bool uid = prefs.getBool('uid');
  if (!uid) {
    /// If it's the first time, there is no shared preference registered
    // Navigator.pushNamedAndRemoveUntil(...);
  } else {
    if (isDoctor) {
      /// If the user is a doctor
      // Navigator.pushNamedAndRemoveUntil(...);
    } else {
      /// If the user is not a doctor
      // Navigator.pushNamedAndRemoveUntil(...);
    }
  }
  }
}
// SharedPreferences preferences =
                //             await SharedPreferences.getInstance();

                //         await preferences.setBool("displayHomeShowcase", true);