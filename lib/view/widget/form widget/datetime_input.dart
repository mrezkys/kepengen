import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kepengen/provider/wishlist_provider.dart';

// ignore: must_be_immutable
class DateTimeInput extends StatelessWidget {
  String title;
  WishlistProvider provider;
  DateTimeInput({this.provider, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500)),
          Container(
            margin: EdgeInsets.only(top: 8),
            color: Colors.transparent,
            // row : wrapper of 2 container
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Select Date
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    ).then((date) {
                      if (date != null) {
                        var formatter = DateFormat('yyyy-MM-dd');
                        var formattedDate = formatter.format(date);
                        provider.wishlistDeadlineDate = formattedDate;
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 15),
                    height: 50,
                    width: ((MediaQuery.of(context).size.width - 30 - 30) / 2) - 5, // divided by 2 ( 2 item in the row ) | 5 = space between
                    decoration: BoxDecoration(
                      color: (provider.wishlistDeadlineDate != null) ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/Calendar.svg', color: (provider.wishlistDeadlineDate != null) ? Colors.white : Colors.black),
                            SizedBox(width: 15),
                            (provider.wishlistDeadlineDate != null)
                                ? Text(provider.wishlistDeadlineDate, style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500))
                                : Text('Select Date', style: TextStyle(fontSize: 12, color: Color(0xFF606772))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // Select Time
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                            alwaysUse24HourFormat: true,
                          ),
                          child: child,
                        );
                      },
                    ).then((time) {
                      if (time != null) {
                        // i dont found a way to just parse the timeofday to datetime without the date
                        // thats why im using the "dummy date | datetime.now()" just to be a dummy date for the time
                        // because hive database cant save the datetime format, and i should parse the date & time to the string

                        //  the error would appear if i use the time.format(context), because the time will formattted based on the device timeformat
                        // and that will be a big problem, because we dont have a constant timeformat ( each device use different time format 14hours/12hours)
                        // and im deciding to use the 12 hours format (h:mm a) to save and parse the date time at wishlist_item_detail too

                        var now = DateTime.now();
                        var formattedDate = DateTime(now.year, now.month, now.day, time.hour, time.minute, 00);

                        // this will be formatted the formatted date to formatted time , because we just need the time.

                        var formatter = DateFormat('HH:mm:ss');
                        var formattedTime = formatter.format(formattedDate);

                        provider.wishlistDeadlineTime = formattedTime;
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 15),
                    height: 50,
                    width: ((MediaQuery.of(context).size.width - 30 - 30) / 2) - 5, // divided by 2 ( 2 item in the row ) | 5 = space between
                    decoration: BoxDecoration(
                      color: (provider.wishlistDeadlineTime != null) ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/Time Square.svg', color: (provider.wishlistDeadlineTime != null) ? Colors.white : Colors.black),
                            SizedBox(width: 15),
                            (provider.wishlistDeadlineTime != null)
                                ? Text(provider.wishlistDeadlineTime, style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500))
                                : Text('Select Time', style: TextStyle(fontSize: 12, color: Color(0xFF606772))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
