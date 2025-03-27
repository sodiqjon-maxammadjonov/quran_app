import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/src/core/data/bloc/ayah/audio_bloc.dart';
import 'package:quran_app/src/core/data/models/quran/ayah_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../customs/text/adaptive_text.dart';
import 'package:quran_app/src/core/data/bloc/ayah/ayah_bloc.dart';

class AyahCard extends StatefulWidget {
  final AyahModel ayah;
  final VoidCallback? onTap;
  final bool showTranslation;

  const AyahCard({
    super.key,
    required this.ayah,
    this.onTap,
    this.showTranslation = true,
  });

  @override
  _AyahCardState createState() => _AyahCardState();
}

class _AyahCardState extends State<AyahCard> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  final String audioUrl = '';

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _toggleAudio() async {

    try {
      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
        setState(() => _isPlaying = false);
      } else {
        setState(() => _isPlaying = true);
        await _audioPlayer.setUrl(widget.ayah.audioUrl!);
        await _audioPlayer.play();

        _audioPlayer.playerStateStream.listen((state) {
          if (state.processingState == ProcessingState.completed) {
            setState(() => _isPlaying = false);
          }
        });
      }
    } catch (e) {
      print('Audio o\'ynatishda xatolik: $e');
      setState(() => _isPlaying = false);
    }
  }

  void _copyAyahText() {
    Clipboard.setData(ClipboardData(text: widget.ayah.arabicText));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Oyat nusxa olindi'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: _copyAyahText,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: AdaptiveText('${l10n.ayah} ${widget.ayah.number}'),
                    backgroundColor: theme.colorScheme.primaryContainer.withOpacity(0.5),
                  ),
                  Row(
                    children: [
                      BlocBuilder<AudioBloc, AudioState>(
                        builder: (context, state) {
                          if(widget.ayah.audioUrl == null || widget.ayah.audioUrl!.isEmpty) {
                            return IconButton(
                              icon: Icon(
                                Icons.file_download_rounded,
                                color: theme.colorScheme.primary,
                                size: 20,
                              ),
                              onPressed: () {
                                context.read<AudioBloc>().add(FetchAyahAudio(widget.ayah.number));
                                print('audio url: $audioUrl');
                              },
                            );
                          }
                          return SizedBox.shrink();
                          },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.copy,
                          size: 16,
                          color: theme.colorScheme.secondary,
                        ),
                        onPressed: _copyAyahText,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: AdaptiveText.headline1(
                  widget.ayah.arabicText,
                  multiplier: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              if (widget.showTranslation)
                AdaptiveText(
                  widget.ayah.translatedText,
                  multiplier: 1.1,
                  fontWeight: FontWeight.w500,
                  customColor: theme.colorScheme.onSurface,
                ),
            ],
          ),
        ),
      ),
    );
  }
}