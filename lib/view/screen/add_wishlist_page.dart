import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kepengen/model/core/wishlist.dart';
import 'package:kepengen/model/helper/dummy_helper.dart';
import 'package:kepengen/model/helper/value_checker.dart';
import 'package:kepengen/provider/local_database.dart';
import 'package:kepengen/provider/wishlist_provider.dart';
import 'package:kepengen/view/utils/round_slider_track_shape.dart';
import 'package:kepengen/view/widget/main_app_bar.dart';
import 'package:provider/provider.dart';

class AddWishlistPage extends StatefulWidget {
  @override
  _AddWishlistPageState createState() => _AddWishlistPageState();
}

class _AddWishlistPageState extends State<AddWishlistPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WishlistProvider>(context);
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        height: 105,
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: 65,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30),
              elevation: 0.0,
              primary: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/icons/Bookmark.svg', color: Colors.white),
                Text('Simpan', style: TextStyle(fontSize: 18)),
                SizedBox(),
              ],
            ),
            onPressed: () async {
              if (provider.formChecker() == true) {
                print(await DBProvider.db.addWishlist(Wishlist(
                  name: provider.wishlistName,
                  link: provider.wishlistLink,
                  price: provider.wishlistPrice,
                  deadline: provider.wishlistDeadlineDate + ' ' + provider.wishlistDeadlineTime,
                  notification: provider.wishlistNotification,
                  photo: await provider.saveWishlistPhoto(provider.wishlistPickedPhoto) ?? await DummyHelper.getImageDummy(),
                  status: 0,
                  priority: provider.wishlistPriority,
                )));
                provider.formReset();
                Navigator.of(context).pop();
              } else {
                print('ulangi');
              }
            },
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            MainAppBar(
              background: Colors.white,
              iconColor: Colors.black,
              textColor: Colors.black,
              title: 'Add Wishlist',
              leftIconPath: 'assets/icons/Arrow-left.svg',
              rightIconPath: 'assets/icons/Info Square.svg',
              leftIconOnPressed: () {
                provider.formReset();
                Navigator.of(context).pop();
              },
              rightIconOnPressed: () {},
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 30),
              margin: EdgeInsets.only(top: 30),
              child: Column(
                children: <Widget>[
                  // Wishlist Name
                  TextInput(
                    inputTitle: 'Nama Wishlist *',
                    hint: 'Playstation 5',
                    onChanged: (value) {
                      provider.wishlistName = value;
                      print(provider.wishlistName);
                    },
                  ),
                  CustomInputError(
                    isError: (ValueChecker.isNullOrEmpty(provider.wishlistName)) ? true : false,
                    message: 'Nama tidak boleh kosong',
                  ),
                  SizedBox(height: 20),
                  // WIshlist Link
                  TextInput(
                    inputTitle: 'Link Wishlist',
                    hint: 'Playstation 5',
                    onChanged: (value) {
                      provider.wishlistLink = value;
                      print(provider.wishlistLink);
                    },
                  ),
                  SizedBox(height: 20),
                  // Wishlist Price
                  PriceInput(
                    inputTitle: 'Harga Wishlist *',
                    hint: '5.200.000',
                    onChanged: (value) {
                      var newVal = value.replaceAll(',', ''); // because the ouput of the input is xxx,xxx,xxx but i need the xxxxxxxxx format to parse string
                      try {
                        provider.wishlistPrice = int.parse(newVal);
                        print(provider.wishlistPrice);
                      } catch (e) {
                        print('the input value is not a number');
                        print(e);
                      }
                    },
                  ),
                  CustomInputError(
                    isError: (ValueChecker.isNullOrEmpty(provider.wishlistPrice)) ? true : false,
                    message: 'Harga tidak boleh kosong',
                  ),
                  SizedBox(height: 25),
                  // Wishlist DateTime
                  DateTimeInput(
                    provider: provider,
                    title: 'Pilih Tanggal & Waktu *',
                  ),
                  CustomInputError(
                    isError: (ValueChecker.isNullOrEmpty(provider.wishlistDeadlineTime) || ValueChecker.isNullOrEmpty(provider.wishlistDeadlineDate)) ? true : false,
                    message: 'Tanggal dan Waktu tidak boleh kosong',
                  ),
                  SizedBox(height: 25),
                  // Wishlist Photo
                  PhotoUpload(
                    provider: provider,
                    title: 'Wishlist Foto *',
                  ),
                  SizedBox(height: 25),
                  // Wishlist Priority
                  PriorityInput(
                    provider: provider,
                  ),
                  SizedBox(height: 15),
                  NotificationSwitch(
                    provider: provider,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoUpload extends StatelessWidget {
  WishlistProvider provider;
  String title;
  PhotoUpload({this.provider, this.title});

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
                // Photo picker option
                GestureDetector(
                  onTap: () async {
                    var image = await provider.wishlistPhotoPicker();
                    provider.wishlistPickedPhoto = image;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 15),
                    height: 50,
                    width: ((MediaQuery.of(context).size.width - 30 - 30) / 2) - 5, // divided by 2 ( 2 item in the row ) | 5 = space between
                    decoration: BoxDecoration(
                      color: (provider.wishlistPickedPhoto != null) ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/Folder.svg', color: (provider.wishlistPickedPhoto != null) ? Colors.white : Colors.black),
                            SizedBox(width: 15),
                            Text('Unggah', style: TextStyle(fontSize: 12, color: (provider.wishlistPickedPhoto != null) ? Colors.white : Color(0xFF606772))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // Dummy option
                GestureDetector(
                  onTap: () {
                    provider.wishlistPickedPhoto = null;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 15),
                    height: 50,
                    width: ((MediaQuery.of(context).size.width - 30 - 30) / 2) - 5, // divided by 2 ( 2 item in the row ) | 5 = space between
                    decoration: BoxDecoration(
                      color: (provider.wishlistPickedPhoto != null) ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/Folder.svg', color: (provider.wishlistPickedPhoto != null) ? Colors.black : Colors.white), //TODO: update pubspec : add document icon
                            SizedBox(width: 15),
                            Text('Dummy', style: TextStyle(fontSize: 12, color: (provider.wishlistPickedPhoto != null) ? Color(0xFF606772) : Colors.white)),
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

class NotificationSwitch extends StatelessWidget {
  WishlistProvider provider;
  NotificationSwitch({this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Dapatkan Pemberitahuan', style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500)),
          CupertinoSwitch(
            value: provider.wishlistNotification,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              provider.wishlistNotification = value;
              print(value);
              print(provider.wishlistNotification);
            },
          ),
        ],
      ),
    );
  }
}

class PriorityInput extends StatelessWidget {
  WishlistProvider provider;
  PriorityInput({this.provider});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Skala Priotitas : ' + (provider.wishlistPriority).toInt().toString(), style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500)),
          SliderTheme(
            data: SliderThemeData(
              trackShape: RoundSliderTrackShape(),
              trackHeight: 5,
            ),
            child: Slider(
              value: provider.wishlistPriority,
              min: 0,
              max: 5,
              label: (provider.wishlistPriority).round().toString(),
              divisions: 5,
              onChanged: (value) {
                provider.wishlistPriority = value;
                print(provider.wishlistPriority);
              },
            ),
          ),
        ],
      ),
    );
  }
}

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

class TextInput extends StatelessWidget {
  Function onChanged;
  final String inputTitle;
  final String hint;
  TextInput({this.inputTitle, this.hint, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(inputTitle, style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500)),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).accentColor,
            ),
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 20),
                hintText: hint,
                hintStyle: TextStyle(color: Color(0xFFB3BECC)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PriceInput extends StatelessWidget {
  Function onChanged;
  final String inputTitle;
  final String hint;
  PriceInput({this.inputTitle, this.hint, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(inputTitle, style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500)),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).accentColor,
            ),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                    color: Color(0xFFDBE5F0),
                  ),
                  child: Text('Rp', style: TextStyle(color: Color(0xFF8994A1))),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30 - 30 - 50, // 30 = parent padding | 50 = left container width
                  child: TextField(
                    onChanged: onChanged,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      CurrencyTextInputFormatter(
                        symbol: '',
                        decimalDigits: 0,
                      )
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 20),
                      hintText: hint,
                      hintStyle: TextStyle(color: Color(0xFFB3BECC)),
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

class CustomInputError extends StatelessWidget {
  String message;
  bool isError;
  CustomInputError({this.message, this.isError});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isError,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(message, style: TextStyle(fontSize: 12, color: Colors.blueGrey[700])),
      ),
    );
  }
}
