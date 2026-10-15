import 'package:dartz/dartz.dart';
import 'package:islam/core/errors/failure.dart';

import '../../models/tasbih_model.dart';

abstract class TasbihRepo {
  Future<Either<Failures, List<TasbihModel>>> fetchTasbih();
  int tasbihCount();
}
