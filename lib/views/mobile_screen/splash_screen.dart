import 'package:faithful_path/views/desktop_screen/home_screen_desktop.dart';
import 'package:faithful_path/views/mobile_screen/home_screen_mobile.dart';
import 'package:faithful_path/constant_files/string.dart';
import 'package:faithful_path/constant_files/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ResponsiveLayout(mobileScreen: HomeScreenMobile(), desktopScreen: HomeScreenDesktop(),)));
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          logoAddress,
          width: .6.sw,
        ),
      ),
    );
  }
}
