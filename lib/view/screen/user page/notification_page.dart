import 'package:flutter/material.dart';
import 'package:kepengen/model/core/wishlist.dart';
import 'package:kepengen/model/helper/rupiah_formatter.dart';
import 'package:kepengen/provider/local_database.dart';
import 'package:kepengen/view/widget/main_app_bar.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Future listWishlist;

  @override
  void initState() {
    super.initState();
    listWishlist = getListWishlist();
  }

  getListWishlist() async {
    var listWishlist = await DBProvider.db.getOutdatedWishlist();
    return listWishlist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            MainAppBar(
              background: Theme.of(context).primaryColor,
              iconColor: Colors.white,
              textColor: Colors.white,
              title: 'Notification',
              leftIconPath: 'assets/icons/Arrow-left.svg',
              leftIconOnPressed: () {
                Navigator.pop(context);
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 30),
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: FutureBuilder(
                future: listWishlist,
                builder: (context, data) {
                  List<Wishlist> listWishlist = data.data;
                  if (data.connectionState == ConnectionState.done) {
                    if (listWishlist.isNotEmpty) {
                      return ListView.separated(
                        itemCount: listWishlist.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 15);
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Pengingat Wishlist',
                                      style: TextStyle(fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      listWishlist[index].deadline,
                                      style: TextStyle(color: Color(0xFF606772), fontSize: 12),
                                    )
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Hari ini waktunya kamu beli ${listWishlist[index].name} seharga ${RupiahFormatter.formatCurrency.format(listWishlist[index].price)}',
                                  style: TextStyle(color: Color(0xFF606772), fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Container(
                        alignment: Alignment.topCenter,
                        child: Text('Belum ada notifikasi'),
                      );
                    }
                  } else {
                    return Container(
                      alignment: Alignment.topCenter,
                      child: Text('data'),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
