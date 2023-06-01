import 'package:faithful_path/constant_files/color.dart';
import 'package:faithful_path/controller/surah_view_api_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant_files/string.dart';

class SurahScreenMobile extends StatefulWidget {
  final int numberOfSurah;
  const SurahScreenMobile({Key? key, required this.numberOfSurah}) : super(key: key);

  @override
  State<SurahScreenMobile> createState() => _SurahScreenMobileState();
}

class _SurahScreenMobileState extends State<SurahScreenMobile> {
  // ignore: prefer_typing_uninitialized_variables
  var surahDetails;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    // Perform any synchronous initialization tasks here
    fetchData(); // Call a separate method to handle asynchronous work
  }


  Future<void> fetchData() async {
    // Fetch the data from your service or API
    final service = GetSurahDetails();
    final url = getSurahDetailsUri+widget.numberOfSurah.toString();
    final result = await service.getSurahDetails(url);

    setState(() {
      surahDetails = result;
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
        child:  surahDetails != null && surahDetails!.data != null
            ? Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 9.h, bottom: 3.h),
              child: Text('${surahDetails.data.englishName}     ${surahDetails.data.name}', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),),
            ),
            Expanded(
              child: Center(
                child: ListView.builder(
                  itemCount: surahDetails!.data.ayahs.length,
                  itemBuilder: (context, index) {
                    final ayah = surahDetails!.data.ayahs[index];
                    return Padding(
                      padding: EdgeInsets.all(5.h),
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
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              //left container for ayah number showing
                              Container(
                                width: .15.sw,
                                color: lightBlue,
                                child: Center(
                                  child: Text(ayah.number.toString()),
                                ),
                              ),
                              SizedBox(
                                width: .03.sw,
                              ),
                              //right side for name and other details
                              Expanded(child: Container(
                                constraints: BoxConstraints(maxWidth: .82.sw),
                                child: Padding(
                                  padding: EdgeInsets.all(5.h),
                                  child: Text(ayah.text.substring(0, ayah.text.length-1), textAlign: TextAlign.right,),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              )
            )
          ]
        ): const Center(child: CircularProgressIndicator()),
      )
    );
  }
}