import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:quran_app/src/core/data/bloc/ayah/audio_bloc.dart';
import 'package:http/http.dart' as http;
class AudioService {
  final Emitter<AudioState> emit;
  AudioService({required this.emit});
  Future<void> getAyahAudioUrl(int ayahNumber) async {
    try {
      emit(AyahAudioLoading(ayahNumber));

      final response = await http.get(
        Uri.parse('https://api.alquran.cloud/v1/ayah/$ayahNumber/ar.alafasy'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String audioUrl = data['data']['audio'];

        emit(AyahAudioLoaded(audioUrl));
      } else {
        print('Audio URL olishda xatolik: ${response.statusCode}');
        emit(AyahError('Audio URL olishda xatolik: ${response.statusCode}'));
      }
    } catch (e) {
      print('Audio URL olishda xatolik: $e');
      emit(AyahError('Audio URL olishda xatolik: $e'));
    }
  }
}