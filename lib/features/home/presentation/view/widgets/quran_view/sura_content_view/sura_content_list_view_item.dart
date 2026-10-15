import 'package:flutter/material.dart';
import 'package:islam/core/constants.dart';
import 'package:islam/core/util/styles.dart';
import 'package:quran/quran.dart' as quran;

class SuraContentListViewItem extends StatelessWidget {
  const SuraContentListViewItem({
    super.key,
    this.surahNumber,
    this.verseNumber,
    required this.isFirstItem,
  });
  final int? surahNumber;
  final int? verseNumber;
  final bool isFirstItem;

  @override
  Widget build(BuildContext context) {
    String getHintText() {
      if (isFirstItem) {
        return quran.basmala;
      } else if (verseNumber == 1 && surahNumber != 1 && surahNumber != 9) {
        return quran
            .getVerse(surahNumber!, 1, verseEndSymbol: true)
            .substring(39);
      } else {
        return '${quran.getVerse(surahNumber!, verseNumber!, verseEndSymbol: true)}   ';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        textAlign: TextAlign.center,
        maxLines: null,
        readOnly: true,
        decoration: InputDecoration(
          hintText: getHintText(),
          hintStyle: Styles.textStyle20,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
