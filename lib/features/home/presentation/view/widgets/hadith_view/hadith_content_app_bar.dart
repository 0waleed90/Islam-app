import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:islam/core/constants.dart';
import 'package:islam/core/util/styles.dart';

class HadithContentAppBar extends StatelessWidget {
  const HadithContentAppBar({super.key, required this.hadithNumber});
final String hadithNumber ;
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
          Text('الحديث $hadithNumber', style: Styles.textStyle20),
        ],
      ),
    );
  }
}
