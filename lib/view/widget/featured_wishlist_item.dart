import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FeaturedWishlistItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            decoration: BoxDecoration(color: Color(0xFFEEF4FB), borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
            // image info
            child: Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.only(left: 25, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Playstation 5', style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600)),
                  SizedBox(height: 5),
                  Text('Deadline : 12 - 10 - 2021', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
          // Info
          Container(
            width: MediaQuery.of(context).size.width - 30 - 30,
            height: (MediaQuery.of(context).size.width - 30 - 30) * 30 / 100,
            decoration: BoxDecoration(color: Color(0xFFDEEAF8), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
            child: Container(
              margin: EdgeInsets.only(left: 25, bottom: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15),
                      Text('Perkiraan Harga', style: TextStyle(fontSize: 12)),
                      SizedBox(height: 5),
                      Text('Rp 5.200.000', style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15),
                      Text('Prioritas', style: TextStyle(fontSize: 12)),
                      SizedBox(height: 5),
                      SmoothStarRating(
                        allowHalfRating: false,
                        color: Colors.grey,
                        borderColor: Colors.grey,
                        starCount: 5,
                        rating: 4,
                        size: 16,
                        isReadOnly: true,
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
