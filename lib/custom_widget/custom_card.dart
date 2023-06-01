import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String imageLocation;
  final Widget screen;

  const CustomCard({Key? key, required this.imageLocation, required this.title, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> screen)),
      child: Padding(
        padding: EdgeInsets.all(.02.sw),
        child: Card(
          elevation: 8,
          child: SizedBox(
            height: .25.sh,
            width: .43.sw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(imageLocation, height: .2.sh,),
                Text(title, style: TextStyle(fontSize: 20.sp),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
