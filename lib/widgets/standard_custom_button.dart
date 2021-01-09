import 'package:flutter/material.dart';
import 'package:icu/constants/UIconstants.dart';

class StandardCustomButton extends StatelessWidget {
  final Function onTap;
  final String label;
  final Widget child;
  final BoxShape shape;

  const StandardCustomButton(
      {Key key, @required this.onTap, this.label, this.child, this.shape})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2.0,
      onPressed: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
            shape: shape ?? BoxShape.rectangle,
            gradient: LinearGradient(
              colors: [
                kGradientColorStart,
                kGradientColorEnd
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: shape != null ? null : BorderRadius.circular(30.0)),
        child: Container(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          alignment: Alignment.center,
          child: child ??
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
    );
  }
}
