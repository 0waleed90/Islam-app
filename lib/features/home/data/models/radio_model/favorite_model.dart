class FavoriteModel {
  final String qareeName;
  final String suraName;

  FavoriteModel({required this.suraName, required this.qareeName});

  Map<String, dynamic> toJson() {
    return {
      'qareeName': qareeName,
      'suraNumber': suraName,
    };
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      qareeName: json['qareeName'] ?? '',
      suraName: json['suraNumber'] ?? 0,
    );
  }
}
