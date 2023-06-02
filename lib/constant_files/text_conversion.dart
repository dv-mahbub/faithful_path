import 'package:intl/intl.dart';

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

Map<String, String> monthInBengali = {
  '1': 'জানুয়ারী',
  '2': 'ফেব্রুয়ারী',
  '3': 'মার্চ',
  '4': 'এপ্রিল',
  '5': 'মে',
  '6': 'জুন',
  '7': 'জুলাই',
  '8': 'আগস্ট',
  '9': 'সেপ্টেম্বর',
  '10': 'অক্টবর',
  '11': 'নভেম্বর',
  '12': 'ডিসেম্বর',
};

Map<String, String> dayInBengali = {
  'Saturday': 'শনিবার',
  'Sunday': 'রবিবার',
  'Monday': 'সোমবার',
  'Tuesday': 'মঙ্গলবার',
  'Wednesday': 'বুধবার',
  'Thursday': 'বৃহস্পতিবার',
  'Friday': 'শুক্রবার',
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

String twelveHourTimeFormat (String time){
  return DateFormat('h:mm').format(DateFormat('HH:mm').parse(time.split(' ')[0]));
}