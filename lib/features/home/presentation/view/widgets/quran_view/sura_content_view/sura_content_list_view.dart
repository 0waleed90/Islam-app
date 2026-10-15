import 'package:flutter/material.dart';
import 'package:islam/features/home/presentation/view/widgets/quran_view/sura_content_view/sura_content_list_view_item.dart';
import 'package:quran/quran.dart' as quran;

class SuraContentListView extends StatelessWidget {
  const SuraContentListView({super.key, required this.surahNumber});
  final int surahNumber;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .65,
          child: ListView.builder(

            itemCount: surahNumber==1||surahNumber==9?quran.getVerseCount(surahNumber):quran.getVerseCount(surahNumber)+1,
            itemBuilder: (context, index) {
              final bool isFirstItem = index == 0 && surahNumber != 9&&surahNumber !=1;

              return SuraContentListViewItem(

                surahNumber: surahNumber,
                verseNumber: surahNumber==1||surahNumber==9?index+1:index,
                isFirstItem: isFirstItem,
              );
            },
          ),
        ),
      ],
    );
  }
}
