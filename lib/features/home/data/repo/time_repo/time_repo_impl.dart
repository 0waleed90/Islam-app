import 'package:adhan/adhan.dart';
import 'package:dartz/dartz.dart';
import 'package:islam/features/home/data/repo/time_repo/time_repo.dart';
import 'package:location/location.dart';

import '../../../../../core/errors/failure.dart';

class TimeRepoImpl implements TimeRepo {
  @override
  Future<LocationData?> determinePosition() async {
    Location location=Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;


    // 1. التحقق من تفعيل خدمة الـ GPS في الهاتف
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return null;
    }

    // 2. التحقق من صلاحيات الموقع
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return null;
    }

    // 3. جلب الموقع (يعمل عبر الـ GPS بدون إنترنت)
    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
    });

return await location.getLocation();

  }

  @override
  Future<Either<Failures,PrayerTimes>> getPrayerTimes() async {
    try {
      LocationData? position = await determinePosition();
      print(position!.latitude );
      print(position.longitude);
      final coordinates = Coordinates(position!.latitude!, position.longitude!);
      final dateComponents = DateComponents.from(DateTime.now());

      final params = CalculationMethod.muslim_world_league.getParameters();
      params.madhab = Madhab.shafi;

      final prayTimes = PrayerTimes(coordinates, dateComponents, params);
      return right(prayTimes);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
