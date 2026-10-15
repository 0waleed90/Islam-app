import 'package:flutter/material.dart';
import 'package:islam/core/util/styles.dart';
import 'package:islam/features/home/presentation/view/widgets/quran_view/recently_sura_list_view.dart';
import 'package:islam/features/home/presentation/view/widgets/quran_view/suras_list_view.dart';

class NormalContent extends StatelessWidget {
  const NormalContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(

        children: [
          SizedBox(height: 20),
          Align(
            alignment: .bottomLeft,
            child: Text(
              'الأحدث',
              style: Styles.textStyle16.copyWith(color: Colors.white),
            ),
          ),
          RecentlySuraListview(),
          Align(
            alignment: .centerLeft,
            child: Text(
              'قائمة السور',
              style: Styles.textStyle16.copyWith(color: Colors.white),
            ),
          ),

          SurasListView(),
        ],
      ),
    );
  }
}
