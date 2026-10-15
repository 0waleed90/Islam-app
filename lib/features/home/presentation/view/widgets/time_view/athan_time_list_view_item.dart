import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:islam/core/constants.dart';
import 'package:islam/core/util/styles.dart';

class AthanTimeListViewItem extends StatelessWidget {
  const AthanTimeListViewItem({
    super.key,
    required this.index,
    required this.prayerTimes,
  });
  final PrayerTimes prayerTimes;
  final int index;
  @override
  Widget build(BuildContext context) {
    String getPrayerName(int index) {
      final String name;
      switch (index) {
        case 0:
          name = "الفجر";
        case 1:
          name = 'الظهر';
        case 2:
          name = 'العصر';
        case 3:
          name = 'المغرب';
        case 4:
          name = 'العشاء';
        default:
          name = '';
      }
      return name;
    }

    DateTime time;
    String getFormattedTime(PrayerTimes prayerTimes, int index) {
      switch (index) {
        case 0:
          time = prayerTimes.fajr;
          break;

        case 1:
          time = prayerTimes.dhuhr;
          break;
        case 2:
          time = prayerTimes.asr;
          break;
        case 3:
          time = prayerTimes.maghrib;
          break;
        case 4:
          time = prayerTimes.isha;
          break;
        default:
          time = prayerTimes.fajr;
      }
      return '${DateFormat('hh:mm').format(time.toLocal())}\n${DateFormat('a', 'ar').format(time)}';
    }

    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: .circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.black, kPrimaryColor],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            getPrayerName(index),
            style: Styles.textStyle16.copyWith(color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            getFormattedTime(prayerTimes, index),
            style: TextStyle(fontSize: 30),
            textAlign: .center,
          ),



        ],
      ),
    );
  }
}
