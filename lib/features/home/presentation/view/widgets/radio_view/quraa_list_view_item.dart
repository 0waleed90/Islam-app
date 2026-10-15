import 'package:flutter/material.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/util/styles.dart';
class QuraaListViewItem extends StatelessWidget {
  const QuraaListViewItem({super.key, required this.name,});
final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: kPrimaryColor,
        ),
        child: Stack(
          children: [
            Align(alignment: .bottomCenter,
              child: Image.asset(
                'assets/photos/bottom_quran_details.png',
                color: Colors.black,
              ),
            ),
            Center(
              child: Text(
                name,
                style: Styles.textStyle20.copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
