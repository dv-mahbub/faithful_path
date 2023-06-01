import 'package:faithful_path/constant_files/color.dart';
import 'package:faithful_path/model/hadith_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HadithScreenMobile extends StatefulWidget {
  final HadithListModel hadith;
  const HadithScreenMobile({Key? key, required this.hadith}) : super(key: key);

  @override
  State<HadithScreenMobile> createState() => _HadithScreenMobileState();
}

class _HadithScreenMobileState extends State<HadithScreenMobile> {
  @override
  Widget build(BuildContext context) {
    var hadith = widget.hadith;
    var finalHadithBengali = hadith.hadithBengali.replaceAll('<br />', '');
    finalHadithBengali = finalHadithBengali.replaceAll('&zwnj;', '\'');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hadith'),
        centerTitle: true,
        backgroundColor: themeColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(4.h),
            child: Column(
              children: [
                SizedBox(height: 2.h,),
                Text(hadith.topicName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp), textAlign: TextAlign.center,),
                SizedBox(height: 7.h,),
                Text(hadith.hadithArabic, textAlign: TextAlign.right,),
                SizedBox(height: 10.h,),
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: 'বাংলা অর্থঃ ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp,)),
                      TextSpan(text: finalHadithBengali, style: TextStyle(fontSize: 14.sp)),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
