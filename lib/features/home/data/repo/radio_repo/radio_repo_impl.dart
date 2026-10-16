import 'package:dartz/dartz.dart';
import 'package:islam/core/errors/failure.dart';
import 'package:islam/features/home/data/models/radio_model/reciter_model.dart';
import 'package:islam/features/home/data/repo/radio_repo/radio_repo.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quran/quran.dart' as quran;

import '../../models/radio_model/radio_model.dart';

class RadioRepoImpl implements RadioRepo {
  final AudioPlayer audioPlayer = AudioPlayer();
  String? lastUrl;
  int currentIndex = 0;
  List<RadioModel> allSurahs = [];

  @override
  final List<ReciterModel> reciters = [
    ReciterModel(name: "محمد اللحيدان", serverUrl: "https://server8.mp3quran.net/lhdan/"),
    ReciterModel(name: "عبد الباسط عبد الصمد", serverUrl: "https://server7.mp3quran.net/basit/"),
    ReciterModel(name: "مشاري العفاسي", serverUrl: "https://server8.mp3quran.net/afs/"),
    ReciterModel(name: "ماهر المعيقلي", serverUrl: "https://server12.mp3quran.net/maher/"),
    ReciterModel(name: "ياسر الدوسري", serverUrl: "https://server11.mp3quran.net/yasser/"),
    ReciterModel(name: "عبد الرحمن السديس", serverUrl: "https://server11.mp3quran.net/sds/"),
    ReciterModel(name: "سعود الشريم", serverUrl: "https://server7.mp3quran.net/shur/"),
    ReciterModel(name: "ناصر القطامي", serverUrl: "https://server6.mp3quran.net/qtm/"),
    ReciterModel(name: "رعد محمد الكردي", serverUrl: "https://server6.mp3quran.net/kurdi/"),
  ];

  int selectedReciterIndex = 0;

  @override
  List<RadioModel> fetchSurahs() {
    allSurahs = List.generate(114, (index) {
      return RadioModel(
        suraNumber: index + 1,
        suraName: quran.getSurahNameArabic(index + 1),
      );
    });
    return allSurahs;
  }

  @override
  Future<void> pauseRadio() {
    return audioPlayer.pause();
  }

  @override
  Future<Either<Failures, void>> playSura(int index) async {
    try {
      String url = allSurahs[index].getRadioUrl(reciters[selectedReciterIndex].serverUrl.trim());
      if (lastUrl != url) {
        await audioPlayer.setAudioSource(
          AudioSource.uri(
            Uri.parse(url),
            tag: MediaItem(
              id: url,
              album: reciters[selectedReciterIndex].name,
              title: "سورة ${allSurahs[index].suraName}",
            ),
          ),
        );
        lastUrl = url;
      }
      audioPlayer.play();
      currentIndex = index;

      return right(null);
    } catch (e) {
      return left(ServerFailure('فشل تحميل السورة، تأكد من اتصالك بالإنترنت'));
    }
  }

  @override
  Future close() async {
    await audioPlayer.dispose();
  }

  @override
  void changeReciter(int index) {
    if (selectedReciterIndex != index) {
      selectedReciterIndex = index;
      lastUrl = null;
    }
  }

  @override
  AudioPlayer get player => audioPlayer;
}
