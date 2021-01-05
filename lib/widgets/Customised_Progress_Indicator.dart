import 'package:flutter/material.dart';
import 'package:icu/utils/universal_variables.dart';

class CustomisedProgressIndicator extends StatefulWidget {
  @override
  _CustomisedProgressIndicatorState createState() =>
      _CustomisedProgressIndicatorState();
}

class _CustomisedProgressIndicatorState
    extends State<CustomisedProgressIndicator> with TickerProviderStateMixin {
  AnimationController animationController;
  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: animationController.drive(ColorTween(
              begin: UniversalVariables.gradientColorStart,
              end: UniversalVariables.gradientColorEnd)),
        ),
      ),
    );
  }
}
