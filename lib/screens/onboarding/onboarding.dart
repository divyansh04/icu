import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icu/constants/UIconstants.dart';
import 'package:icu/screens/login_screen.dart';
import 'package:icu/utils/shared_pref_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'primary_widget.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final int totalScreen = 3;
  int currentPageValue = 0;
  SharedPreferences prefs;
  List<Widget> introWidgetsList;
  Timer _timer;
  PageController controller = PageController(initialPage: 0, keepPage: false);
  @override
  void initState() {
    super.initState();
    introWidgetsList = getOnboardingModels();
    _timer = getTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            PageView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: introWidgetsList.length,
              onPageChanged: (int page) {
                getChangedPageAndMoveBar(page);
              },
              controller: controller,
              itemBuilder: (context, index) {
                return introWidgetsList[index];
              },
            ),
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 35),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < introWidgetsList.length; i++)
                        if (i == currentPageValue) ...[
                          circularIndicatorBar(true)
                        ] else
                          circularIndicatorBar(false),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Container(
                margin: EdgeInsets.only(right: 16, bottom: 16),
                child: FloatingActionButton(
                  onPressed: () {
                    SharedPreferencesUtility().markOnBoardingAsVisited();
                    Route route =
                        MaterialPageRoute(builder: (context) => LoginScreen());
                    Navigator.pushReplacement(context, route);
                  },
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(26))),
                  child: Icon(Icons.arrow_forward),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    print('page is $page');

    setState(() {
      currentPageValue = page;
    });

    if (currentPageValue == totalScreen - 1) {
      SharedPreferencesUtility().markOnBoardingAsVisited();
      // previousPageValue = currentPageValue;
      // _moveBar = _moveBar + 0.14;
      Future.delayed(const Duration(milliseconds: 700), () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return LoginScreen();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return Align(
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 900),
          ),
        );
      });
    } else {
      _timer.cancel();
      _timer = getTimer();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    controller.dispose();
    super.dispose();
  }

  void onNextPressed() {
    _timer.cancel();
    if (currentPageValue != totalScreen - 1) {
      setState(() {
        currentPageValue++;
        controller.nextPage(
            curve: Curves.easeInOut, duration: Duration(milliseconds: 700));
      });
      _timer = getTimer();
    }
  }

  Timer getTimer() {
    return new Timer.periodic(Duration(seconds: 3), (timer) => onNextPressed());
  }

  Container movingBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 5,
      width: 10,
      decoration: BoxDecoration(color: kwhiteGrey),
    );
  }

  Widget slidingBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 5,
      width: 10,
      decoration: BoxDecoration(color: klightGrey),
    );
  }

  Widget circularIndicatorBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive
            ? kGradientColorEnd
            : kGreyColor,
        // borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}
