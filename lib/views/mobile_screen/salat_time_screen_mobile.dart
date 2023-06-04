import 'package:alarm/alarm.dart';
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
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  salatTimeResult != null &&
                      salatTimeResult.data != null &&
                      salatTimeResult.data!.isNotEmpty
                      ? Column(
                    children: [
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
                                  'এশাঃ ${convertTime(salatTime.isha)}',
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
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: .45.sw,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: () async {
                              //  setAlarm("ফজর", 'ফজরের নামাজের সময় শুরু', salatTime.fajr);
                               // setAlarm("যোহর", 'যোহরের নামাজের সময় শুরু', salatTime.dhuhr);
                                setAlarm("আসর", 'আসরের নামাজের সময় শুরু', salatTime.asr);
                               // setAlarm("মাগরিব", 'মাগরিবের নামাজের সময় শুরু', salatTime.maghrib);
                               // setAlarm("এশা", 'এশার নামাজের সময় শুরু', salatTime.isha);
                              },
                              child: const Text('Set Prayer Time Alarm', textAlign: TextAlign.center,),
                            ),
                          ),
                          SizedBox(
                            width: .45.sw,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: (){
                                Alarm.stop(15);
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              child: const Text('Cancel Alarm'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                      : const CircularProgressIndicator(),
                ],
              ),
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

  Future<void> setAlarm(String prayerName, String message, String timeString) async {
    final colonIndex = timeString.indexOf(':');
    int hour = int.parse(timeString.substring(0, colonIndex));
    int minute = int.parse(timeString.substring(colonIndex + 1, colonIndex + 3));

    DateTime alarmTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hour, minute);
    final alarmSettings = AlarmSettings(
      id: 15,
      dateTime: alarmTime,
      assetAudioPath: 'assets/audio/azan.mp3',
      loopAudio: false,
      vibrate: false,
      fadeDuration: 15.0,
      notificationTitle: prayerName,
      notificationBody: message,
      stopOnNotificationOpen: true,
      enableNotificationOnKill: true,
    );
    await Alarm.set(alarmSettings: alarmSettings);
  }
}
