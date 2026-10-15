import 'package:islam/features/home/data/models/radio_model/radio_model.dart';

import '../../../data/models/radio_model/favorite_model.dart';

abstract class RadioState {}

class RadioInitial extends RadioState {}

class RadioLoading extends RadioState {}

class RadioSuccess extends RadioState {
  final List<RadioModel> surahs;
  final int currentSura;
  final bool isPlaying;
  final bool isBuffering;
  final String? playbackError;
  final List<FavoriteModel> favorites;

  RadioSuccess({
    required this.surahs,
    required this.currentSura,
    required this.isPlaying,
    this.isBuffering = false,
    this.playbackError,
    required this.favorites,
  });
}

class RadioFailure extends RadioState {
  final String errorMessage;

  RadioFailure({required this.errorMessage});
}
