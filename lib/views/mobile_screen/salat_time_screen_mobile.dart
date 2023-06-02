import 'package:analog_clock/analog_clock.dart';
import 'package:faithful_path/constant_files/color.dart';
import 'package:faithful_path/constant_files/responsive_layout.dart';
import 'package:faithful_path/controller/salat_time_controller.dart';
import 'package:faithful_path/custom_widget/date_showing_container.dart';
import 'package:faithful_path/model/salat_time_model.dart';
import 'package:faithful_path/views/desktop_screen/home_screen_desktop.dart';
import 'package:faithful_path/views/mobile_screen/home_screen_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

import '../../constant_files/text_conversion.dart';

class SalatTimeScreenMobile extends StatefulWidget {
  final LatLng currentLocation;
  const SalatTimeScreenMobile({Key? key, required this.currentLocation}) : super(key: key);

  @override
  State<SalatTimeScreenMobile> createState() => _SalatTimeScreenMobileState();
}

class _SalatTimeScreenMobileState extends State<SalatTimeScreenMobile> {
  DateTime dateTime = DateTime.now();
  // ignore: prefer_typing_uninitialized_variables
  var salatTimeResult;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final service = GetSalatTime();
    final url = 'http://api.aladhan.com/v1/calendar/${dateTime.year}/${dateTime
        .month}?latitude=${widget.currentLocation.latitude}&longitude=${widget
        .currentLocation.longitude}';
    final SalatTimeModel? result = await service.getSalatTime(url);

    setState(() {
      salatTimeResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    var salatTime = salatTimeResult?.data?[dateTime.day - 1].timings;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('নামাজের সময়সূচী'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                salatTimeResult != null &&
                    salatTimeResult.data != null &&
                    salatTimeResult.data!.isNotEmpty
                    ? Column(
                  children: [
                    SizedBox(
                      height: 7.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DateShowingContainer(text: dayInBengali[DateFormat('EEEE').format(dateTime)]!),
                        SizedBox(width: 2.w),
                        DateShowingContainer(text: '${convertToBengali(dateTime.day.toString())} ${monthInBengali[dateTime.month.toString()]} ${convertToBengali(dateTime.year.toString())}'),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.all(20.h),
                      child: AnalogClock(
                        height: 150.h,
                        width: 170.w,
                        decoration: BoxDecoration(
                          border: Border.all(width: 5.w, color: Colors.blue),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Container(
                      color: lightGreen,
                      width: .95.sw,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 9.h, bottom: 9.h),
                          child: Text(
                                'ফজরঃ ${convertTime(salatTime.fajr)}\n'
                                'যোহরঃ ${convertTime(salatTime.dhuhr)}\n'
                                'আসরঃ ${convertTime(salatTime.asr)}\n'
                                'মাগরিবঃ ${convertTime(salatTime.maghrib)}\n'
                                'ঈশাঃ ${convertTime(salatTime.isha)}',
                            style: TextStyle(fontSize: 16.sp, height: 1.7.h),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: .45.sw,
                          color: lightBlue,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                            child: Column(
                              children: [
                                Icon(Icons.sunny, size: 55.sp, color: Colors.yellow,),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text('সূর্যদয়ঃ ${convertTime(salatTime.sunrise)}', style: TextStyle(fontSize: 16.sp),),
                              ],
                            ),
                          )
                        ),
                        Container(
                          width: .45.sw,
                          color: lightBlue,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                            child: Column(
                              children: [
                                Icon(Icons.sunny_snowing, size: 55.sp, color: Colors.red,),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text('সূর্যাস্তঃ ${convertTime(salatTime.sunset)}', style: TextStyle(fontSize: 16.sp),),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
                    : const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPressed() async{
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ResponsiveLayout(mobileScreen: HomeScreenMobile(), desktopScreen: HomeScreenDesktop(),)),
    );
    return true;
  }
  String convertTime(String time){
    return convertToBengali(removeTimeZoneOffset(twelveHourTimeFormat(time)));
  }
}
