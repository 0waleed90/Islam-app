import 'package:flutter/material.dart';
class TopItemQuranHadith extends StatelessWidget {
  const TopItemQuranHadith({super.key, required this.centerText, required this.textStyle, this.imageColor, });
final String centerText;
final TextStyle textStyle;
final Color? imageColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.ltr, // يضمن بقاء صورة اليسار في اليسار وصورة اليمين في اليمين
      children: [
        Image.asset(
          'assets/photos/top_left_quran_details.png',
          color: imageColor,
        ),
        Expanded(
          child: Text(
            centerText,
            style: textStyle,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl, // لضمان بقاء اتجاه نص العنوان صحيحاً
          ),
        ),
        Image.asset(
          'assets/photos/top_right_quran_details.png',
          color: imageColor,
        ),
      ],
    );
  }
}
