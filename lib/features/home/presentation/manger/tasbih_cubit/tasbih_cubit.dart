import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islam/features/home/data/models/tasbih_model.dart';
import 'package:islam/features/home/presentation/manger/tasbih_cubit/tasbih_state.dart';

import '../../../data/repo/tasbih_repo/tasbih_repo.dart';

class TasbihCubit extends Cubit<TasbihState> {
  final TasbihRepo tasbihRepo;

  TasbihCubit(this.tasbihRepo) : super(TasbihInitial());
  int currentZkr = 0;
  int counter = 0;
  List<TasbihModel> allTasbih = [];
  Future<void> fetchTasbih() async {
    emit(TasbihLoading());
    var result = await tasbihRepo.fetchTasbih();
    result.fold(
      (failure) {
        emit(TasbihFailure(failure.errorMessage));
      },
      (tasbih) {
        allTasbih = tasbih;
        emit(TasbihSuccess(tasbih, currentZkr, counter));
      },
    );
  }

  void nextZkr() {
    counter = 0;
    if (currentZkr != allTasbih.length - 1) {
      currentZkr++;
      emit(TasbihSuccess(allTasbih, currentZkr, counter));
    } else {
      currentZkr = 0;
      emit(TasbihSuccess(allTasbih, currentZkr, counter));
    }
  }

  void previousZkr() {
    counter = 0;
    if (currentZkr != 0) {
      currentZkr--;
      emit(TasbihSuccess(allTasbih, currentZkr, counter));
    } else {
      currentZkr = allTasbih.length - 1;
      emit(TasbihSuccess(allTasbih, currentZkr, counter));
    }
  }

  void increaseCounter() {
    counter++;
    if (counter == allTasbih[currentZkr].goal) {
      HapticFeedback.heavyImpact();
      Future.delayed(
        const Duration(milliseconds: 150),
        () => HapticFeedback.vibrate(),
      );
      Future.delayed(
        const Duration(milliseconds: 300),
        () => HapticFeedback.heavyImpact(),
      );
    } else {
      HapticFeedback.lightImpact();
    }

    emit(TasbihSuccess(allTasbih, currentZkr, counter));
  }



}
