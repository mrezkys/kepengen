
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class PriceInput extends StatelessWidget {
  Function onChanged;
  final String inputTitle;
  final String hint;
  PriceInput({this.inputTitle, this.hint, this.onChanged});
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
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                    color: Color(0xFFDBE5F0),
                  ),
                  child: Text('Rp', style: TextStyle(color: Color(0xFF8994A1))),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30 - 30 - 50, // 30 = parent padding | 50 = left container width
                  child: TextField(
                    onChanged: onChanged,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      CurrencyTextInputFormatter(
                        symbol: '',
                        decimalDigits: 0,
                      )
                    ],
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
          ),
        ],
      ),
    );
  }
}
