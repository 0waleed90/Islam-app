import 'package:adhan/adhan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:islam/features/home/presentation/manger/time_cubit/time_state.dart';
import 'package:islam/features/home/presentation/view/widgets/time_view/athan_notification_service.dart';

import '../../../data/repo/time_repo/time_repo.dart';

class TimeCubit extends Cubit<TimeState> {

  TimeCubit(this.timeRepo) : super(TimeInitial());
  final TimeRepo timeRepo;

  Future<void> getPrayerTimes() async {

    emit(TimeLoading());
    var result = await timeRepo.getPrayerTimes();
    result.fold(
      (failure) {
        emit(TimeFailure(errorMessage: failure.errorMessage));
      },
      (prayerTimes) {
        var settingsBox = Hive.box('settings');
        bool isAthanEnabled = settingsBox.get('isAthanEnabled', defaultValue: true);
        if (isAthanEnabled) {
          AthanNotificationService.scheduleAthanNotification(
            id: 1,
            prayerName: 'الفجر',
            scheduledTime: prayerTimes.fajr,
          );
          AthanNotificationService.scheduleAthanNotification(
            id: 2,
            prayerName: 'الظهر',
            scheduledTime: prayerTimes.dhuhr,
          );
          AthanNotificationService.scheduleAthanNotification(
            id: 3,
            prayerName: 'العصر',
            scheduledTime: prayerTimes.asr,
          );
          AthanNotificationService.scheduleAthanNotification(
            id: 4,
            prayerName: 'المغرب',
            scheduledTime: prayerTimes.maghrib,
          );
          AthanNotificationService.scheduleAthanNotification(
            id: 5,
            prayerName: 'العشاء',
            scheduledTime: prayerTimes.isha,
          );
        }

        emit(TimeSuccess(prayerTimes: prayerTimes));
      },
    );
  }
}
