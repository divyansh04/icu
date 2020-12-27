import 'package:flutter/material.dart';
import 'package:icu/constants/strings.dart';
import 'package:icu/models/call.dart';
import 'package:icu/models/log.dart';
import 'package:icu/resources/call_methods.dart';
import 'package:icu/resources/local_db/repository/log_repository.dart';
import 'package:icu/screens/callscreens/call_screen.dart';
import 'package:icu/utils/permissions.dart';

class PickupScreenPatient extends StatefulWidget {
  final Call call;

  PickupScreenPatient({
    @required this.call,
  });

  @override
  _PickupScreenPatientState createState() => _PickupScreenPatientState();
}

class _PickupScreenPatientState extends State<PickupScreenPatient> {
  final CallMethods callMethods = CallMethods();
  // final LogRepository logRepository = LogRepository(isHive: true);
  // final LogRepository logRepository = LogRepository(isHive: false);

  bool isCallMissed = true;
  addToLocalStorage({@required String callStatus}) {
    Log log = Log(
      callerName: widget.call.callerName,
      callerPic: widget.call.callerPic,
      receiverName: widget.call.receiverName,
      receiverPic: widget.call.receiverPic,
      timestamp: DateTime.now().toString(),
      callStatus: callStatus,
    );

    LogRepository.addLogs(log);
  }
  @override
  void initState() {
    pickUp();
    super.initState();
  }
  @override
  void dispose() {
    if (isCallMissed) {
      addToLocalStorage(callStatus: CALL_STATUS_MISSED);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Doctor is connecting with you...',style: TextStyle(color: Colors.white,fontSize: 17),),
            SizedBox(height: 25,),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

  pickUp() async {
    isCallMissed = false;
    addToLocalStorage(callStatus: CALL_STATUS_RECEIVED);
    return await Permissions.cameraAndMicrophonePermissionsGranted()
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CallScreen(call: widget.call),
            ),
          )
        // ignore: unnecessary_statements
        : {};
  }
}