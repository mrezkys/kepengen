import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kepengen/model/core/wishlist.dart';
import 'package:provider/provider.dart';

class WishlistItemTile extends StatelessWidget {
  int index;
  Wishlist data;
  WishlistItemTile({this.index, @required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      width: MediaQuery.of(context).size.width - 30 - 30,
      height: 80,
      decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // image
          Container(
            width: 70,
            height: 70,
            margin: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFDEEAF8),
            ),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 10),
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 5),
                  Text('On Progress', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF606772))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
