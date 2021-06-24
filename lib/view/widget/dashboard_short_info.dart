import 'package:flutter/material.dart';

class DashboardShortInfo extends StatelessWidget {
  final String type;
  int data;
  DashboardShortInfo({this.type, this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Rp. ' + data.toString(), style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
          SizedBox(
            height: 5,
          ),
          Text(type, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14)),
        ],
      ),
    );
  }
}
