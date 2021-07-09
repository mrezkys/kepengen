import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kepengen/provider/wishlist_provider.dart';

// ignore: must_be_immutable
class NotificationSwitch extends StatelessWidget {
  WishlistProvider provider;
  NotificationSwitch({this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Dapatkan Pemberitahuan', style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500)),
          CupertinoSwitch(
            value: provider.wishlistNotification,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              provider.wishlistNotification = value;
              print(value);
              print(provider.wishlistNotification);
            },
          ),
        ],
      ),
    );
  }
}
