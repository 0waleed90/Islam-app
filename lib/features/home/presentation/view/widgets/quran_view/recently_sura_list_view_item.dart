import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islam/core/constants.dart';
import 'package:islam/core/util/app_router.dart';
import 'package:islam/core/util/styles.dart';
import 'package:islam/features/home/presentation/manger/quran_cubit/quran_cubit.dart';

import 'package:quran/quran.dart' as quran;

class RecentlySuraListviewItem extends StatelessWidget {
  const RecentlySuraListviewItem({super.key, required this.suraNumber});
  final int suraNumber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<QuranCubit>().addToHistory(suraNumber);
        GoRouter.of(
          context,
        ).push(AppRouter.kSuraContentView, extra: suraNumber);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .circular(16),
          color: kPrimaryColor,
        ),
        width: 340,

        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.only(left: 9),
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .spaceEvenly,
                  children: [
                    Text(
                      quran.getSurahName(suraNumber),
                      style: Styles.textStyle24.copyWith(
                        color: Color(0xff202020),
                      ),
                    ),
                    Text(
                      quran.getSurahNameArabic(suraNumber),
                      style: Styles.textStyle24.copyWith(
                        color: Color(0xff202020),
                      ),
                    ),
                    Text(
                      '${quran.getVerseCount(suraNumber)} Verses',
                      style: Styles.textStyle14,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Image.asset('assets/photos/Rectangle 124.png'),
          ],
        ),
      ),
    );
  }
}
