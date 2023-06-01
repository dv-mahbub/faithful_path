import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreen;
  final Widget? desktopScreen;
  const ResponsiveLayout({Key? key, this.desktopScreen, required this.mobileScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      //to return a screenView according to the screen size or state
      if (constrains.maxWidth > 600) {
        return desktopScreen ?? mobileScreen;
      } else {
        return mobileScreen;
      }
    });
  }
}