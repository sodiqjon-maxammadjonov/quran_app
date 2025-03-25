import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:quran_app/src/core/data/models/quran/surah_model.dart';
import 'package:quran_app/src/core/data/service/suralar/suralar_service.dart';

part 'surah_event.dart';
part 'surah_state.dart';


class SurahBloc extends Bloc<SurahEvent, SurahState> {
  SurahBloc() : super(SurahInitial()) {
    on<LoadSurah>(onLoadSurah);
  }
  FutureOr<void> onLoadSurah(LoadSurah event, Emitter<SurahState> emit) async {
    await SurahService(emit: emit).getAllSurah();
  }
}