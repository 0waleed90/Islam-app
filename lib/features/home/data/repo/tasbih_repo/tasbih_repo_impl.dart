import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:islam/core/errors/failure.dart';
import 'package:islam/features/home/data/repo/tasbih_repo/tasbih_repo.dart';

import '../../models/tasbih_model.dart';

class TasbihRepoImpl implements TasbihRepo {
  @override
  Future<Either<Failures, List<TasbihModel>>> fetchTasbih() async {
    try {
      String response = await rootBundle.loadString('assets/json/tasbih.json');
      List<dynamic> data = json.decode(response);
      List<TasbihModel> tasbihList = data
          .map((e) => TasbihModel.fromJson(e))
          .toList();
      return right(tasbihList);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  int tasbihCount() {
    // TODO: implement tasbihCount
    throw UnimplementedError();
  }
}
