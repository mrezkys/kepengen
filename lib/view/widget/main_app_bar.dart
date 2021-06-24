import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainAppBar extends StatelessWidget {
  final Color background;
  final Color textColor;
  final Color iconColor;

  final String leftIconPath;
  final String rightIconPath;
  final String title;

  final Function leftIconOnPressed;
  final Function rightIconOnPressed;

  MainAppBar({this.background, this.textColor, this.iconColor, this.leftIconPath, this.rightIconPath, this.title, this.leftIconOnPressed, this.rightIconOnPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      height: 60,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: leftIconOnPressed,
            child: SvgPicture.asset(leftIconPath, color: iconColor),
          ),
          Text(title, style: TextStyle(fontFamily: 'Open Sans', color: textColor, fontSize: 14, fontWeight: FontWeight.w500, decoration: TextDecoration.none)),
          GestureDetector(
            onTap: rightIconOnPressed,
            child: SvgPicture.asset(rightIconPath, color: iconColor),
          ),
        ],
      ),
    );
  }
}
