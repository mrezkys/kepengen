import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormInput extends StatelessWidget {
  Function onChanged;
  final String inputTitle;
  final String hint;
  TextFormInput({this.inputTitle, this.hint, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(inputTitle, style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500)),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).accentColor,
            ),
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 20),
                hintText: hint,
                hintStyle: TextStyle(color: Color(0xFFB3BECC)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
