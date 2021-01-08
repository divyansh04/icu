import 'package:flutter/material.dart';
import 'package:icu/constants/strings.dart';
import 'package:icu/models/call.dart';
import 'package:icu/models/log.dart';
import 'package:icu/resources/call_methods.dart';
import 'package:icu/resources/local_db/repository/log_repository.dart';
import 'package:icu/screens/callscreens/call_screen.dart';
import 'package:icu/utils/permissions.dart';
import 'package:icu/utils/universal_variables.dart';

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
  bool callDeclined=false;
  @override
  Widget build(BuildContext context) {
    return callDeclined?Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              UniversalVariables.gradientColorStart,
              UniversalVariables.gradientColorEnd,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Stack(children: [
          Container(
            color: UniversalVariables.blackColor.withOpacity(0.5),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Center(
              child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Text(
                      "Doctor is connected with patient !",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          elevation: 2.0,
                          onPressed: () async{
                            {
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
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    UniversalVariables.gradientColorStart,
                                    UniversalVariables.gradientColorEnd
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              constraints: BoxConstraints(minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Join call",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ]),
      ),
    ):Scaffold(
      backgroundColor: Colors.white70,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 50),
            Expanded(
              flex: 1,
              child: Text(
                "Incoming...",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 130,
                    backgroundImage: AssetImage('assets/doctor.jpg'),
                  ),
                  Text(
                    '${widget.call.doctorName} is calling you....',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
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
                        setState(() {
                          callDeclined=true;
                        });
                        isCallMissed = false;
                        addToLocalStorage(callStatus: CALL_STATUS_RECEIVED);
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
                          setState(() {
                            callDeclined=true;
                          });
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
