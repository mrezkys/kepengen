import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kepengen/model/core/wishlist.dart';
import 'package:kepengen/model/helper/dummy_helper.dart';
import 'package:kepengen/model/helper/value_checker.dart';
import 'package:kepengen/provider/local_database.dart';
import 'package:kepengen/provider/wishlist_provider.dart';
import 'package:kepengen/view/widget/form%20widget/custom_input_error.dart';
import 'package:kepengen/view/widget/form%20widget/datetime_input.dart';
import 'package:kepengen/view/widget/form%20widget/notification_switch.dart';
import 'package:kepengen/view/widget/form%20widget/photo_upload.dart';
import 'package:kepengen/view/widget/form%20widget/price_input.dart';
import 'package:kepengen/view/widget/form%20widget/priority_input.dart';
import 'package:kepengen/view/widget/form%20widget/text_input.dart';
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
                // TODO: change to push replacement because it still can be backed to before state,
                // atau bisa make metode parent and child untuk refresh state make setsate trs ngeget ulang baru append ke object future biar ngereload
                Navigator.of(context).popAndPushNamed('/');
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
              title: 'Tambah Wishlist',
              leftIconPath: 'assets/icons/Arrow-left.svg',
              rightIconPath: 'assets/icons/Info Square.svg',
              leftIconOnPressed: () {
                provider.formReset();
                Navigator.of(context).pop();
              },
              rightIconOnPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: Text(
                      'Kamu bisa menambahkan wishlist dengan mengisi data tentang barang yang kamu inginkan. Tersedia juga opsi pengingat yang akan memberikan notifikasi apabila sudah waktunya.',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 30),
              margin: EdgeInsets.only(top: 30),
              child: Column(
                children: <Widget>[
                  // Wishlist Name
                  TextFormInput(
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
                  TextFormInput(
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
