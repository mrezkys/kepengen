import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kepengen/model/core/wishlist.dart';
import 'package:kepengen/model/helper/dummy_helper.dart';
import 'package:kepengen/provider/app_state_provider.dart';
import 'package:kepengen/provider/local_database.dart';
import 'package:kepengen/provider/wishlist_provider.dart';
import 'package:kepengen/view/screen/home_page.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kepengen/view/screen/user%20page/notification_page.dart';
import 'package:kepengen/view/screen/user%20page/profile_page.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {});
  final MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String payload) async {
    if (payload != null) {
      print('Notification payload : ' + payload);
    }
  });

  wishslistAlarm();

  await DummyHelper.createDummyImage();
  runApp(MyApp());
}

alarmScheduler(datetime, itemName, itemId) async {
  var scheduleNotificationDatetime = DateTime.parse(datetime);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails('alarm_notif', 'alarm_notif', 'Channel for alarm notification', largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'));
  var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.schedule(itemId, 'title : ' + itemName, 'ini detik ke ', scheduleNotificationDatetime, platformChannelSpecifics);
}

wishslistAlarm() async {
  List<Wishlist> wishlist = await DBProvider.db.getAllWishlist();
  print(wishlist.length);
  for (var i = 0; i < wishlist.length; i++) {
    print(i);
    alarmScheduler(wishlist[i].deadline, wishlist[i].name, wishlist[i].id);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xFF3195F0));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
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
