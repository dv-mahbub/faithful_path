import 'package:alarm/alarm.dart';
import 'package:faithful_path/views/mobile_screen/splash_screen.dart';
import 'package:faithful_path/constant_files/responsive_layout.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveLayout(mobileScreen: SplashScreen(),),
    )
  );
}