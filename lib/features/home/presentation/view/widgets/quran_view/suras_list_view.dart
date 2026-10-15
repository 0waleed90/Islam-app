import 'package:flutter/material.dart';
import 'package:islam/features/home/presentation/view/widgets/quran_view/suras_list_view_item.dart';
import 'package:quran/quran.dart' as quran;
class SurasListView extends StatelessWidget {
  const SurasListView({super.key, });
@override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: quran.totalSurahCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: SurasListViewItem(surahNumber: index+1,),
        );
      },
    );
  }
}
