import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icu/utils/universal_variables.dart';
import 'package:icu/constants/UIconstants.dart';
class AddDoctor extends StatefulWidget {
  @override
  _AddDoctorState createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {

  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit/Add Doctor',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Colors.deepOrange,
      ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20,),
             CircleAvatar(
                radius: 50.0,
               backgroundColor: Colors.orangeAccent,
               child: Icon(
                 Icons.account_circle,
                 size: 50,
               ),
             ),
            SizedBox(width: 20,),
            Material(
              borderRadius: BorderRadius.circular(10.0),
              elevation: 0.0,
              color: UniversalVariables.blackColor,
              child: TextFormField(
                cursorColor: Colors.white,
                controller: _email,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "please enter a value";
                  }
                },
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Name',
                  labelStyle:TextStyle(
                    color: Colors.white,
                  ) ,
                  suffixIcon:  Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 15.0,
                  ) ,
                    hintText: 'Enter your Name',
                    prefixIcon: Icon(
                      Icons.title,
                      color: Colors.white,
                      size: 15.0,
                    )),
              ),
            ),
            SizedBox(height: 10,),
            Material(
              borderRadius: BorderRadius.circular(10.0),
              elevation: 0.0,
              color: Colors.white,
              child: TextFormField(
                cursorColor: Colors.white,
                controller: _email,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "please enter a value";
                  }
                },
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'E-mail',
                    suffixIcon:  Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 15.0,
                    ) ,
                    hintText: 'Enter your email',
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      color: Colors.black,
                      size: 15.0,
                    )),
              ),
            ),
            SizedBox(height: 30,),
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: Container(
                  child:
                  Center(
                    child: Text(
                      'Male',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF1D1E33),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),),
                SizedBox(width: 20,
                ),
                Expanded(child: Container(
                  child:
                  Center(
                    child: Text(
                      'female',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF1D1E33),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),),
              ],
            )
            ),
            SizedBox(height: 40,),
            Container(
              child: Center(
                child: Text(
                  'Save Changes?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              color: Colors.deepOrange,
              margin: EdgeInsets.all(10.0),
              height: 50.0,
            ),
                ],
            ),
            );
  }
}


