import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class DailyVerseWidget extends StatelessWidget {
  const DailyVerseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.bugungiOyat,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            'Albatta, namozni barpo qiling. Chunki namoz mo\'minlarga vaqti belgilangan farz bo\'ldi.',
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            'An-Niso surasi, 103-oyat',
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.onSecondaryContainer.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
