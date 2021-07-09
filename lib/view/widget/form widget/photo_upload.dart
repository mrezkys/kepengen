import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kepengen/provider/wishlist_provider.dart';

// ignore: must_be_immutable
class PhotoUpload extends StatelessWidget {
  WishlistProvider provider;
  String title;
  PhotoUpload({this.provider, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500)),
          Container(
            margin: EdgeInsets.only(top: 8),
            color: Colors.transparent,
            // row : wrapper of 2 container
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Photo picker option
                GestureDetector(
                  onTap: () async {
                    var image = await provider.wishlistPhotoPicker();
                    provider.wishlistPickedPhoto = image;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 15),
                    height: 50,
                    width: ((MediaQuery.of(context).size.width - 30 - 30) / 2) - 5, // divided by 2 ( 2 item in the row ) | 5 = space between
                    decoration: BoxDecoration(
                      color: (provider.wishlistPickedPhoto != null) ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/Folder.svg', color: (provider.wishlistPickedPhoto != null) ? Colors.white : Colors.black),
                            SizedBox(width: 15),
                            Text('Unggah', style: TextStyle(fontSize: 12, color: (provider.wishlistPickedPhoto != null) ? Colors.white : Color(0xFF606772))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // Dummy option
                GestureDetector(
                  onTap: () {
                    provider.wishlistPickedPhoto = null;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 15),
                    height: 50,
                    width: ((MediaQuery.of(context).size.width - 30 - 30) / 2) - 5, // divided by 2 ( 2 item in the row ) | 5 = space between
                    decoration: BoxDecoration(
                      color: (provider.wishlistPickedPhoto != null) ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/Folder.svg', color: (provider.wishlistPickedPhoto != null) ? Colors.black : Colors.white), //TODO: update pubspec : add document icon
                            SizedBox(width: 15),
                            Text('Dummy', style: TextStyle(fontSize: 12, color: (provider.wishlistPickedPhoto != null) ? Color(0xFF606772) : Colors.white)),
                          ],
                        )
                      ],
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
