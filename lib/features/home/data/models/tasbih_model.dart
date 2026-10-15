class TasbihModel {
  final String zkr;
  final String title;
  final int goal;
  TasbihModel({required this.zkr, required this.title, required this.goal});

  factory TasbihModel.fromJson(Map<String, dynamic> json) {
    return TasbihModel(
      zkr: json['zkr'],
      title: json['title'],
      goal: json['goal'],
    );
  }
}
