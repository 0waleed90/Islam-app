import 'package:adhan/adhan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islam/features/home/presentation/manger/time_cubit/time_state.dart';

import '../../../data/repo/time_repo/time_repo.dart';

class TimeCubit extends Cubit<TimeState> {

  TimeCubit(this.timeRepo) : super(TimeInitial());
  final TimeRepo timeRepo;

  Future<PrayerTimes?> getPrayerTimes() async {

    emit(TimeLoading());
    var result = await timeRepo.getPrayerTimes();
    result.fold(
      (failure) {
        emit(TimeFailure(errorMessage: failure.errorMessage));
      },
      (prayerTimes) {

        emit(TimeSuccess(prayerTimes:prayerTimes));
      },
    );
  }
}
