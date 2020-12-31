import "package:flutter/material.dart";
import 'package:icu/constants/UIconstants.dart';

class JoinCall extends StatefulWidget {
  @override
  _JoinCallState createState() => _JoinCallState();
}

class _JoinCallState extends State<JoinCall> {
  TextEditingController code = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: ListView(children: [
            SizedBox(
              height: 300.0,
            ),
            Material(
              borderRadius: BorderRadius.circular(10.0),
              elevation: 0.0,
              color: Colors.white.withOpacity(0.2),
              child: TextFormField(
                cursorColor: Colors.white,
                controller: code,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "please enter code";
                  }
                },
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter the code here',
                    prefixIcon: Icon(Icons.link, color: Colors.white)),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 2.0,
                  child: MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                    //    Navigator.push(context,
                        //                             MaterialPageRoute(builder: (context) {
                        //                           return RelativeCallScreen(call: call,id: code.toString(),);
                        //                         }));
                      }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'join',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
