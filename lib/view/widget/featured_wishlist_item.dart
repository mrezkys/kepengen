import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kepengen/model/core/wishlist.dart';
import 'package:kepengen/model/helper/rupiah_formatter.dart';
import 'package:kepengen/view/screen/wishlist_item_detail_page.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FeaturedWishlistItem extends StatelessWidget {
  final Wishlist itemData;
  FeaturedWishlistItem({@required this.itemData});
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width - 30 - 30,
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // image
            Container(
              width: MediaQuery.of(context).size.width - 30 - 30,
              height: (MediaQuery.of(context).size.width - 30 - 30) * 70 / 100,
              decoration: BoxDecoration(
                image: DecorationImage(image: FileImage(File(itemData.photo)), fit: BoxFit.cover),
                color: Color(0xFFEEF4FB),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              ),
              // image info
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 30 - 30,
                    height: (MediaQuery.of(context).size.width - 30 - 30) * 70 / 100,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black.withOpacity(0.5), Colors.black.withOpacity(0.3), Colors.black.withOpacity(0.05), Colors.black.withOpacity(0)])),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(left: 25, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(itemData.name, style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
                        SizedBox(height: 5),
                        Text('Deadline : ' + itemData.deadline.substring(0, 10), style: TextStyle(fontSize: 12, color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Info
            Container(
              width: MediaQuery.of(context).size.width - 30 - 30,
              height: (MediaQuery.of(context).size.width - 30 - 30) * 30 / 100,
              decoration: BoxDecoration(color: Color(0xFFDEEAF8), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
              child: Container(
                margin: EdgeInsets.only(left: 25, bottom: 20, right: 20),
                height: (MediaQuery.of(context).size.width - 30 - 30) * 30 / 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 15),
                          Text('Perkiraan Harga', style: TextStyle(fontSize: 12)),
                          SizedBox(height: 5),
                          AutoSizeText(
                            RupiahFormatter.formatCurrency.format(itemData.price),
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 15),
                          Text('Prioritas', style: TextStyle(fontSize: 12)),
                          SizedBox(height: 5),
                          SmoothStarRating(
                            allowHalfRating: false,
                            color: Theme.of(context).primaryColor,
                            borderColor: Theme.of(context).primaryColor,
                            starCount: 5,
                            rating: itemData.priority,
                            size: 16,
                            isReadOnly: true,
                          )
                        ],
                      ),
                    ),
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
