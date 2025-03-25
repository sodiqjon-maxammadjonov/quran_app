class SurahModel {
  final int number;
  final String name;
  final String arabicName;
  final int ayahCount;

  SurahModel({
    required this.number,
    required this.name,
    required this.arabicName,
    required this.ayahCount,
  });

  // 📌 Til bo‘yicha nomni olish
  factory SurahModel.fromJson(Map<String, dynamic> json, String language) {
    String name = json['englishName']; // Default: English
    if (language == 'ru') name = json['russianName'] ?? json['englishName'];
    if (language == 'uz') name = json['uzbekName'] ?? json['englishName'];

    return SurahModel(
      number: json['number'],
      name: name,
      arabicName: json['name'], // Arabcha nom
      ayahCount: json['numberOfAyahs'],
    );
  }
}
