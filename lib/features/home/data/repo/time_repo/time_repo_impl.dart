import 'package:adhan/adhan.dart';
import 'package:dartz/dartz.dart';
import 'package:islam/features/home/data/repo/time_repo/time_repo.dart';
import 'package:location/location.dart';

import '../../../../../core/errors/failure.dart';

class TimeRepoImpl implements TimeRepo {
  @override
  Future<LocationData?> determinePosition() async {
    try {
      Location location = Location();
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) return null;
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) return null;
      }

      return await location.getLocation();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Either<Failures, PrayerTimes>> getPrayerTimes() async {
    try {
      LocationData? position = await determinePosition();
      if (position == null || position.latitude == null || position.longitude == null) {
        return left(ServerFailure('يرجى تفعيل خدمة الموقع (GPS) ومنح الصلاحية لحساب مواقيت الصلاة.'));
      }

      final coordinates = Coordinates(position.latitude!, position.longitude!);
      final dateComponents = DateComponents.from(DateTime.now());

      final params = CalculationMethod.muslim_world_league.getParameters();
      params.madhab = Madhab.shafi;

      final prayTimes = PrayerTimes(coordinates, dateComponents, params);
      return right(prayTimes);
    } catch (e) {
      return left(ServerFailure('حدث خطأ أثناء حساب مواقيت الصلاة'));
    }
  }
}
