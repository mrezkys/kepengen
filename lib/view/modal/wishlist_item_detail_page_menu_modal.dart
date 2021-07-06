import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kepengen/provider/local_database.dart';
import 'package:kepengen/view/widget/menu_modal_header.dart';
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
            MenuModalHeader(
              leftMenuTitle: 'Batal',
              leftMenuOnTap: () {
                Navigator.pop(context);
              },
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
                  MenuModalItem(
                    text: 'Share',
                    icon: SvgPicture.asset('assets/icons/Upload.svg'),
                    onTap: () {
                      Navigator.of(context).pop('share');
                    },
                  ),
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
                    onTap: () {
                      Navigator.of(context).pop('delete');
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
