part of 'surah_bloc.dart';

@immutable
sealed class SurahState extends Equatable {
  const SurahState();

  @override
  List<Object> get props => [];
}

class SurahInitial extends SurahState {}

class SurahLoading extends SurahState {}

class SurahLoaded extends SurahState {
  final List<SurahModel> surah;

  const SurahLoaded(this.surah);

  @override
  List<Object> get props => [surah];
}

class SurahError extends SurahState {
  final String message;

  const SurahError(this.message);

  @override
  List<Object> get props => [message];
}