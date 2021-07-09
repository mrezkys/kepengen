import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomInputError extends StatelessWidget {
  String message;
  bool isError;
  CustomInputError({this.message, this.isError});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isError,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(message, style: TextStyle(fontSize: 12, color: Colors.blueGrey[700])),
      ),
    );
  }
}