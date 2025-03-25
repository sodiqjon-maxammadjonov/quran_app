import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:quran_app/src/core/data/service/suralar/ayah_service.dart';

import '../../models/quran/ayah_model.dart';

part 'ayah_event.dart';
part 'ayah_state.dart';

class AyahBloc extends Bloc<AyahEvent, AyahState> {
  AyahBloc() : super(AyahInitial()) {
    on<FetchAyahs>(onLoadAyahs);
  }

  FutureOr<void> onLoadAyahs (
  FetchAyahs event,
  Emitter<AyahState> emit) async {
    await AyahService(emit: emit).getSurahAyahs(event.surahNumber);
  }
}
