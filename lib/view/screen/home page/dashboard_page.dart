import 'package:flutter/material.dart';
import 'package:kepengen/model/core/wishlist.dart';
import 'package:kepengen/provider/local_database.dart';
import 'package:kepengen/view/screen/wishlist_item_detail_page.dart';
import 'package:kepengen/view/utils/gradient_background.dart';
import 'package:kepengen/view/widget/main_app_bar.dart';

import 'package:kepengen/view/widget/featured_wishlist_item.dart';
import 'package:kepengen/view/widget/dashboard_short_info.dart';
import 'package:kepengen/view/widget/skeleton_container.dart';
import 'package:kepengen/view/widget/wishlist_item_tile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with TickerProviderStateMixin {
  TabController _tabController;
  PageController _topContainerPageController = PageController(initialPage: 0);

  Future shortInfoData;
  Future featuredItemData;
  Future fiveRandomWishlist;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    shortInfoData = getShortInfoData();
    featuredItemData = getFeaturedItemData();
    fiveRandomWishlist = getFiveRandomWishlist();
  }

  getShortInfoData() async {
    var _wishlistTotalPrice = await DBProvider.db.getWishlistTotalPrice();
    var _wishlistTotalSpending = await DBProvider.db.getWishlistTotalSpending();
    return {
      'total_price': _wishlistTotalPrice,
      'total_spending': _wishlistTotalSpending,
    };
  }

  getFeaturedItemData() async {
    var _terdekat = await DBProvider.db.getFeaturedWishlist('terdekat');
    var _terpengen = await DBProvider.db.getFeaturedWishlist('terpengen');
    var _termurah = await DBProvider.db.getFeaturedWishlist('termurah');
    var _termahal = await DBProvider.db.getFeaturedWishlist('termahal');
    return {
      'terdekat': _terdekat,
      'terpengen': _terpengen,
      'termurah': _termurah,
      'termahal': _termahal,
    };
  }

  getFiveRandomWishlist() async {
    List<Wishlist> _fiveWishlist = await DBProvider.db.getFiveRandomWishlist();
    return _fiveWishlist;
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
                // App Bar
                MainAppBar(
                  background: Colors.transparent,
                  title: 'Dashboard',
                  leftIconPath: 'assets/icons/Profile.svg',
                  rightIconPath: 'assets/icons/Notification.svg',
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leftIconOnPressed: () {
                    Navigator.of(context).pushNamed('/profile');
                  },
                  rightIconOnPressed: () {
                    Navigator.of(context).pushNamed('/notification');
                  },
                ),
                // Short info
                FutureBuilder(
                  future: shortInfoData,
                  builder: (_, data) {
                    return Container(
                      color: Colors.transparent,
                      height: 200.0 - 60.0 - 10 - 10 - 20, // 200 = Parent Container Height | 60 = App bar height | 20 = bottom space | 10 = margin bottom | 10 = Smooth Scroll Indicator Height
                      child: PageView(
                        controller: _topContainerPageController,
                        scrollDirection: Axis.horizontal,
                        children: [
                          DashboardShortInfo(
                            type: 'Total Pengeluaran',
                            data: (data.hasData) ? data.data['total_spending'] : 0,
                          ),
                          DashboardShortInfo(
                            type: 'Total Wishlist',
                            data: (data.hasData) ? data.data['total_price'] : 0,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // margin 10
                SizedBox(height: 10),
                // Pageview Indicator
                Container(
                  height: 10,
                  alignment: Alignment.center,
                  child: SmoothPageIndicator(
                    controller: _topContainerPageController,
                    count: 2,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      dotColor: Colors.white.withOpacity(0.3),
                      activeDotColor: Colors.white.withOpacity(0.5),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          // Featured Wishlist Tab Bar
          Container(
            height: 60,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Color(0xFF1C2635),
              unselectedLabelColor: Color(0xFF9EA4AD),
              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              unselectedLabelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              physics: BouncingScrollPhysics(),
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Terdekat',
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Terpengen',
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Termurah',
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Termahal',
                    ),
                  ),
                ),
              ],
            ),
          ),
          //  Featured Tab Bar View
          Container(
            height: MediaQuery.of(context).size.width - 30 - 30,
            child: FutureBuilder(
              future: featuredItemData,
              builder: (_, data) {
                if (data.connectionState == ConnectionState.done) {
                  print('featured tab data : ' + data.data.toString());
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      FeaturedWishlistItem(),
                      FeaturedWishlistItem(),
                      FeaturedWishlistItem(),
                      FeaturedWishlistItem(),
                    ],
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: SkeletonContainer.square(
                      height: MediaQuery.of(context).size.width - 30 - 30, // because there is padding 30 px x 2
                      width: MediaQuery.of(context).size.width,
                      borderRadius: 10,
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 25),
          // Additional Text
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Text('ini wishlist mu yang lain...', style: TextStyle(fontSize: 14, color: Color(0xFF606772))),
          ),
          SizedBox(height: 20),
          // 5 Wishlist Card
          FutureBuilder(
            future: fiveRandomWishlist,
            builder: (_, item) {
              if (item.connectionState == ConnectionState.done) {
                return ListView.separated(
                  padding: EdgeInsets.only(bottom: 100),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: item.data.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    return WishlistItemTile(
                      index: index,
                      data: item.data[index],
                    );
                  },
                );
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
        ],
      ),
    );
  }
}
