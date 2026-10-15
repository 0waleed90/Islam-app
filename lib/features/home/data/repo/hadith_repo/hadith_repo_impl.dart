import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:islam/core/errors/failure.dart';
import 'package:islam/features/home/data/models/hadith_model.dart';
import 'package:islam/features/home/data/repo/hadith_repo/hadith_repo.dart';

class HadithRepoImpl implements HadithRepo {
  @override
  Future<Either<Failures, List<HadithModel>>> fetchHadith() async {
    try {
      // 1. قراءة ملف الـ JSON من الـ assets
      String response = await rootBundle.loadString('assets/json/hadiths.json');
      
      // 2. تحويل النص إلى List
      List<dynamic> data = json.decode(response);
      
      // 3. تحويل الـ List إلى قائمة من HadithModel
      List<HadithModel> hadithsList = data.map((e) => HadithModel.fromJson(e)).toList();
      
      return right(hadithsList);
    } catch (e) {
      return left(ServerFailure('حدث خطأ أثناء تحميل الأحاديث: ${e.toString()}'));
    }
  }
}
