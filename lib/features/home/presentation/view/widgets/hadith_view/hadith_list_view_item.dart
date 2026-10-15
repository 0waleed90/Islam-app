import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:islam/core/constants.dart';
import 'package:islam/core/util/app_router.dart';
import 'package:islam/core/util/styles.dart';
import 'package:islam/core/util/widgets/top_item_quran_hadith.dart';

class HadithListViewItem extends StatelessWidget {
  const HadithListViewItem({
    super.key,
    required this.hadith,
    required this.title, required this.hadithNumber,
  });
  final String hadith;
  final String title;
  final int hadithNumber;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        GoRouter.of(context).push(AppRouter.kHadithContentView,extra: hadithNumber);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: kPrimaryColor,
        ),

        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TopItemQuranHadith(
                centerText: title,
                textStyle: Styles.textStyle24.copyWith(color: Colors.black),
                imageColor: Colors.black,
              ),
              const SizedBox(height: 30),
              Text(
                hadith,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.rtl,
                style: Styles.textStyle16.copyWith(
                  color: Colors.black,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
