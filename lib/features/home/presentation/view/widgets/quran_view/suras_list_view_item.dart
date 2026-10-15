import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islam/core/util/app_router.dart';
import 'package:islam/core/util/styles.dart';
import 'package:quran/quran.dart' as quran;

import '../../../manger/quran_cubit/quran_cubit.dart';

class SurasListViewItem extends StatelessWidget {
  const SurasListViewItem({super.key, required this.surahNumber});
  final int surahNumber;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<QuranCubit>().addToHistory(surahNumber);
        GoRouter.of(context).push(AppRouter.kSuraContentView,extra: surahNumber);
      },
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                alignment: .center,
                children: [
                  Image.asset('assets/photos/Vector.png'),
                  Text(surahNumber.toString(), style: Styles.textStyle16),
                ],
              ),
              SizedBox(width: 25),
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    quran.getSurahName(surahNumber),
                    style: Styles.textStyle20.copyWith(color: Colors.white),
                  ),
                  Text(
                    '  أيات\t${quran.getVerseCount(surahNumber).toString()}',
                    style: Styles.textStyle14.copyWith(color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
              Text(
                quran.getSurahNameArabic(surahNumber),
                style: Styles.textStyle24.copyWith(color: Colors.white),
              ),
              SizedBox(width: 20),
            ],
          ),
          Divider(color: Colors.white, indent: 45, endIndent: 45),
        ],
      ),
    );
  }
}
