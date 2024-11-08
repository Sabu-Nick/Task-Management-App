import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utility/assets_paths.dart';
// Corrected the path from "uitility" to "utility" if it was a typo

class ScreenBackground extends StatelessWidget {
  ScreenBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Get screen size inside the build method
    Size screenSize = MediaQuery.of(context).size;

    return Stack(

      children: [
        SvgPicture.asset(
          AssetsPaths.backgroundSVG,
          fit: BoxFit.cover,
          height: screenSize.height,
          width: screenSize.width,
        ),
        SafeArea(child: child)
      ],
    );
  }
}
