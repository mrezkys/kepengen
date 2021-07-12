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
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          (leftIconPath is String && leftIconOnPressed is Function)
              ? Material(
                  color: Colors.transparent,
                  shape: CircleBorder(),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    splashColor: Colors.black.withOpacity(0.03),
                    highlightColor: Colors.black.withOpacity(0.03),
                    focusColor: Colors.black.withOpacity(0.03),
                    onTap: leftIconOnPressed,
                    child: IconButton(
                      onPressed: null,
                      icon: SvgPicture.asset(
                        leftIconPath,
                        color: iconColor,
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  width: 42,
                ),
          Text(title, style: TextStyle(fontFamily: 'Open Sans', color: textColor, fontSize: 14, fontWeight: FontWeight.w500, decoration: TextDecoration.none)),
          (rightIconPath is String && leftIconOnPressed is Function)
              ? Material(
                  color: Colors.transparent,
                  shape: CircleBorder(),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    splashColor: Colors.black.withOpacity(0.03),
                    highlightColor: Colors.black.withOpacity(0.03),
                    focusColor: Colors.black.withOpacity(0.03),
                    onTap: rightIconOnPressed,
                    child: IconButton(
                      onPressed: null,
                      icon: SvgPicture.asset(
                        rightIconPath,
                        color: iconColor,
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  width: 42,
                ),
        ],
      ),
    );
  }
}
