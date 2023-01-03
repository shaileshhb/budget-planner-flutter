import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class EnvelopSkeleton extends StatelessWidget {
  final double width;
  final double height;

  const EnvelopSkeleton._({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
  });

  // ignore: use_key_in_widget_constructors
  const EnvelopSkeleton.square({
    required double width,
    required double height,
  }) : this._(width: width, height: height);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      shimmerDuration: 2000,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.blueGrey[300],
        ),
      ),
    );
  }
}
