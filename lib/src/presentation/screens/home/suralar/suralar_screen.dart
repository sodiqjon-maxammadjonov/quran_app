import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/src/core/data/bloc/surah/surah_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quran_app/src/presentation/screens/home/suralar/ayahs_screen.dart';
import '../../../utils/widgets/cards/surah_card.dart';

class SurahScreen extends StatefulWidget {
  const SurahScreen({super.key});

  @override
  State<SurahScreen> createState() => _SurahScreenState();
}

class _SurahScreenState extends State<SurahScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SurahBloc>().add(LoadSurah());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.suralar),
        centerTitle: true,
      ),
      body: BlocConsumer<SurahBloc, SurahState>(
        listener: (context, state) {
          if (state is SurahError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SurahLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (state is SurahLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.surah.length,
              itemBuilder: (context, index) {
                final surah = state.surah[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SurahCard(
                    surah: surah,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AyahScreen(surahNumber: surah.number),
                        ),
                      );
                    },
                  ),
                );
              },
            );

          }

          // Boshlang'ich holat yoki xatolik
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Surahlarni yuklashda xatolik'),
                ElevatedButton(
                  onPressed: () {
                    context.read<SurahBloc>().add(LoadSurah());
                  },
                  child: const Text('Qayta urinish'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}