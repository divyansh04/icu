
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icu/constants/UIconstants.dart';
import 'package:icu/models/user.dart';
import 'package:icu/resources/auth_methods.dart';
import 'package:icu/widgets/CustomAppBar.dart';

import 'package:icu/widgets/standard_custom_button.dart';

class ManageElements extends StatefulWidget {
  final User user;
  final String role;
  const ManageElements({Key key, @required this.role, this.user})
      : super(key: key);
  @override
  _ManageElementsState createState() => _ManageElementsState();
}

enum Gender {
  MALE,
  FEMALE,
}

class _ManageElementsState extends State<ManageElements> {
  var _formKey = GlobalKey<FormState>();
  bool hasData;
  Gender selectedGender;
  String name;
  String email;
  String relativeEmail;
  String relativeName;
  String password='123456';
  AuthMethods authMethods=AuthMethods();
  checkUserData() {
    if (widget.user != null) {
      setState(() {
        hasData = true;
        print(hasData);
      });
    } else
      setState(() {
        hasData = false;
        print(hasData);
      });
  }

  @override
  void initState() {
    checkUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.role == 'Doctors' ? doctor() : patient();
  }

  Widget doctor() {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: Text(
          hasData ? 'Edit ${widget.role}' : 'Add ${widget.role}',
          style: TextStyle(
            // fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Stack(children: [
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 50.0,
                    child: CircleAvatar(
                      radius: 48.5,
                      backgroundColor: Colors.white,
                      backgroundImage: hasData
                          ? NetworkImage(widget.user.imageUrl.toString())
                          : AssetImage('assets/profile.jpg'),
                    ),
                  ),
                ),
                Positioned(
                    left: 202,
                    top: 75,
                    child: Icon(Icons.add_a_photo, color: kGradientColorStart)),
              ]),
              SizedBox(
                width: 20,
              ),
              TextFormField(
                initialValue: hasData ? widget.user.name : '',
                cursorColor: Colors.black,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                textAlign: TextAlign.left,
                keyboardType: TextInputType.emailAddress,
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "please enter a name";
                  }
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: kFormTextFieldDecoration.copyWith(
                    labelText: 'Doctor\'s Name ',
                    hintText: 'Enter your name',
                    suffixIcon: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 15.0,
                    ),
                    prefixIcon: Icon(
                      Icons.text_fields,
                      color: Colors.black,
                      size: 15.0,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: hasData ? widget.user.email : '',
                cursorColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                textAlign: TextAlign.left,
                keyboardType: TextInputType.emailAddress,
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "please enter a email";
                  }
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: kFormTextFieldDecoration.copyWith(
                    labelText: 'Doctor\'s Email',
                    suffixIcon: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 15.0,
                    ),
                    hintText: 'Enter your email',
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      color: Colors.black,
                      size: 15.0,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGender = Gender.MALE;
                        });
                      },
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        child: Center(
                          child: Text(
                            'Male',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: selectedGender == Gender.MALE
                              ? kGradientColorStart
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGender = Gender.FEMALE;
                        });
                      },
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        child: Center(
                          child: Text(
                            'Female',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: selectedGender == Gender.FEMALE
                              ? kGradientColorStart
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Container(
          height: 50.0,
          child: StandardCustomButton(
            onTap: () async {
              if (_formKey.currentState.validate()) {
                //  perform add doctor logic
                print(email);
                print(name);
                if(!hasData){addDoctor();}
              }
            },
            label: 'Save',
          ),
        ),
      ),
    );
  }

  Widget patient() {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: Text(
          hasData ? 'Edit ${widget.role}' : 'Add ${widget.role}',
          style: TextStyle(
            // fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Stack(children: [
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 50.0,
                    child: CircleAvatar(
                      radius: 48.5,
                      backgroundColor: Colors.white,
                      backgroundImage: hasData
                          ? NetworkImage(widget.user.imageUrl.toString())
                          : AssetImage('assets/profile.jpg'),
                    ),
                  ),
                ),
                Positioned(
                    left: 202,
                    top: 75,
                    child: Icon(Icons.add_a_photo, color: kGradientColorStart)),
              ]),
              SizedBox(
                width: 20,
              ),
              TextFormField(
                initialValue: hasData ? widget.user.name : '',
                cursorColor: Colors.black,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                textAlign: TextAlign.left,
                keyboardType: TextInputType.emailAddress,
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "please enter a name";
                  }
                },

                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: kFormTextFieldDecoration.copyWith(
                    labelText: 'Patient\'s' + ' Name',
                    hintText: 'Enter your name',
                    suffixIcon: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 15.0,
                    ),
                    prefixIcon: Icon(
                      Icons.text_fields,
                      color: Colors.black,
                      size: 15.0,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: Colors.black,
                initialValue: hasData ? widget.user.email : '',
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                textAlign: TextAlign.left,
                keyboardType: TextInputType.emailAddress,
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "please enter a email";
                  }
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: kFormTextFieldDecoration.copyWith(
                    labelText: 'Patient\'s' + ' E-mail',
                    suffixIcon: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 15.0,
                    ),
                    hintText: 'Enter your email',
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      color: Colors.black,
                      size: 15.0,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: Colors.black,
                initialValue: hasData ? widget.user.relativeName : '',
                textAlign: TextAlign.left,
                onChanged: (value) {
                  setState(() {
                    relativeName = value;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "please enter a email";
                  }
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: kFormTextFieldDecoration.copyWith(
                    labelText: 'Relative\'s' + ' Name',
                    suffixIcon: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 15.0,
                    ),
                    hintText: 'Enter your Name',
                    prefixIcon: Icon(
                      Icons.text_fields,
                      color: Colors.black,
                      size: 15.0,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: Colors.black,
                initialValue: hasData ? widget.user.relativeEmail : '',
                onChanged: (value) {
                  setState(() {
                    relativeEmail = value;
                  });
                },
                textAlign: TextAlign.left,
                keyboardType: TextInputType.emailAddress,
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "please enter a email";
                  }
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: kFormTextFieldDecoration.copyWith(
                    labelText: 'Relative\'s' + ' E-mail',
                    suffixIcon: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 15.0,
                    ),
                    hintText: 'Enter your email',
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      color: Colors.black,
                      size: 15.0,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGender = Gender.MALE;
                        });
                      },
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        child: Center(
                          child: Text(
                            'Male',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: selectedGender == Gender.MALE
                              ? kGradientColorStart
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGender = Gender.FEMALE;
                        });
                      },
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        child: Center(
                          child: Text(
                            'Female',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: selectedGender == Gender.FEMALE
                              ? kGradientColorStart
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Container(
          height: 50.0,
          child: StandardCustomButton(
            onTap: () async {
              if (_formKey.currentState.validate()) {
                //  perform add doctor logic
              }
            },
            label: 'Save',
          ),
        ),
      ),
    );
  }

}
