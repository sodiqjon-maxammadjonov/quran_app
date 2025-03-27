import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/src/core/data/bloc/ayah/ayah_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/widgets/cards/ayah_card.dart';

class AyahScreen extends StatefulWidget {
  final int surahNumber;

  const AyahScreen({super.key, required this.surahNumber});

  @override
  State<AyahScreen> createState() => _AyahScreenState();
}

class _AyahScreenState extends State<AyahScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AyahBloc>().add(FetchAyahs(widget.surahNumber));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${l10n.suralar} ${widget.surahNumber}'),
        centerTitle: true,
      ),
      body: BlocConsumer<AyahBloc, AyahState>(
        listener: (context, state) {
          if (state is AyahError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AyahLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (state is AyahLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.ayahs.length,
              itemBuilder: (context, index) {
                final ayah = state.ayahs[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AyahCard(
                    ayah: ayah,
                    onTap: () {
                      // Ayah tafsilotlariga o'tish logikasi
                      // Navigator.push(...);
                    },
                  ),
                );
              },
            );
          } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Oyatlarni yuklashda xatolik'),
                ElevatedButton(
                  onPressed: () {
                    context.read<AyahBloc>().add(FetchAyahs(widget.surahNumber));
                  },
                  child: const Text('Qayta urinish'),
                ),
              ],
            ),
          );}
        },
      ),
    );
  }
}
