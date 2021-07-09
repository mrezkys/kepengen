import 'package:flutter/material.dart';
import 'package:kepengen/provider/wishlist_provider.dart';
import 'package:kepengen/view/utils/round_slider_track_shape.dart';

// ignore: must_be_immutable
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
