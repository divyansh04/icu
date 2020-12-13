import 'package:flutter/material.dart';
import 'package:icu/utils/universal_variables.dart';

class FloatingColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: UniversalVariables.blackColor,
              border: Border.all(
                width: 2,
                color: UniversalVariables.gradientColorEnd,
              )),
          child: Icon(
            Icons.add_call,
            color: UniversalVariables.gradientColorEnd,
            size: 25,
          ),
          padding: EdgeInsets.all(15),
        )
      ],
    );
  }
}
