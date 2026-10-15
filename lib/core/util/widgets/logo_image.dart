import 'package:flutter/material.dart';
class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: .xy(0, 0.2),
      children: [
        Image.asset('assets/photos/Mosque-01 1.png'),
        Image.asset('assets/photos/islam.png'),
      ],
    );
  }
}
