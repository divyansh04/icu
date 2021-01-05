import 'package:flutter/material.dart';
import 'package:icu/utils/universal_variables.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Size preferredSize;
  final Widget title;
  final List<Widget> actions;
  final Widget leading;
  final bool centerTitle;
  final bool showGradient;
  final Color appBarColor;
  final LinearGradient gradient;

  final PreferredSizeWidget bottom;

  CustomAppBar({
    Key key,
    @required this.title,
    @required this.actions,
    @required this.leading,
    @required this.centerTitle,
    this.bottom,
    @required this.showGradient,
    this.appBarColor,
    this.gradient,
  })  : preferredSize = Size.fromHeight(
      kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: !showGradient
            ? (appBarColor != null
            ? appBarColor
            : UniversalVariables.blackColor)
            : null,
        gradient: showGradient
            ? (gradient != null
            ? gradient
            : LinearGradient(
          colors: [
            UniversalVariables.gradientColorStart,
            UniversalVariables.gradientColorEnd
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ))
            : null,
        // border: Border(
        //   bottom: BorderSide(
        //     color: UniversalVariables.separatorColor,
        //     width: 1.4,
        //     style: BorderStyle.solid,
        //   ),
        // ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: leading,
        actions: actions,
        centerTitle: centerTitle,
        title: title,
        bottom: bottom,
      ),
    );
  }
}