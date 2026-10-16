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
    var now = DateTime.now();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // التاريخ الميلادي (الجهة اليسرى)
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    DateFormat('dd MMM', 'ar').format(now),
                    textAlign: TextAlign.center,
                    style: Styles.textStyle16.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    DateFormat('yyyy', 'ar').format(now),
                    textAlign: TextAlign.center,
                    style: Styles.textStyle14.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // أوقات الصلاة واليوم (المنتصف)
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'أوقات الصلاة',
                    textAlign: TextAlign.center,
                    style: Styles.textStyle20.copyWith(
                      color: const Color(0xff856B3F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    DateFormat('EEEE', 'ar').format(now),
                    textAlign: TextAlign.center,
                    style: Styles.textStyle16.copyWith(
                      color: const Color(0xff856B3F),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // التاريخ الهجري (الجهة اليمنى)
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${hijriDate.hDay} ${hijriDate.longMonthName}',
                    textAlign: TextAlign.center,
                    style: Styles.textStyle16.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${hijriDate.hYear}',
                    textAlign: TextAlign.center,
                    style: Styles.textStyle14.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
