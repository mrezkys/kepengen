import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kepengen/model/core/wishlist.dart';
import 'package:kepengen/view/screen/wishlist_item_detail_page.dart';

class WishlistItemTile extends StatelessWidget {
  Wishlist itemData;
  WishlistItemTile({@required this.itemData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WishlistItemDetailPage(
              itemData: itemData,
            ),
          ),
        );
      },
      child: Container(
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
                image: DecorationImage(image: FileImage(File(itemData.photo)), fit: BoxFit.cover),
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
                      itemData.name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 5),
                    Text((itemData.status == 0) ? 'Belum Selesai' : 'Selesai', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF606772))),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
