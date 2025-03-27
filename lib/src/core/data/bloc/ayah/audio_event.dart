part of 'audio_bloc.dart';

@immutable
sealed class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object?> get props => [];
}

class FetchAyahAudio extends AudioEvent {
  final int ayahNumber;

  const FetchAyahAudio(this.ayahNumber);

  @override
  List<Object?> get props => [ayahNumber];
}