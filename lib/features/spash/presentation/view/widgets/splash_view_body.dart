import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:islam/core/util/app_router.dart';
import 'package:islam/core/util/styles.dart';

import '../../../../../main.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    navigationToIntroView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isFirstTime
            ? GoRouter.of(context).go(AppRouter.kIntroView)
            : GoRouter.of(context).go(AppRouter.kHomeView);
      },
      child: Scaffold(
        backgroundColor: Color(0xff141411),
        body: Stack(
          children: [
            Image.asset(
              'assets/photos/splash_background.png',
              fit: BoxFit.cover,height: double.infinity,width: double.infinity,
            ),
            SafeArea(
              child: Align(
                alignment: .topCenter,
                child: Image.asset('assets/photos/Mosque-01 1.png'),
              ),
            ),
            Align(
              alignment: .topRight,
              child: Image.asset(
                'assets/photos/Glow.png',
                width: 70,
                height: 300,
              ),
            ),
            Align(
              alignment: .xy(-1, -0.3),
              child: Image.asset('assets/photos/Shape-07 1.png'),
            ),
            Center(child: Image.asset('assets/photos/OBJECTS.png')),
            Align(
              alignment: .xy(0, 0.25),
              child: Image.asset('assets/photos/islam.png'),
            ),
            Align(
              alignment: .xy(1, 0.6),
              child: Image.asset('assets/photos/Shape-04 1.png'),
            ),
            Align(
              alignment: .xy(0, 0.85),
              child: Text(
                'supervised by mohamad nabil\nprogrammed by waleed maksour',
                textDirection: .rtl,
                textAlign: .center,
                style: Styles.textStyle16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigationToIntroView() {
    if (isFirstTime) {
      Future.delayed(Duration(seconds: 2), () {
        GoRouter.of(context).go(AppRouter.kIntroView);
      });
    } else {
      Future.delayed(Duration(seconds: 2), () {
        GoRouter.of(context).go(AppRouter.kHomeView);
      });
    }
  }
}
