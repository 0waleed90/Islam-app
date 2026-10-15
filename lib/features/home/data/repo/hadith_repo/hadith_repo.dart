import 'package:dartz/dartz.dart';
import 'package:islam/core/errors/failure.dart';
import 'package:islam/features/home/data/models/hadith_model.dart';

abstract class HadithRepo {
  Future<Either<Failures, List<HadithModel>>> fetchHadith();
}
