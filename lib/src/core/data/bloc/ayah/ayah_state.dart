part of 'ayah_bloc.dart';

@immutable
sealed  class AyahState extends Equatable {
  const AyahState();

  @override
  List<Object?> get props => [];
}

// 📌 Dastlabki holat
class AyahInitial extends AyahState {}

// 📌 Yukunish holati
class AyahLoading extends AyahState {}

// 📌 Muvaffaqiyatli yuklangan holat
class AyahLoaded extends AyahState {
  final List<AyahModel> ayahs;

  const AyahLoaded(this.ayahs);

  @override
  List<Object?> get props => [ayahs];
}
// 📌 Ayah audio yuklangan holat
class AyahAudioLoaded extends AyahState {
  final String audioUrl;

  const AyahAudioLoaded(this.audioUrl);

  @override
  List<Object?> get props => [audioUrl];
}

// 📌 Xatolik holati
class AyahError extends AyahState {
  final String message;

  const AyahError(this.message);

  @override
  List<Object?> get props => [message];
}
