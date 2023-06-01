import 'package:faithful_path/constant_files/color.dart';
import 'package:faithful_path/constant_files/string.dart';
import 'package:faithful_path/controller/hadith_list_controller.dart';
import 'package:faithful_path/views/mobile_screen/hadith_screen_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HadithListScreenMobile extends StatefulWidget {
  const HadithListScreenMobile({Key? key}) : super(key: key);

  @override
  State<HadithListScreenMobile> createState() => _HadithListScreenMobileState();
}

class _HadithListScreenMobileState extends State<HadithListScreenMobile> {
  // ignore: prefer_typing_uninitialized_variables
  var hadithList;
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
    final service = GetHadithList();
    final result = await service.getCombinedHadithList();
    //result!.sort((a, b) => int.parse(a.hadithNumber).compareTo(int.parse(b.hadithNumber)));

    setState(() {
      hadithList = result;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hadith'),
        centerTitle: true,
        backgroundColor: themeColor,
      ),
      body: Center(
        child: hadithList != null
            ? ListView.builder(
          itemCount: hadithList!.length,
          itemBuilder: (context, index) {
            var hadith = hadithList![index];
            return Padding(
              padding: EdgeInsets.all(5.h),
              child: GestureDetector(
               onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>HadithScreenMobile(hadith: hadith))),
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
                        //left container for number showing
                        Container(
                          width: .15.sw,
                          color: lightGreen,
                          child: Center(
                            child: Text(hadith.hadithNo),
                          ),
                        ),
                        SizedBox(
                          width: .03.sw,
                        ),
                        //right side for name and other details
                        Expanded(child: Padding(
                          padding: EdgeInsets.fromLTRB(3.w, 10.h, 3.w, 10.h),
                          child: Text(hadith.topicName,),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )
            : const CircularProgressIndicator(), // Show a loading indicator if data is not available
      ),
    );
  }
}
