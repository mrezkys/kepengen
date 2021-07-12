import 'package:flutter/material.dart';

class MenuModalItem extends StatelessWidget {
  final String text;
  final icon;
  final Function onTap;
  MenuModalItem({this.text, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width - 20 - 20,
        height: 45,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 30, right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            icon,
            SizedBox(width: 30),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'Poppins'),
            ),
          ],
        ),
      ),
    );
  }
}
