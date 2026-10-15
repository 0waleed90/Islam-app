import 'package:dartz/dartz.dart';
import 'package:islam/core/errors/failure.dart';
import 'package:islam/features/home/data/models/radio_model/reciter_model.dart';
import 'package:just_audio/just_audio.dart';
import '../../models/radio_model/radio_model.dart';

abstract class RadioRepo {
  List<ReciterModel> get reciters;
  List<RadioModel> fetchSurahs();
  Future<Either<Failures, void>> playSura(int index);
  void pauseRadio();
  Future<void> close();
  void changeReciter(int index);
  AudioPlayer get player;
}
