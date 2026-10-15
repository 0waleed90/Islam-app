import 'package:dartz/dartz.dart';
import 'package:islam/core/errors/failure.dart';
import 'package:islam/features/home/data/models/athkar_model.dart';

abstract class AthkarRepo {
  Future<Either<Failures,List<AthkarModel>>> fetchAthkar();


}