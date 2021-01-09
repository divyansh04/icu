import 'package:flutter/material.dart';
import 'package:icu/constants/UIconstants.dart';

class PrimaryWidget extends StatelessWidget {
  const PrimaryWidget(
      {Key key,
      this.image,
      this.type,
      this.startGradientColor,
      this.endGradientColor,
      this.subText})
      : super(key: key);

  final image;
  final type;
  final Color startGradientColor;
  final Color endGradientColor;
  final String subText;

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[startGradientColor, endGradientColor],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Container(
      padding: EdgeInsets.only(top: 25),
      decoration: BoxDecoration(color: kPrimaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            image,
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.6,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                Opacity(
                  opacity: 0.15,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Text(
                      type.toString().toUpperCase(),
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.w900,
                          foreground: Paint()..shader = linearGradient),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -5,
                  left: 15,
                  child: Text(
                    type.toString().toUpperCase(),
                    style: TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.w900,
                        foreground: Paint()..shader = linearGradient),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              subText,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                  letterSpacing: 2.0),
            ),
          )
        ],
      ),
    );
  }

  TextStyle buildTextStyle(double size) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w900,
      height: 0.5,
    );
  }
}

List<PrimaryWidget> getOnboardingModels() {
  return [
    PrimaryWidget(
        image: 'assets/images/yellow.png',
        type: 'HEAL',
        startGradientColor: kOrange,
        endGradientColor: kYellow,
        subText: 'FEEL THE MAGIC OF WELLNESS'),
    PrimaryWidget(
        image: 'assets/images/green.png',
        type: 'Connect',
        startGradientColor: kGreen,
        endGradientColor: kBlue2,
        subText: "SHARE YOUR HEALTH UPDATES!"),
    PrimaryWidget(
        image: 'assets/images/red.png',
        type: 'Manage',
        startGradientColor: kLightOrange,
        endGradientColor: kLightRed,
        subText: "MANAGE THE DOCTOR AND PATIENT DATABASE"),
  ];
}
