import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:islam/core/util/app_router.dart';
import 'package:islam/core/util/styles.dart';

import '../../../../../core/constants.dart';

class CustomControlWidgets extends StatelessWidget {
  const CustomControlWidgets({
    super.key,
    required this.index,
    required this.pageController,
  });
  final PageController pageController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            index == 1 || index == 2 || index == 3
                ? pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  )
                : null;
          },
          child: Text(
            index == 1 || index == 2 || index == 3 ? 'back' : '    ',
            style: Styles.textStyle16,
          ),
        ),
        DotsIndicator(
          position: index.toDouble(),
          dotsCount: 4,
          decorator: DotsDecorator(
            color: kPrimaryColor,
            activeColor: Colors.yellow,
          ),
        ),
        GestureDetector(
          onTap: () {
            Hive.box('settings').put('isFirstTime', false);
            index == 1 || index == 2 || index == 0
                ? pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  )
                : {
                    GoRouter.of(context).push(AppRouter.kHomeView),

                    Hive.box('settings').put('isFirstTime', false),
                  };
          },
          child: Text(
            index == 3 ? 'finish' : 'next',
            style: Styles.textStyle16,
          ),
        ),
      ],
    );
  }
}
