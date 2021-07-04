import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kepengen/provider/local_database.dart';
import 'package:kepengen/view/widget/menu_modal_item.dart';

class WishlistItemDetailPageMenuModal extends StatelessWidget {
  final int wishlistId;
  WishlistItemDetailPageMenuModal({@required this.wishlistId});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(width: 0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            // TODO: make header to widget
            Container(
              height: 56,
              width: MediaQuery.of(context).size.width - 20 - 20, // 20 = parent margin
              decoration: BoxDecoration(color: Color(0xFFF6F6F6), borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 56,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
                        color: Colors.transparent,
                      ),
                      child: Text('Batal', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xFF606772))),
                    ),
                  ),
                  Text('Menu', style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      height: 56,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(15)),
                        color: Colors.transparent,
                      ),
                      child: Text('', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xFF606772))),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 20 - 20, // 20 = parent margin
              child: Column(
                children: <Widget>[
                  Divider(
                    color: Colors.grey,
                    height: 3,
                  ),
                  // Share -------------
                  MenuModalItem(text: 'Share', icon: SvgPicture.asset('assets/icons/Upload.svg')),
                  Divider(
                    color: Colors.grey,
                    height: 3,
                  ),
                  // Edit -------------
                  MenuModalItem(text: 'Edit', icon: SvgPicture.asset('assets/icons/Edit Square.svg')),
                  Divider(
                    color: Colors.grey,
                    height: 3,
                  ),
                  // Delete -------------
                  MenuModalItem(
                    text: 'Delete',
                    icon: SvgPicture.asset('assets/icons/Delete.svg'),
                    onTap: () async {
                      await DBProvider.db.deleteWishlist(wishlistId);
                      Navigator.pop(context); //close the menu
                      Navigator.pop(context); //close the wishlist item detail page
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 3,
                  ),
                  // Screenshot -------------
                  MenuModalItem(
                    text: 'Screenshot',
                    icon: SvgPicture.asset('assets/icons/Camera.svg'),
                    onTap: () {
                      Navigator.of(context).pop('screenshot');
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 3,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
