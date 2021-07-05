import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:kepengen/model/core/wishlist.dart';
import 'package:kepengen/model/helper/rupiah_formatter.dart';
import 'package:kepengen/model/helper/value_checker.dart';
import 'package:kepengen/provider/local_database.dart';
import 'package:kepengen/view/modal/wishlist_item_detail_page_menu_modal.dart';
import 'package:kepengen/view/utils/gradient_background.dart';
import 'package:kepengen/view/widget/main_app_bar.dart';
import 'package:kepengen/view/widget/screenshot%20widget/wishlist_item_detail_screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class WishlistItemDetailPage extends StatelessWidget {
  Wishlist itemData;
  WishlistItemDetailPage({@required this.itemData});

  @override
  Widget build(BuildContext context) {
    // TODO: buat kaya notifikasi kalau sudah completed
    CountdownTimerController _countdownTimerController = CountdownTimerController(endTime: DateTime.parse(itemData.deadline).millisecondsSinceEpoch);

    ScreenshotController screenshotController = ScreenshotController();

    Future<bool> _requestPermission(Permission permission) async {
      if (await permission.isGranted) {
        return true;
      } else {
        var result = await permission.request();
        if (result == PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
      }
    }

    takeAndSaveScreenshot() async {
      String fileName = "Wishlist ${DateTime.now().millisecondsSinceEpoch.toString()}";
      Directory directory;
      if (await _requestPermission(Permission.storage)) {
        // Process to get the directory path /Pictures/Kepengen
        directory = await getExternalStorageDirectory();
        String newPath = "";
        List<String> folders = directory.path.split("/");
        for (int i = 1; i < folders.length; i++) {
          String folder = folders[i];
          if (folder != 'Android') {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        print(newPath);
        newPath = newPath + '/Pictures/Kepengen';
        directory = Directory(newPath);

        // Checking the directory | is exist or not, if not then create
        if (!await directory.exists()) {
          print(await Permission.storage.isGranted); // print Granted status
          await directory.create(recursive: true);
        }

        var file = await screenshotController.captureFromWidget(wishlistItemDetailScreenshot(itemData: itemData, context: context, countdownTimerController: _countdownTimerController));
        var result = await ImageGallerySaver.saveImage(
          file,
          quality: 100,
          name: 'Kepengen' + "/$fileName",
        );
        print(result);
        final imagePath = result['filePath'].toString().replaceAll(RegExp('file://'), '').replaceAll(RegExp('%20'), ' ');
        print(imagePath);
        return imagePath;
      } else {
        print('not granted');
        return 'error';
      }
    }

    shareImage(String path, Wishlist itemData) {
      try {
        Share.shareFiles(
          [path],
          text: 'Lihat nih wishlist saya ${itemData.name}, seharga ${itemData.price} di ${itemData.link}. Kamu bisa simpan Wishlist dengan Aplikasi Kepengen, download di playstore : ',
          subject: 'Lihat nih Wishlist saya,  ${itemData.name}',
        );
      } catch (e) {
        print(e);
      }
    }

    screenshotAction({dynamic screenshotPath, Wishlist itemData}) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            content: Container(
              width: MediaQuery.of(context).size.width * 80 / 100,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width * 80 / 10,
                    height: 240,
                    color: Colors.black,
                    child: Image.file(
                      File(screenshotPath),
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('share!');
                      shareImage(screenshotPath, itemData);
                    },
                    child: Text('Bagikan Screenshot'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Lain Kali', style: TextStyle(color: Theme.of(context).primaryColor)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      elevation: 0.0,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    shareAction({@required Wishlist itemData}) {
      shareImage(itemData.photo, itemData);
    }

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
                  rightIconOnPressed: () async {
                    var returnValue = showModalBottomSheet(
                        elevation: 0.0,
                        isDismissible: true,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return WishlistItemDetailPageMenuModal(
                            wishlistId: itemData.id,
                          );
                        });
                    var value = await returnValue;
                    print(value);
                    if (value == 'screenshot') {
                      var screenshotPath = await takeAndSaveScreenshot();
                      return screenshotAction(screenshotPath: screenshotPath, itemData: itemData);
                    }

                    if (value == 'share') {
                      return shareAction(itemData: itemData);
                    }

                    if (value == 'delete') {
                      await DBProvider.db.deleteWishlist(itemData.id);
                      Navigator.of(context).pop();
                    }
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
                            controller: _countdownTimerController,
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                            onEnd: () {
                              _countdownTimerController.dispose();
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
                                      // TODO: make notification if this clicked but the link is null
                                      icon: SvgPicture.asset('assets/icons/Send.svg'),
                                      onPressed: () async {
                                        if (ValueChecker.isNullOrEmpty(itemData.link)) {
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              content: Text(
                                                'Wishlist ini tidak memiliki alamat untuk dituju. Silahkan tambahkan alamat pada menu edit.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                                              ),
                                            ),
                                          );
                                        } else {
                                          final Uri _lun = Uri(
                                            scheme: 'http',
                                            path: itemData.link,
                                          );
                                          launch(_lun.toString());
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
                    onPressed: () {
                      print('clicked');
                      DBProvider.db.setCompletedWishlist(itemData.id).then((value) => print(value));
                    },
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
    );
  }
}
