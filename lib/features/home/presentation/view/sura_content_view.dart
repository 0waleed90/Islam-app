import 'package:flutter/material.dart';
import 'package:islam/features/home/presentation/view/widgets/quran_view/sura_content_view/sura_content_view_body.dart';

 //the Body of this page is in quranView    >>  SuraContentView


class SuraContentView extends StatelessWidget {
  const SuraContentView({super.key, required this.surahNumber});
final int surahNumber;
  @override
  Widget build(BuildContext context) {
    return SuraContentViewBody(surahNumber: surahNumber,);
  }
}
