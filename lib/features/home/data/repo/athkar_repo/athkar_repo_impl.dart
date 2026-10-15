import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:islam/core/errors/failure.dart';
import 'package:islam/features/home/data/models/athkar_model.dart';
import 'package:islam/features/home/data/repo/athkar_repo/athkar_repo.dart';

class AthkarRepoImpl implements AthkarRepo{
  @override
  Future<Either<Failures, List<AthkarModel>>> fetchAthkar() async {
   try{
     var response =await  rootBundle.loadString('assets/json/athkar.json');
     List<dynamic> data=await json.decode( response);
List<AthkarModel> athkarList=data.map((e) => AthkarModel.fromJson(e)).toList();
     return right(athkarList);
   }catch(e){
     return left(ServerFailure(e.toString()));
   }
  }
}