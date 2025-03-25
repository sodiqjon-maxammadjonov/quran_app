class AyahModel {
  final int number;
  final String arabicText;
  final String translatedText;
  final String? audioUrl;
  final int? juz;
  final int? page;
  final int? hizbQuarter;
  final bool? sajdah;

  const AyahModel({
    required this.number,
    required this.arabicText,
    required this.translatedText,
    this.audioUrl,
    this.juz,
    this.page,
    this.hizbQuarter,
    this.sajdah
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
        number: json['number'] ?? 0,
        arabicText: json['text'] ?? '',
        translatedText: json['translation'] ?? '',
        audioUrl: json['audio'] ?? '',
        juz: json['juz'],
        page: json['page'],
        hizbQuarter: json['hizbQuarter'],
        sajdah: json['sajdah'] ?? false
    );
  }

  Map<String, dynamic> toJson() => {
    'number': number,
    'text': arabicText,
    'translation': translatedText,
    'audio': audioUrl,
    'juz': juz,
    'page': page,
    'hizbQuarter': hizbQuarter,
    'sajdah': sajdah
  };

  @override
  String toString() {
    return 'AyahModel(number: $number, arabicText: $arabicText, translatedText: $translatedText)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AyahModel &&
        other.number == number &&
        other.arabicText == arabicText &&
        other.translatedText == translatedText;
  }

  @override
  int get hashCode =>
      number.hashCode ^
      arabicText.hashCode ^
      translatedText.hashCode;
}