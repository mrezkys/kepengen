import 'package:flutter/material.dart';
import 'package:kepengen/view/utils/gradient_background.dart';
import 'package:kepengen/view/widget/main_app_bar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(gradient: GradientBackground.gradient()),
                height: 170,
                width: MediaQuery.of(context).size.width,
                child: MainAppBar(
                  background: Colors.transparent,
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  title: 'Notification',
                  leftIconPath: 'assets/icons/Arrow-left.svg',
                  rightIconPath: 'assets/icons/More Square.svg',
                  leftIconOnPressed: () {
                    Navigator.pop(context);
                  },
                  rightIconOnPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 100),
                padding: EdgeInsets.symmetric(horizontal: 30),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(30)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Wishlist',
                                style: TextStyle(color: Color(0xFF606772), fontSize: 12),
                              ),
                              Text(
                                '20',
                                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 24),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Selesai',
                                style: TextStyle(color: Color(0xFF606772), fontSize: 12),
                              ),
                              Text(
                                '8',
                                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 24),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Belum',
                                style: TextStyle(color: Color(0xFF606772), fontSize: 12),
                              ),
                              Text(
                                '12',
                                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 24),
                              ),
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
        ),
      ),
    );
  }
}
