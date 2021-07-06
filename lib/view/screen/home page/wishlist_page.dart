import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kepengen/provider/local_database.dart';
import 'package:kepengen/provider/wishlist_provider.dart';
import 'package:kepengen/view/modal/wishlist_page_filter_modal.dart';
import 'package:kepengen/view/utils/gradient_background.dart';
import 'package:kepengen/view/widget/main_app_bar.dart';
import 'package:kepengen/view/widget/skeleton_container.dart';
import 'package:kepengen/view/widget/wishlist_item_tile.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  Future listWishlist;

  @override
  void initState() {
    super.initState();
    listWishlist = getListWishlist();
  }

  getListWishlist({String filter}) async {
    var _listWishlist = await DBProvider.db.getAllWishlist(filter: filter);
    return _listWishlist;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: <Widget>[
          // Top Container
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(gradient: GradientBackground.gradient()),
            child: Column(
              children: <Widget>[
                MainAppBar(
                  background: Colors.transparent,
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  title: 'Wishlist',
                  leftIconPath: 'assets/icons/Profile.svg',
                  rightIconPath: 'assets/icons/Notification.svg',
                  leftIconOnPressed: () {},
                  rightIconOnPressed: () {
                    Navigator.of(context).pushNamed('/notification');
                  },
                ),
                // Search and filter box
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        elevation: 0.0,
                        isDismissible: true,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return WishlistPageFilterModal();
                        });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 25),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.22), borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/Filter.svg', color: Colors.white),
                        SizedBox(width: 20),
                        Text(
                          'Filter Wishlist',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 120),
            child: Consumer<WishlistProvider>(
              builder: (context, _wishlistProvider, _) {
                checkTrueFilter() {
                  if (_wishlistProvider.filterTerdekat == true || _wishlistProvider.filterTerdekat == true || _wishlistProvider.filterTerdekat == true || _wishlistProvider.filterTerdekat == true) {
                    return true;
                  } else {
                    return false;
                  }
                }

                checkTrueSort() {
                  if (_wishlistProvider.isCompleted == true || _wishlistProvider.isInCompleted == true) {
                    return true;
                  } else {
                    return false;
                  }
                }

                if (checkTrueSort() == false && checkTrueFilter() == false) {
                  listWishlist = getListWishlist(filter: 'all');
                }

                if (_wishlistProvider.isCompleted == true && checkTrueFilter() == false) {
                  listWishlist = getListWishlist(filter: 'completed');
                } else if (_wishlistProvider.isInCompleted == true && checkTrueFilter() == false) {
                  listWishlist = getListWishlist(filter: 'incompleted');
                }

                //  terdekat ---------------------------------------------------------------
                // terdekat without filter
                if (_wishlistProvider.filterTerdekat == true && checkTrueSort() == false) {
                  listWishlist = getListWishlist(filter: 'terdekat'); // -------------------
                }
                // with completed filter
                else if (_wishlistProvider.filterTerdekat == true && _wishlistProvider.isCompleted == true) {
                  print('eee');
                  listWishlist = getListWishlist(filter: 'terdekat & Completed'); // -------------------
                }
                // with incompleted filter
                else if (_wishlistProvider.filterTerdekat == true && _wishlistProvider.isInCompleted == true) {
                  listWishlist = getListWishlist(filter: 'terdekat & inCompleted'); // -------------------
                }
                //  ------------------------------------------------------------------------

                //  terpengen ---------------------------------------------------------------
                if (_wishlistProvider.filterTerpengen == true && checkTrueSort() == false) {
                  print('exccc');
                  listWishlist = getListWishlist(filter: 'terpengen');
                }
                // with completed filter
                else if (_wishlistProvider.filterTerpengen == true && _wishlistProvider.isCompleted == true) {
                  print('exc');
                  listWishlist = getListWishlist(filter: 'terpengen & Completed');
                }
                // with incompleted filter
                else if (_wishlistProvider.filterTerpengen == true && _wishlistProvider.isInCompleted == true) {
                  listWishlist = getListWishlist(filter: 'terpengen & inCompleted');
                }
                //  ------------------------------------------------------------------------

                //  termurah ---------------------------------------------------------------
                if (_wishlistProvider.filterTermurah == true && checkTrueSort() == false) {
                  listWishlist = getListWishlist(filter: 'termurah');
                } else if (_wishlistProvider.filterTermurah == true && _wishlistProvider.isCompleted == true) {
                  listWishlist = getListWishlist(filter: 'termurah & Completed');
                } else if (_wishlistProvider.filterTermurah == true && _wishlistProvider.isInCompleted == true) {
                  listWishlist = getListWishlist(filter: 'termurah & inCompleted');
                }
                //  ------------------------------------------------------------------------

                //  termahal ---------------------------------------------------------------
                if (_wishlistProvider.filterTermahal == true && checkTrueSort() == false) {
                  listWishlist = getListWishlist(filter: 'termahal');
                } else if (_wishlistProvider.filterTermahal == true && _wishlistProvider.isCompleted == true) {
                  listWishlist = getListWishlist(filter: 'termahal & Completed');
                } else if (_wishlistProvider.filterTermahal == true && _wishlistProvider.isInCompleted == true) {
                  listWishlist = getListWishlist(filter: 'termahal & inCompleted');
                }
                //  ------------------------------------------------------------------------

                return FutureBuilder(
                  future: listWishlist,
                  builder: (_, data) {
                    if (data.connectionState == ConnectionState.done) {
                      if (data.data.isNotEmpty) {
                        return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.data.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 15);
                          },
                          itemBuilder: (context, index) {
                            return WishlistItemTile(
                              itemData: data.data[index],
                            );
                          },
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width - 60,
                          color: Colors.white,
                          child: SvgPicture.asset('assets/images/no-data.svg'),
                        );
                      }
                    } else {
                      return ListView.separated(
                        padding: EdgeInsets.only(bottom: 100),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: SkeletonContainer.square(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              borderRadius: 10,
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
