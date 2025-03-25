import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/src/core/data/bloc/surah/surah_bloc.dart';
import 'package:quran_app/src/core/data/models/quran/surah_model.dart';
import '../db_service/local_storage.dart';

class SurahService {
  final Emitter<SurahState> emit;
  SurahService({required this.emit});

  final String baseUrl = 'https://api.alquran.cloud/v1';

  Future<void> getAllSurah() async {
    String language = await LocalStorage().getLanguage();
    emit(SurahLoading());

    try {
      final response = await http.get(Uri.parse('$baseUrl/surah'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> surahJson = data['data'];

        List<SurahModel> surah = surahJson.map((json) {
          String englishName = json['englishName'];
          String arabicName = json['name'];
          String translation = '';

          if (language == 'en') {
            translation = json['englishNameTranslation'];
          } else if (language == 'ru') {
            translation = json['russianNameTranslation'] ?? englishName;
          } else if (language == 'uz') {
            translation = json['uzbekNameTranslation'] ?? englishName;
          }

          print(
              'Sura ID: ${json['number']}, Arabcha: $arabicName, Inglizcha: $englishName, Tarjima ($language): $translation');

          return SurahModel.fromJson(json, language);
        }).toList();

        emit(SurahLoaded(surah));
      } else {
        emit(SurahError('API xatosi: ${response.statusCode}'));
      }
    } catch (e) {
      emit(SurahError('Xatolik: $e'));
    }
  }
}
