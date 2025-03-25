import 'package:flutter/material.dart';
import 'package:quran_app/src/core/data/models/quran/surah_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../customs/text/adaptive_text.dart';

class SurahCard extends StatelessWidget {
  final SurahModel surah;
  final VoidCallback? onTap;

  const SurahCard({
    super.key,
    required this.surah,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AdaptiveText(
                      surah.name,
                      multiplier: 1.1,
                      fontWeight: FontWeight.bold,
                      customColor: theme.colorScheme.onSurface,
                    ),
                  ),
                  AdaptiveText(
                    surah.arabicName,
                    multiplier: 1.0,
                    fontWeight: FontWeight.w600,
                    customColor: theme.colorScheme.secondary,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: AdaptiveText('${l10n.sura} ${surah.number}'),
                    backgroundColor: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
                  ),
                  AdaptiveText(
                    '${surah.ayahCount} ${l10n.ayah}',
                    customColor: theme.colorScheme.secondary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}