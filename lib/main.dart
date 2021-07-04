import 'package:flutter/material.dart';
import 'package:kepengen/model/helper/dummy_helper.dart';
import 'package:kepengen/provider/bottom_navigation_bar_provider.dart';
import 'package:kepengen/provider/wishlist_provider.dart';
import 'package:kepengen/view/screen/home_page.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kepengen/view/screen/user%20page/notification_page.dart';
import 'package:kepengen/view/screen/user%20page/profile_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DummyHelper.createDummyImage();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xFF3195F0));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/notification': (context) => NotificationPage(),
          '/profile': (context) => ProfilePage(),
        },
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Color(0xFF1C2635)),
            bodyText2: TextStyle(color: Color(0xFF1C2635)),
          ),
          canvasColor: Colors.white,
          fontFamily: 'Open Sans',
          accentColor: Color(0xFFEEF4FB),
          primaryColor: Color(0xFF3195F0),
        ),
      ),
    );
  }
}
