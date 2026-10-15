import 'package:flutter/material.dart';
import 'package:islam/core/util/styles.dart';
import 'package:islam/core/util/widgets/top_item_quran_hadith.dart';
import 'package:islam/features/home/presentation/view/widgets/quran_view/sura_content_view/sura_content_list_view.dart';
import 'package:islam/features/home/presentation/view/widgets/quran_view/sura_content_view/sura_content_view_app_bar.dart';
import 'package:quran/quran.dart' as quran;

class SuraContentViewBody extends StatelessWidget {
  const SuraContentViewBody({super.key, required this.surahNumber});
final int surahNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Column(
              children: [
                SuraContentViewAppBar(surahNumber: surahNumber,),
                TopItemQuranHadith( centerText: quran.getSurahNameArabic(surahNumber),textStyle: Styles.textStyle24,),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .65,
                  child: SuraContentListView(surahNumber: surahNumber,),
                ),
                Image.asset('assets/photos/bottom_quran_details.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
