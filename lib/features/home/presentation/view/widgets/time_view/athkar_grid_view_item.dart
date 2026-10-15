import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:islam/core/constants.dart';

import '../../../../../../core/util/app_router.dart';
import '../../../../../../core/util/styles.dart';

class AthkarGridViewItem extends StatelessWidget {
  const AthkarGridViewItem({super.key, required this.indexG});

  final int indexG;
  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      'أذكار الصباح',
      'أذكار المساء',
      'أذكار بعد الصلاة',
      'أذكار الاستيقاظ',
      'أذكار النوم',
    ];

    List<String> images = [
      'assets/photos/morning_athkar.png',
      'assets/photos/evening_athkar.png',
      'assets/photos/kabba 1.png',
      'assets/photos/waking_athkar.png',
      'assets/photos/sleeping_athkar.png',
    ];
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(
          AppRouter.kAthkarContentView,
          extra: {'title': titles[indexG], 'indexCat': indexG},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .circular(16),
          border: Border.all(color: kPrimaryColor),
        ),
        child: Column(
          children: [
            Expanded(child: Image.asset(images[indexG])),
            Text(
              titles[indexG],
              style: Styles.textStyle16.copyWith(color: kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
