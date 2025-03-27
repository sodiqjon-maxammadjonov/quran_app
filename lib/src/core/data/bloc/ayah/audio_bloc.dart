import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:quran_app/src/core/data/service/suralar/audio_service.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc() : super(AudioInitial()) {
    on<FetchAyahAudio>(onLoadAyahAudio);
  }

  FutureOr<void> onLoadAyahAudio(
      FetchAyahAudio event,
      Emitter<AudioState> emit,
      ) async {
    await AudioService(emit: emit).getAyahAudioUrl(event.ayahNumber);
    print('object bosildi');
  }
}
