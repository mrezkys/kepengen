import 'package:flutter/material.dart';
import 'package:kepengen/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

class WishlistPageFilterModal extends StatefulWidget {
  @override
  _WishlistPageFilterModalState createState() => _WishlistPageFilterModalState();
}

class _WishlistPageFilterModalState extends State<WishlistPageFilterModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(width: 0),
      ),
      child: Consumer<WishlistProvider>(builder: (context, _wishlistProvider, _) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              //header
              Container(
                height: 56,
                width: MediaQuery.of(context).size.width - 20 - 20, // 20 = parent margin
                decoration: BoxDecoration(color: Color(0xFFF6F6F6), borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        height: 56,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
                          color: Colors.transparent,
                        ),
                        child: Text('Reset', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xFF606772))),
                      ),
                    ),
                    Text('Menu', style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 56,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(15)),
                          color: Colors.transparent,
                        ),
                        child: Text('Batal', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xFF606772))),
                      ),
                    ),
                  ],
                ),
              ),
              //body
              //Filter Cepat
              Container(
                width: MediaQuery.of(context).size.width - 20 - 20, // 20 = parent margin
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 15, bottom: 8),
                      child: Text('Filter Cepat', style: TextStyle(fontSize: 12, color: Color(0xFF606722))),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 3,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 20 - 20,
                      height: 45,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 25, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Completed',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'Poppins'),
                          ),
                          Checkbox(
                            onChanged: (value) {
                              _wishlistProvider.resetFilter();
                              _wishlistProvider.isCompleted = value;
                            },
                            checkColor: Theme.of(context).primaryColor,
                            value: _wishlistProvider.isCompleted,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 3,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 20 - 20,
                      height: 45,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 25, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'InCompleted',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'Poppins'),
                          ),
                          Checkbox(
                            onChanged: (value) {
                              _wishlistProvider.resetFilter();
                              _wishlistProvider.isInCompleted = value;
                            },
                            checkColor: Theme.of(context).primaryColor,
                            value: _wishlistProvider.isInCompleted,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 3,
                    )
                  ],
                ),
              ),
              // Urutkan Menurut
              Container(
                width: MediaQuery.of(context).size.width - 20 - 20, // 20 = parent margin
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 15, bottom: 8),
                      child: Text('Urutkan Menurut', style: TextStyle(fontSize: 12, color: Color(0xFF606722))),
                    ),
                    Divider(color: Colors.grey, height: 3),
                    // Filter  Terdekat
                    GestureDetector(
                      onTap: () {
                        if (_wishlistProvider.filterTerdekat == false) {
                          _wishlistProvider.resetSortFilter();
                          _wishlistProvider.filterTerdekat = true;
                        } else {
                          _wishlistProvider.filterTerdekat = false;
                        }
                        print(_wishlistProvider.filterTerdekat);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width - 20 - 20,
                        height: 45,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 25, right: 15),
                        child: Text(
                          'Terdekat',
                          style: (_wishlistProvider.filterTerdekat == true)
                              ? TextStyle(fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Poppins')
                              : TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                    Divider(color: Colors.grey, height: 3),
                    // Filter Terpengen
                    GestureDetector(
                      onTap: () {
                        if (_wishlistProvider.filterTerpengen == false) {
                          _wishlistProvider.resetSortFilter();
                          _wishlistProvider.filterTerpengen = true;
                        } else {
                          _wishlistProvider.filterTerpengen = false;
                        }
                        print(_wishlistProvider.filterTerpengen);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width - 20 - 20,
                        height: 45,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 25, right: 15),
                        child: Text(
                          'Terpengen',
                          style: (_wishlistProvider.filterTerpengen == true)
                              ? TextStyle(fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Poppins')
                              : TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                    Divider(color: Colors.grey, height: 3),
                    // Filter Termurah
                    GestureDetector(
                      onTap: () {
                        if (_wishlistProvider.filterTermurah == false) {
                          _wishlistProvider.resetSortFilter();
                          _wishlistProvider.filterTermurah = true;
                        } else {
                          _wishlistProvider.filterTermurah = false;
                        }
                        print(_wishlistProvider.filterTermurah);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width - 20 - 20,
                        height: 45,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 25, right: 15),
                        child: Text(
                          'Termurah',
                          style: (_wishlistProvider.filterTermurah == true)
                              ? TextStyle(fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Poppins')
                              : TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                    Divider(color: Colors.grey, height: 3),
                    //  Filter Termahal
                    GestureDetector(
                      onTap: () {
                        if (_wishlistProvider.filterTermahal == false) {
                          _wishlistProvider.resetSortFilter();
                          _wishlistProvider.filterTermahal = true;
                        } else {
                          _wishlistProvider.filterTermahal = false;
                        }
                        print(_wishlistProvider.filterTermahal);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width - 20 - 20,
                        height: 45,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 25, right: 15),
                        child: Text(
                          'Termahal',
                          style: (_wishlistProvider.filterTermahal == true)
                              ? TextStyle(fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Poppins')
                              : TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                    Divider(color: Colors.grey, height: 3),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
