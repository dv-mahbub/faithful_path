import 'package:faithful_path/constant_files/color.dart';
import 'package:faithful_path/controller/salat_time_controller.dart';
import 'package:faithful_path/model/salat_time_model.dart';
import 'package:faithful_path/views/desktop_screen/home_screen_desktop.dart';
import 'package:faithful_path/views/mobile_screen/home_screen_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

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
    return Scaffold(
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
                  Container(
                    color: lightGreen,
                    width: .95.sw,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 9.h, bottom: 9.h),
                        child: Text(
                          'ফজরঃ ${convertToBengali(removeTimeZoneOffset(salatTime?.fajr ?? ''))}\n'
                              'যোহরঃ ${convertToBengali(removeTimeZoneOffset(salatTime?.dhuhr ?? ''))}\n'
                              'আসরঃ ${convertToBengali(removeTimeZoneOffset(salatTime?.asr ?? ''))}\n'
                              'মাগরিবঃ ${convertToBengali(removeTimeZoneOffset(salatTime?.maghrib ?? ''))}\n'
                              'ঈশাঃ ${convertToBengali(removeTimeZoneOffset(salatTime?.isha ?? ''))}',
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
                              Text('সূর্যদয়ঃ ${convertToBengali(removeTimeZoneOffset(salatTime?.sunrise ?? ''))}', style: TextStyle(fontSize: 16.sp),),
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
                              Text('সূর্যাস্তঃ ${convertToBengali(removeTimeZoneOffset(salatTime?.sunset ?? ''))}', style: TextStyle(fontSize: 16.sp),),
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
    );
  }

  String removeTimeZoneOffset(String timeString) {
    int index = timeString.indexOf(' (');
    return index != -1 ? timeString.substring(0, index) : timeString;
  }

  Map<String, String> bengaliNumbers = {
    '0': '০',
    '1': '১',
    '2': '২',
    '3': '৩',
    '4': '৪',
    '5': '৫',
    '6': '৬',
    '7': '৭',
    '8': '৮',
    '9': '৯',
  };

  String convertToBengali(String number) {
    String bengaliNumber = '';
    for (int i = 0; i < number.length; i++) {
      String digit = number[i];
      String? bengaliDigit = bengaliNumbers[digit];
      bengaliNumber += bengaliDigit ?? digit;
    }
    return bengaliNumber;
  }
}
