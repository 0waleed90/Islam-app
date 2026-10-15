class RadioModel {
  RadioModel({required this.suraNumber, required this.suraName});

  String getRadioUrl(String serverUrl) {
    String fileName = suraNumber.toString().padLeft(3, '0');
    return "$serverUrl$fileName.mp3";
  }

  final int suraNumber;
  final String suraName;
}
