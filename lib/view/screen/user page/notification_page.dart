import 'package:flutter/material.dart';
import 'package:kepengen/view/widget/main_app_bar.dart';

class NotificationPage extends StatelessWidget {
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
              rightIconPath: 'assets/icons/More Square.svg',
              leftIconOnPressed: () {
                Navigator.pop(context);
              },
              rightIconOnPressed: () {},
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 30),
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: ListView.separated(
                itemCount: 15,
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
                              'Peringatan',
                              style: TextStyle(fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '12/10/2021',
                              style: TextStyle(color: Color(0xFF606772), fontSize: 12),
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'BuildContext instance which gets passed to the builder of a widget in order to let it know where it is inside the Widget Tree of your app.',
                          style: TextStyle(color: Color(0xFF606772), fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
