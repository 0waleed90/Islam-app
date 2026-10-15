import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:islam/core/util/styles.dart';

class CustomHistoryWidget extends StatelessWidget {
  const CustomHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal('ar');
    var hijriDate = HijriCalendar.now();

    return Row(
      mainAxisAlignment: .spaceAround,
      children: [
        Text(
          '${DateFormat('dd MMM ','ar').format(DateTime.now())}\n${DateFormat('yyyy','ar').format(DateTime.now())}',
          style: Styles.textStyle16.copyWith(color: Colors.white),
        ),
        Text(
          '    أوقات الصلاة\n      ${DateFormat('EEEE','ar').format(DateTime.now())}',
          textAlign:.center,
          textDirection: .rtl,
          style: Styles.textStyle20.copyWith(
            color: Color(0xff856B3F),

          ),
        ),Text(
          '${hijriDate.hDay}   ${hijriDate.longMonthName}   \n${hijriDate.hYear}',
          style: Styles.textStyle16.copyWith(
            color: Colors.white,
          ),

        ),
      ],
    );
  }
}
