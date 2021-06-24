import 'package:skeleton_text/skeleton_text.dart';
import 'package:flutter/material.dart';

class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonContainer._({
    this.height = double.infinity,
    this.width = double.infinity,
    this.borderRadius = 0,
    Key key,
  }) : super(key: key);

  const SkeletonContainer.square({
    double height,
    double width,
    double borderRadius = 0,
  }) : this._(width: width, height: height, borderRadius: borderRadius);

  @override
  Widget build(BuildContext context) => SkeletonAnimation(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      );
}
