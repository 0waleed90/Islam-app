import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islam/features/home/data/repo/athkar_repo/athkar_repo.dart';
import 'package:islam/features/home/presentation/manger/athkar_cubit/athkar_state.dart';

import '../../../data/repo/tasbih_repo/tasbih_repo.dart';

class AthkarCubit extends Cubit<AthkarState> {
  AthkarCubit(this.athkarRepo) : super(AthkarInitial());
  final AthkarRepo athkarRepo;

  Future<void> fetchAthkar() async {
    emit(AthkarLoading());

    var result = await athkarRepo.fetchAthkar();
    result.fold(
      (failure) {
        emit(AthkarFailure(errorMesage: failure.errorMessage));
      },
      (athkar) {
        emit(AthkarSuccess(athkar: athkar));
      },
    );
  }

}
