import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/src/core/const/api/api.dart';
import 'package:quran_app/src/core/data/bloc/ayah/ayah_bloc.dart';
import 'package:quran_app/src/core/data/service/db_service/local_storage.dart';
import '../../models/quran/ayah_model.dart';

class AyahService {
  final Emitter<AyahState> emit;
  AyahService({required this.emit});

  Future<void> getSurahAyahs(int surahNumber) async {
    emit(AyahLoading()); // 📌 Ma'lumot yuklanayotgani holati

    String language = await LocalStorage().getLanguage();

    try {
      // 📌 Til bo'yicha tarjima tanlash
      String translation = 'en.sahih'; // Default: Inglizcha
      if (language == 'ru') translation = 'ru.kuliev'; // Ruscha
      if (language == 'uz') translation = 'uz.sodik';  // O'zbekcha

      // 📌 Arabcha text va tarjima uchun API so'rovlari
      final responses = await Future.wait([
        http.get(Uri.parse('${Api.baseUrl}/surah/$surahNumber/ar.alafasy')),
        http.get(Uri.parse('${Api.baseUrl}/surah/$surahNumber/$translation')),
        http.get(Uri.parse('${Api.baseUrl}/surah/$surahNumber/audio'))
      ]);

      if (responses.every((response) => response.statusCode == 200)) {
        final arabicData = json.decode(responses[0].body);
        final translationData = json.decode(responses[1].body);
        final audioData = json.decode(responses[2].body);

        List<dynamic> arabicAyahs = arabicData['data']['ayahs'];
        List<dynamic> translatedAyahs = translationData['data']['ayahs'];
        List<dynamic> audioAyahs = audioData['data']['ayahs'];

        // Ayahlarni bir-biriga moslashtirish
        List<AyahModel> ayahs = List.generate(translatedAyahs.length, (index) {
          return AyahModel(
              number: translatedAyahs[index]['number'] ?? 0,
              arabicText: arabicAyahs[index]['text'] ?? '',
              translatedText: translatedAyahs[index]['text'] ?? '',
              audioUrl: index < audioAyahs.length ? audioAyahs[index]['audio'] ?? '' : '',
              juz: translatedAyahs[index]['juz'],
              page: translatedAyahs[index]['page'],
              hizbQuarter: translatedAyahs[index]['hizbQuarter'],
              sajdah: translatedAyahs[index]['sajdah'] ?? false
          );
        });

        emit(AyahLoaded(ayahs)); // 📌 Ma'lumot yuklandi

      } else {
        emit(AyahError('API xatosi: ${responses.map((res) => res.statusCode).join(", ")}'));
      }
    } catch (e) {
      emit(AyahError('Xatolik: $e'));
    }
  }

  // 📌 Ixtiyoriy: Ayah uchun audio URL olish
  Future<void> getAyahAudioUrl(int surahNumber, int ayahNumber) async {
    emit(AyahLoading());

    try {
      final response = await http.get(
          Uri.parse('${Api.baseUrl}/surah/$surahNumber/audio')
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> audioAyahs = data['data']['ayahs'];

        final audioData = audioAyahs.firstWhere(
              (ayah) => ayah['number'] == ayahNumber,
          orElse: () => null,
        );

        if (audioData != null) {
          emit(AyahAudioLoaded(audioData['audio']));
        } else {
          emit(AyahError('Audio topilmadi'));
        }
      } else {
        emit(AyahError('API xatosi: ${response.statusCode}'));
      }
    } catch (e) {
      emit(AyahError('Xatolik: $e'));
    }
  }
}
