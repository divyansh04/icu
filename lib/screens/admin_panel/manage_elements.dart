import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icu/utils/universal_variables.dart';
import 'package:icu/constants/UIconstants.dart';

import 'package:icu/widgets/CustomAppBar.dart';

import 'package:icu/widgets/standard_custom_button.dart';

class ManageElements extends StatefulWidget {
  final String role;
  const ManageElements({Key key, @required this.role}) : super(key: key);
  @override
  _ManageElementsState createState() => _ManageElementsState();
}

enum Gender {
  MALE,
  FEMALE,
}

class _ManageElementsState extends State<ManageElements> {
  var _formKey = GlobalKey<FormState>();
  Gender selectedGender;
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _relativeEmail = TextEditingController();
  TextEditingController _relativeName = TextEditingController();
  @override
  void initState() {
    print(widget.role);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return widget.role == 'Edit Doctors'
        ? doctor()
        :patient() ;
  }
  Widget doctor(){
    return
        Scaffold(
          appBar: CustomAppBar(
            centerTitle: true,
            title: Text(
              widget.role,
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
                  CircleAvatar(
                    radius: 50.0,
                    child: Icon(
                      Icons.account_circle,
                      size: 80,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: _name,
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
                    cursorColor: Colors.white,
                    controller: _email,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.emailAddress,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "please enter a email";
                      }
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: kFormTextFieldDecoration.copyWith(
                        labelText:
                             'Doctor\'s Email',
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
                                  ? UniversalVariables.gradientColorStart
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
                                  ? UniversalVariables.gradientColorStart
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
  Widget patient(){
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: Text(
          widget.role,
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
              CircleAvatar(
                radius: 50.0,
                child: Icon(
                  Icons.account_circle,
                  size: 80,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              TextFormField(
                cursorColor: Colors.black,
                controller: _name,
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
                cursorColor: Colors.white,
                controller: _email,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.emailAddress,
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "please enter a email";
                  }
                },
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: kFormTextFieldDecoration.copyWith(
                    labelText:'Patient\'s' + ' E-mail',
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
                cursorColor: Colors.white,
                controller: _relativeName,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.emailAddress,
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "please enter a email";
                  }
                },
                style: TextStyle(
                  color: Colors.white,
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
                cursorColor: Colors.white,
                controller: _relativeEmail,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.emailAddress,
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "please enter a email";
                  }
                },
                style: TextStyle(
                  color: Colors.white,
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
                              ? UniversalVariables.gradientColorStart
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
                              ? UniversalVariables.gradientColorStart
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
