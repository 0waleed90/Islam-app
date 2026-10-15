import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:islam/features/home/presentation/manger/quran_cubit/quran_state.dart';
import 'package:quran/quran.dart' as quran;

class QuranCubit extends Cubit<QuranState> {
  QuranCubit(): super(QuranInitial());
  List<int> recentlyRead = [];

  void searchQuran(String query) {
    if (query.isEmpty) {
      emit(QuranInitial());
    } else {
      List<int> results = [];
      for (int i = 1; i <= quran.totalSurahCount; i++) {
        String nameEn = quran.getSurahName(i).toLowerCase();
        String nameAr = quran.getSurahNameArabic(i);
        if (nameEn.contains(query.toLowerCase()) || nameAr.contains(query)) {
          results.add(i);
        }
      }
      emit(QuranSearchResults(result: results));
    }
  }

  void addToHistory(int suraNumber) {
  recentlyRead.remove(suraNumber);
  recentlyRead.insert(0, suraNumber);
  if(recentlyRead.length>=10){recentlyRead.removeLast();}
  var box = Hive.box('settings');
  box.put('recentlyRead', recentlyRead);
  emit(QuranHistoryUpdated(suraNumbers: recentlyRead));
  }
  void loadHistory(){
    var box = Hive.box('settings');
    recentlyRead = box.get('recentlyRead',defaultValue: [])?.cast<int>()??[];
    emit(QuranHistoryUpdated(suraNumbers: recentlyRead));
  }
}
