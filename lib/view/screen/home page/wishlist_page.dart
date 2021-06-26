import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kepengen/model/helper/value_checker.dart';
import 'package:kepengen/provider/local_database.dart';
import 'package:kepengen/view/modal/wishlist_page_filter_modal.dart';
import 'package:kepengen/view/screen/wishlist_item_detail_page.dart';
import 'package:kepengen/view/utils/gradient_background.dart';
import 'package:kepengen/view/widget/main_app_bar.dart';
import 'package:kepengen/view/widget/skeleton_container.dart';
import 'package:kepengen/view/widget/wishlist_item_tile.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  TextEditingController _searchController = TextEditingController();
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

  filterSearch(String query) async {
    var dummySearchlist = await getListWishlist();
    if (query.isNotEmpty) {
      var dummyListData = [];
      dummySearchlist.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        listWishlist = Future.value(dummyListData);
      });
      print(dummyListData);
      return;
    } else {
      listWishlist = getListWishlist();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: <Widget>[
          // Top Container
          Container(
            height: 200,
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
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                  height: 200.0 - 60.0, // 200 = Parent Container Height | 60 = App bar height
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        width: MediaQuery.of(context).size.width - 30 - 30 - 50 - 15, // 30 = parent container padding | 15 = space | 50 = filter box
                        height: 50,
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(5)),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              filterSearch(value);
                            });
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Cari Wishlist...',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                            icon: SvgPicture.asset(
                              'assets/icons/Search.svg',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
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
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: SvgPicture.asset('assets/icons/Filter.svg', color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 120),
            child: FutureBuilder(
              future: listWishlist,
              builder: (_, data) {
                print(data.data);
                // TODO: fix error because of no error handler if return data is empty
                if (data.connectionState == ConnectionState.done) {
                  if (!ValueChecker.isNullOrEmpty(data.data)) {
                    return ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.data.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 15);
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: WishlistItemTile(
                            index: index,
                            data: data.data[index],
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => WishlistItemDetailPage(
                                  index: index,
                                ),
                              ),
                            );
                          },
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
            ),
          ),
        ],
      ),
    );
  }
}
