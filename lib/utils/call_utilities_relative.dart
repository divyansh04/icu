import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icu/constants/strings.dart';
import 'package:icu/models/call.dart';
import 'package:icu/models/log.dart';
import 'package:icu/resources/call_methods.dart';
import 'package:icu/resources/local_db/repository/log_repository.dart';
import 'package:icu/screens/callscreens/call_screen.dart';

class CallUtilsRelative {
  static final CallMethods callMethods = CallMethods();

  static dial({ DocumentSnapshot relative, context}) async {
    Call call = Call(
      callerId: relative['uid'],
      callerName: relative['name'],
      receiverId: relative['patientUid'],
      receiverName: relative['patientName'],
      users: 1,
      channelId: Random().nextInt(1000).toString(),
    );

    Log log = Log(
      callerName: relative['name'],
      callerPic: relative['profile_Photo'],
      callStatus: CALL_STATUS_DIALLED,
      receiverName: relative['patientName'],
      receiverPic:  relative['patientProfilePhoto'],
      timestamp: DateTime.now().toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      // enter log
      LogRepository.addLogs(log);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(call: call),
        ),
      );
    }
  }
}