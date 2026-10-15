abstract class QuranState {}
class QuranInitial extends QuranState{}
class QuranSearchResults extends QuranState{

  final List<int>result;

  QuranSearchResults({required this.result});
}
class QuranHistoryUpdated extends QuranState{
  final List<int> suraNumbers;

  QuranHistoryUpdated({required this.suraNumbers});
}

