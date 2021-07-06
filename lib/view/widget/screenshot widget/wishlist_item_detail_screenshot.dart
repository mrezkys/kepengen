import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kepengen/model/core/wishlist.dart';
import 'package:kepengen/model/helper/rupiah_formatter.dart';
import 'package:kepengen/view/utils/gradient_background.dart';
import 'package:kepengen/view/widget/main_app_bar.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

Widget wishlistItemDetailScreenshot({Wishlist itemData, BuildContext context, CountdownTimerController countdownTimerController}) {
  return MediaQuery(
    data: MediaQueryData(),
    child: Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: GradientBackground.gradient(type: 1)),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              bottom: 15,
              child: Transform.scale(
                alignment: Alignment.bottomCenter,
                scale: 0.85,
                child: Container(
                  decoration: BoxDecoration(gradient: GradientBackground.gradient()),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      ListView(
                        children: <Widget>[
                          // appbar
                          MainAppBar(
                              background: Colors.transparent,
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              title: 'Wishlist Detail',
                              leftIconPath: 'assets/icons/Arrow-left.svg',
                              rightIconPath: 'assets/icons/Info Square.svg',
                              leftIconOnPressed: () {
                                Navigator.pop(context);
                              },
                              rightIconOnPressed: () {}),
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
                                      (itemData.status == 0) ? 'InCompleted' : 'Completed',
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
                                    CountdownTimer(
                                      controller: countdownTimerController,
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      onEnd: () {
                                        countdownTimerController.dispose();
                                      },
                                    ),
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
                                    image: DecorationImage(fit: BoxFit.cover, image: FileImage(File(itemData.photo))),
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
                                                Text(itemData.name, style: TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                                                SizedBox(height: 5),
                                                Text('Target : ' + itemData.deadline.substring(0, 10), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            flex: 4,
                                            child: Center(
                                              child: IconButton(
                                                icon: SvgPicture.asset('assets/icons/Send.svg'),
                                                onPressed: () {},
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
                                          Flexible(
                                            flex: 8,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Perkiraan Harga', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF606772))),
                                                SizedBox(height: 8),
                                                AutoSizeText(
                                                  RupiahFormatter.formatCurrency.format(itemData.price),
                                                  maxLines: 1,
                                                  style: TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            flex: 4,
                                            child: Column(
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
                                                  rating: itemData.priority,
                                                  size: 16,
                                                  isReadOnly: true,
                                                )
                                              ],
                                            ),
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
                                primary: (itemData.status == 0) ? Color(0xFF15DBAB) : Color(0xFFDCB30B),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                elevation: 0.0,
                              ),
                              child: Text(
                                (itemData.status == 0) ? 'Selesaikan' : 'Telah Selesai',
                                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              height: MediaQuery.of(context).size.height * 15 / 100,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 61,
                    width: 61,
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/qr.png'))),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Kepengen', style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 14)),
                      SizedBox(
                        height: 4,
                      ),
                      Text('Pengen aja dulu, belinya nanti.\nYang penting jangan lupa...', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.5))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
