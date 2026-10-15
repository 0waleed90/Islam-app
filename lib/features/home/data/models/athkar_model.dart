class AthkarModel {
  final String category;
  final String zekr;
  final String description;
  final int count;
  final String reference;

  AthkarModel({
    required this.category,
    required this.zekr,
    required this.description,
    required this.count,
    required this.reference,
  });
  factory AthkarModel.fromJson(Map<String, dynamic> json) {
    return AthkarModel(
      category: json['category'],
      zekr: json['zekr'],
      description: json['description'],
      count: json['count'],
      reference: json['reference'],
    );
  }
}
