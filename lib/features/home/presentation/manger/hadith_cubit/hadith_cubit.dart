import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islam/features/home/data/models/hadith_model.dart';
import 'package:islam/features/home/data/repo/hadith_repo/hadith_repo.dart';
import 'package:islam/features/home/presentation/manger/hadith_cubit/hadith_state.dart';

class HadithCubit extends Cubit<HadithState> {
  List<HadithModel> allHadiths = [];
  final HadithRepo hadithRepo;
  HadithCubit(this.hadithRepo) : super(HadithInitial());
  Future<void> fetchHadithData() async {
    emit(HadithLoading());
    var result = await hadithRepo.fetchHadith();
    result.fold(
      (failure) {
        emit(HadithFailure(failure.errorMessage));
      },
      (hadith) {
        allHadiths = hadith;
        emit(HadithSuccess(hadith));
      },
    );
  }

  void searchHadith(String query) {
    if (query.isEmpty) {
      emit(HadithSuccess(allHadiths));
    } else {
      // دالة لتنظيف النص من التشكيل (أ، إ، آ -> ا) وأيضاً الحركات
      String normalize(String text) {
        return text
            .replaceAll(
              RegExp(r'[\u064B-\u0652]'),
              '',
            ) // إزالة الحركات (فتحة، ضمة...)
            .replaceAll('أ', 'ا')
            .replaceAll('إ', 'ا')
            .replaceAll('آ', 'ا')
            .replaceAll('ة', 'ه')
            .replaceAll("ي", "ى");
      }

      final normalizedQuery = normalize(query);

      final filteredHadiths = allHadiths.where((hadith) {
        // ننظف العنوان ونص الحديث قبل مقارنتهما بكلمة البحث
        final normalizedTitle = normalize(hadith.title);
        final normalizedContent = normalize(hadith.hadith);

        return normalizedTitle.contains(normalizedQuery) ||
            normalizedContent.contains(normalizedQuery);
      }).toList();

      emit(HadithSuccess(filteredHadiths));
    }
  }
}
