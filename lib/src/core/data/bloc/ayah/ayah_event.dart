part of 'ayah_bloc.dart';

@immutable
sealed class AyahEvent extends Equatable {
  const AyahEvent();

  @override
  List<Object?> get props => [];
}

// 📌 Suraning oyatlarini olish
class FetchAyahs extends AyahEvent {
  final int surahNumber;

  const FetchAyahs(this.surahNumber);

  @override
  List<Object?> get props => [surahNumber];
}