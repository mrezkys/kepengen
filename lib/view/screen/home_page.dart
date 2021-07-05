import 'package:flutter/material.dart';
import 'package:kepengen/provider/app_state_provider.dart';
import 'package:kepengen/view/screen/home%20page/dashboard_page.dart';
import 'package:kepengen/view/screen/home%20page/wishlist_page.dart';
import 'package:kepengen/view/widget/bottom_navbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _tabPage = [
    DashboardPage(),
    SizedBox(),
    WishlistPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AppStateProvider>(
          builder: (context, bottomNavBar, child) {
            return Stack(children: [
              _tabPage.elementAt(bottomNavBar.currentIndex),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomNavbar(),
              )
            ]);
          },
        ),
      ),
    );
  }
}
