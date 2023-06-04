import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:faithful_path/views/mobile_screen/hadith_list_screen_mobile.dart';
import 'package:faithful_path/views/mobile_screen/location_tracker_screen_mobile.dart';
import 'package:faithful_path/views/mobile_screen/surah_list_screen_mobile.dart';
import 'package:faithful_path/constant_files/color.dart';
import 'package:faithful_path/constant_files/string.dart';
import 'package:faithful_path/custom_widget/custom_card.dart';
import 'package:flutter/material.dart';

class HomeScreenMobile extends StatelessWidget {
  const HomeScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        centerTitle: true,
        backgroundColor: themeColor,
      ),
        body: SafeArea(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  CustomCard(imageLocation: quranPhotoAddress, title: 'Surah', screen: const SurahListScreenMobile()),
                  CustomCard(imageLocation: hadithIconAddress, title: 'Hadith', screen: const HadithListScreenMobile()),
                ],
              ),
              Row(
                children: [
                  CustomCard(imageLocation: timeIconAddress, title: 'Salat Time', screen: const LocationTrackerScreenMobile()),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
