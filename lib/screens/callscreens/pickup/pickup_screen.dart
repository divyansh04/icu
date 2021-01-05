import 'package:flutter/material.dart';
import 'package:icu/constants/strings.dart';
import 'package:icu/models/call.dart';
import 'package:icu/models/log.dart';
import 'package:icu/resources/call_methods.dart';
import 'package:icu/resources/local_db/repository/log_repository.dart';
import 'package:icu/screens/callscreens/call_screen.dart';
import 'package:icu/utils/permissions.dart';

class PickupScreen extends StatefulWidget {
  final Call call;

  PickupScreen({
    @required this.call,
  });

  @override
  _PickupScreenState createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  final CallMethods callMethods = CallMethods();
  // final LogRepository logRepository = LogRepository(isHive: true);
  // final LogRepository logRepository = LogRepository(isHive: false);

  bool isCallMissed = true;

  addToLocalStorage({@required String callStatus}) {
    Log log = Log(
      callerName: widget.call.doctorId,
      receiverName: widget.call.patientId,
      timestamp: DateTime.now().toString(),
      callStatus: callStatus,
    );

    LogRepository.addLogs(log);
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
      backgroundColor: Colors.white70,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 50),
            Expanded(
              child: Text(
                "Incoming...",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),

            Expanded(
              child: Text(
                widget.call.doctorName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 75),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(Icons.call_end,size: 30,),
                      color: Colors.redAccent,
                      onPressed: () async {
                        isCallMissed = false;
                        addToLocalStorage(callStatus: CALL_STATUS_RECEIVED);
                        await callMethods.endRelativeIncomingCall(call: widget.call);
                      },
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: IconButton(
                        icon: Icon(Icons.call,size: 30,),
                        color: Colors.green,
                        onPressed: () async {
                          int users=widget.call.users.toInt()+1;
                          print(users);
                          callMethods.joinCall(
                              call:widget.call,user: users);
                          isCallMissed = false;
                          addToLocalStorage(callStatus: CALL_STATUS_RECEIVED);
                          await Permissions.cameraAndMicrophonePermissionsGranted()
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CallScreen(call: widget.call),
                                  ),
                                )
                              // ignore: unnecessary_statements
                              : {};
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
