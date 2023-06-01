import 'package:faithful_path/constant_files/color.dart';
import 'package:faithful_path/constant_files/string.dart';
import 'package:faithful_path/controller/surah_list_api_controller.dart';
import 'package:faithful_path/views/mobile_screen/surah_screen_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SurahListScreenMobile extends StatefulWidget {
  const SurahListScreenMobile({Key? key}) : super(key: key);

  @override
  State<SurahListScreenMobile> createState() => _SurahListScreenMobileState();
}

class _SurahListScreenMobileState extends State<SurahListScreenMobile> {
  // ignore: prefer_typing_uninitialized_variables
  var surahList;
  var isLoaded = false;

  @override
  @override
  void initState() {
    super.initState();
    // Perform any synchronous initialization tasks here
    fetchData(); // Call a separate method to handle asynchronous work
  }


  Future<void> fetchData() async {
    // Fetch the data from your service or API
    final service = GetSurahList();
    final url = getSurahListUri;
    final result = await service.getSurahList(url);

    setState(() {
      surahList = result;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surah'),
        centerTitle: true,
        backgroundColor: themeColor,
      ),
      body: SafeArea(
        child: Center(
          child: surahList != null && surahList!.data != null
              ? ListView.builder(
            itemCount: surahList!.data.length,
            itemBuilder: (context, index) {
              final surah = surahList!.data[index];
              return Padding(
                padding: EdgeInsets.all(5.h),
                child: GestureDetector(
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>SurahScreenMobile(numberOfSurah: surah.number))),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0,2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        //left container for number showing
                        Container(
                          height: .09.sh,
                          width: .15.sw,
                          color: lightGreen,
                          child: Center(
                            child: Text(surah.number.toString()),
                          ),
                        ),
                        SizedBox(
                          width: .03.sw,
                        ),
                        //right side for name and other details
                        Column(
                          children: [
                            Text('${surah.englishName}         ${surah.name}', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
                            Text('Number of Ayahs: ${surah.numberOfAyahs}      Revelation Type: ${surah.revelationType}', style: TextStyle(fontSize: 12.sp),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
              : const CircularProgressIndicator(), // Show a loading indicator if data is not available
        ),
      ),
    );
  }
}