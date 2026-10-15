import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:islam/core/constants.dart';
import 'package:islam/core/util/styles.dart';
import 'package:quran/quran.dart' as quran;
class SuraContentViewAppBar extends StatelessWidget {
  const SuraContentViewAppBar({super.key, required this.surahNumber});
  final int surahNumber;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
            color: kPrimaryColor,
          ),
          const SizedBox(width: 110),
          Text(quran.getSurahName(surahNumber), style: Styles.textStyle20),
        ],
      ),
    );
  }
}
