class HadithModel {
  final int hadithNumber;
  final String title;
  final String hadith;
  final String source; // المسند / المخرج

  HadithModel({
    required this.hadithNumber,
    required this.title,
    required this.hadith,
    required this.source,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) {
    return HadithModel(
      hadithNumber: json['hadithNumber'],
      title: json['title'],
      hadith: json['hadith'],
      source: json['source'] ?? '',
    );
  }
}
