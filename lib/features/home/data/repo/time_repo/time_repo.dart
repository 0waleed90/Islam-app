import 'package:adhan/adhan.dart';
import 'package:dartz/dartz.dart';
import 'package:islam/core/errors/failure.dart';

abstract class TimeRepo {
  Future<void>determinePosition();
  Future<Either<Failures,PrayerTimes>>getPrayerTimes();


}