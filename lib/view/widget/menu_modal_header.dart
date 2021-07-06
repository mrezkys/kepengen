import 'package:flutter/material.dart';

class MenuModalHeader extends StatelessWidget {
  final Function leftMenuOnTap;
  final Function rightMenuOnTap;
  final String leftMenuTitle;
  final String rightMenuTitle;

  MenuModalHeader({this.leftMenuOnTap, this.leftMenuTitle = '', this.rightMenuOnTap, this.rightMenuTitle = ''});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width - 20 - 20, // 20 = parent margin
      decoration: BoxDecoration(color: Color(0xFFF6F6F6), borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: leftMenuOnTap,
            child: Container(
              alignment: Alignment.center,
              height: 56,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
                color: Colors.transparent,
              ),
              child: Text('Batal', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xFF606772))),
            ),
          ),
          Text('Menu', style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
          GestureDetector(
            onTap: rightMenuOnTap,
            child: Container(
              alignment: Alignment.center,
              height: 56,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15)),
                color: Colors.transparent,
              ),
              child: Text(rightMenuTitle, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xFF606772))),
            ),
          ),
        ],
      ),
    );
  }
}
