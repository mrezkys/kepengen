import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kepengen/provider/bottom_navigation_bar_provider.dart';
import 'package:kepengen/view/screen/add_wishlist_page.dart';
import 'package:kepengen/view/utils/gradient_background.dart';
import 'package:provider/provider.dart';

class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final keyOne = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarProvider>(
      builder: (context, bottomNavigationBar, child) {
        return Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(top: BorderSide(color: Color(0xFFDFDFDF), width: 1)),
                  ),
                  child: BottomNavigationBar(
                    onTap: (index) {
                      bottomNavigationBar.currentIndex = index;
                    },
                    currentIndex: bottomNavigationBar.currentIndex,
                    type: BottomNavigationBarType.fixed,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    selectedItemColor: Colors.black,
                    unselectedItemColor: Colors.black.withOpacity(0.3),
                    items: [
                      BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/Home.svg'), label: ''),
                      BottomNavigationBarItem(icon: SizedBox(), label: ''),
                      BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/Bookmark.svg'), label: ''),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(45 / 360),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(gradient: GradientBackground.gradient(), borderRadius: BorderRadius.circular(15)),
                    child: RotationTransition(
                        turns: AlwaysStoppedAnimation(45 / 360),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation(45 / 360),
                          child: Material(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.transparent,
                            child: RotationTransition(
                              turns: AlwaysStoppedAnimation(90 / 360),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                splashColor: Colors.black.withOpacity(0.2),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (builder) => AddWishlistPage()));
                                },
                                child: RotationTransition(
                                  turns: AlwaysStoppedAnimation(45 / 360),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 42,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
