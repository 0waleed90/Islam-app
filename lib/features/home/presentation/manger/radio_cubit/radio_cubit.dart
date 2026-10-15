import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:islam/features/home/presentation/manger/radio_cubit/radio_state.dart';
import 'package:islam/features/home/data/models/radio_model/radio_model.dart';
import 'package:islam/features/home/data/repo/radio_repo/radio_repo.dart';

import '../../../data/models/radio_model/favorite_model.dart';

class RadioCubit extends Cubit<RadioState> {
  RadioCubit({required this.radioRepo}) : super(RadioInitial());
  final RadioRepo radioRepo;
  List<RadioModel> allSurahs = [];
  int currentIndex = 0;
  String nameQaree = '';
  int selectedReciterIndex = 0;

  List<FavoriteModel> favorite = [];
  void fetchSurahs() {
    var box = Hive.box('settings');
    int savedIndex = box.get('reciterIndex', defaultValue: 0);
    radioRepo.changeReciter(savedIndex);
    nameQaree = radioRepo.reciters[savedIndex].name;

    allSurahs = radioRepo.fetchSurahs();
    emit(
      RadioSuccess(
        surahs: allSurahs,
        currentSura: currentIndex,
        isPlaying: false,
        isBuffering: false,
        favorites: favorite,
      ),
    );
  }

  Future<void> playSura(int index) async {
    currentIndex = index;
    emit(
      RadioSuccess(
        surahs: allSurahs,
        currentSura: currentIndex,
        isPlaying: false,
        isBuffering: true,
        favorites: favorite,
      ),
    );
    var result = await radioRepo.playSura(index);
    result.fold(
      (failure) {
        emit(
          RadioSuccess(
            surahs: allSurahs,
            currentSura: currentIndex,
            isPlaying: false,
            isBuffering: false,
            playbackError: failure.errorMessage,
            favorites: favorite,
          ),
        );
      },
      (play) {
        emit(
          RadioSuccess(
            surahs: allSurahs,
            currentSura: currentIndex,
            isPlaying: true,
            isBuffering: false,
            favorites: favorite,
          ),
        );
      },
    );
  }

  void pauseRadio() {
    radioRepo.pauseRadio();
    emit(
      RadioSuccess(
        surahs: allSurahs,
        currentSura: currentIndex,
        isPlaying: false,
        isBuffering: false,
        favorites: favorite,
      ),
    );
  }

  void closeAudioPlayer() {
    radioRepo.close();
  }

  void changeReciter(int index) {
    selectedReciterIndex = index;
    nameQaree = radioRepo.reciters[index].name;
    radioRepo.changeReciter(index);
    var box = Hive.box('settings');
    box.put('reciterIndex', selectedReciterIndex);

    emit(
      RadioSuccess(
        surahs: allSurahs,
        currentSura: currentIndex,
        isPlaying: false,
        favorites: favorite,
      ),
    );
  }

  @override
  Future<void> close() {
    radioRepo.close();
    return super.close();
  }

  void addToFavorite(String suraName, String qareeName) {
    favorite.add(FavoriteModel(suraName: suraName, qareeName: qareeName));
    var box = Hive.box('settings');
    box.put('favorite', favorite.map((e)=>e.toJson()).toList());
    emit(
      RadioSuccess(
        surahs: allSurahs,
        currentSura: currentIndex,
        isPlaying: false,
        favorites: List.from(favorite),
      ),
    );
  }

  void removeFromFavorite(String suraName, String qareeName) {
    favorite.removeWhere(
      (element) =>
          element.suraName == suraName && element.qareeName == qareeName,
    );
    var box = Hive.box('settings');
     box.put('favorite', favorite.map((e)=>e.toJson()).toList());
    emit(
      RadioSuccess(
        surahs: allSurahs,
        currentSura: currentIndex,
        isPlaying: false,
        favorites: List.from(favorite),
      ),
    );
  }

  void getFavorite() {
      var box = Hive.box('settings');
      var rawData = box.get('favorite',defaultValue: [])as List;
    favorite = rawData.map((e) => FavoriteModel.fromJson(Map<String,dynamic>.from(e))).toList();
    emit(
      RadioSuccess(
        surahs: allSurahs,
        currentSura: currentIndex,
        isPlaying: false,
        favorites: favorite,
      ),
    );
  }
}
