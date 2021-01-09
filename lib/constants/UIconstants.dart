import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(
    color: Colors.white60,
  ),
  errorStyle: TextStyle(color: Colors.white),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 0.5),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

const kFormTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  errorStyle: TextStyle(color: Colors.red),
  // contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: UnderlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 0.5),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Color(0xfff2a041), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

final kPrimaryColor = Color(0xff29323c);
final kBlue = Color(0xff21d4fd);
final kPruple = Color(0xffb721ff);
final klightGrey = Color(0xff313543);
final kwhiteGrey = Color(0xffd8d8d8);
final kOrange = Color(0xfffee140);
final kYellow = Color(0xfffa709a);
final kGreen = Color(0xff00c9ff);
final kBlue2 = Color(0xff92fe9d);
final kLightOrange = Color(0xffffe29f);
final kLightRed = Color(0xffff719a);
final kLighOrange2 = Color(0xfffbab66);
final kPurple = Color(0xfff7418c);

final Color kBlueColor = Color(0xff2b9ed4);
final Color kBlackColor = Color(0xff19191b);
final Color kGreyColor = Color(0xff8f8f8f);
final Color kUserCircleBackground = Color(0xff2b2b33);
final Color kOnlineDotColor = Color(0xff46dc64);
final Color kLightBlueColor = Color(0xff0077d7);
final Color kSeparatorColor = Color(0xff272c35);
final Color kGradientColorStart = Color(0xfff00079);
final Color kGradientColorEnd = Color(0xfff2a041);
final Color kComplementGradientColorStart = Color(0xff0d5fbe);
final Color kComplementGradientColorEnd = Color(0xff0fff86);
final Color kSenderColor = Color(0xff2b343b);
final Color kReceiverColor = Color(0xff1e2225);
