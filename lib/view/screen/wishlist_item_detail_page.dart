import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kepengen/model/helper/value_checker.dart';
import 'package:kepengen/view/modal/wishlist_item_detail_page_menu_modal.dart';
import 'package:kepengen/view/utils/gradient_background.dart';
import 'package:kepengen/view/widget/main_app_bar.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class WishlistItemDetailPage extends StatelessWidget {
  final int index;
  WishlistItemDetailPage({this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: GradientBackground.gradient()),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ListView(
              children: <Widget>[
                // appbar
                MainAppBar(
                  background: Colors.transparent,
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  title: 'Notification',
                  leftIconPath: 'assets/icons/Arrow-left.svg',
                  rightIconPath: 'assets/icons/Info Square.svg',
                  leftIconOnPressed: () {
                    Navigator.pop(context);
                  },
                  rightIconOnPressed: () {
                    showModalBottomSheet(
                        elevation: 0.0,
                        isDismissible: true,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return WishlistItemDetailPageMenuModal(wishlistItemIndex: index);
                        });
                  },
                ),
                SizedBox(height: 10),
                // info
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Status',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Complete',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Sisa Waktu',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          // CountdownTimer(
                          //   controller: _countDownController,
                          //   textStyle: TextStyle(
                          //     fontSize: 14,
                          //     color: Colors.white,
                          //     fontFamily: 'Poppins',
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          //   onEnd: () {
                          //     _countDownController.dispose();
                          //   },
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                // card
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                  child: Column(
                    children: [
                      // Wishlist Image
                      Container(
                        height: 220,
                        decoration: BoxDecoration(
                          // image: DecorationImage(fit: BoxFit.cover, image: FileImage(File(_photo))),
                          color: Color(0xFFDEEAF8),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 25, right: 15, top: 25, bottom: 30),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            // Title and Link Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('_name', style: TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                                      SizedBox(height: 5),
                                      Text('Target : ' + '_date', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 4,
                                  child: Center(
                                    child: IconButton(
                                      icon: SvgPicture.asset('assets/icons/Send.svg'),
                                      onPressed: () async {
                                        final Uri _lun = Uri(
                                          scheme: 'http',
                                          path: '_link',
                                        );
                                        if (!ValueChecker.isNullOrEmpty('_link')) {
                                          launch(_lun.toString());
                                        } else {
                                          print('there is no link to go');
                                          //TODO: make alert for this, and option to add link
                                        }
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            // Price and Priority
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Perkiraan Harga', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF606772))),
                                    SizedBox(height: 8),
                                    Text('Rp ' + 127.toString(), style: TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Prioritas', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF606772))),
                                    SizedBox(height: 8),
                                    SmoothStarRating(
                                      allowHalfRating: false,
                                      color: Theme.of(context).primaryColor,
                                      borderColor: Colors.grey,
                                      starCount: 5,
                                      rating: 4,
                                      size: 16,
                                      isReadOnly: true,
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            // bottom button
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 30 - 30,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF15DBAB),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0.0,
                    ),
                    child: Text(
                      'Selesai',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
