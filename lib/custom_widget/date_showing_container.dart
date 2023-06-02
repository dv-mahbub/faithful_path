import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant_files/color.dart';

// ignore: must_be_immutable
class DateShowingContainer extends StatefulWidget {
  String text;
  DateShowingContainer({Key? key, required this.text,}) : super(key: key);

  @override
  State<DateShowingContainer> createState() => _DateShowingContainerState();
}

class _DateShowingContainerState extends State<DateShowingContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: .45.sw,
      color: Colors.deepPurpleAccent,
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(color: white, fontSize: 17.sp),
        ),
      ),
    );
  }
}
