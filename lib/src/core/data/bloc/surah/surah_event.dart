part of 'surah_bloc.dart';

@immutable
sealed class SurahEvent extends Equatable {
  const SurahEvent();

  @override
  List<Object> get props => [];
}

// 🔹 Suralarni yuklash uchun event
class LoadSurah extends SurahEvent {}