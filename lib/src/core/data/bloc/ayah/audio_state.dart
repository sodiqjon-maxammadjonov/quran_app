part of 'audio_bloc.dart';

@immutable
sealed class AudioState extends Equatable {
  const AudioState();

  @override
  List<Object?> get props => [];
}

final class AudioInitial extends AudioState {
  const AudioInitial();
}

// 📌 Ayah audio yuklanayotgan holat
class AyahAudioLoading extends AudioState {
  final int ayahNumber;

  const AyahAudioLoading(this.ayahNumber);

  @override
  List<Object?> get props => [ayahNumber];
}

// 📌 Ayah audio yuklangan holat
class AyahAudioLoaded extends AudioState {
  final String audioUrl;

  const AyahAudioLoaded(this.audioUrl);

  @override
  List<Object?> get props => [audioUrl];
}

// 📌 Xatolik holati
class AyahError extends AudioState {
  final String message;

  const AyahError(this.message);

  @override
  List<Object?> get props => [message];
}