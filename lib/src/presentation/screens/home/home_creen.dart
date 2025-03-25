import 'package:flutter/material.dart';
import 'package:quran_app/src/presentation/screens/home/suralar/suralar_screen.dart';
import '../../../core/data/models/category_model.dart';
import '../../utils/widgets/cards/category_card.dart';
import '../../utils/widgets/cards/daily_verse.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final categories = [
      CategoryModel(title: l10n.suralar, icon: Icons.format_list_numbered, description: l10n.barchaSuralarRoyxati),
      CategoryModel(title: l10n.juzlar, icon: Icons.book, description: l10n.juz30),
      CategoryModel(title: l10n.sajdaOyatlari, icon: Icons.animation, description: l10n.sajdaQilinadiganOyatlar),
      CategoryModel(title: l10n.bookmark, icon: Icons.bookmark, description: l10n.saqlanganBelgilar),
      CategoryModel(title: l10n.qiroat, icon: Icons.record_voice_over, description: l10n.qiroat),
      CategoryModel(title: l10n.tafsir, icon: Icons.library_books, description: l10n.oyatlarTafsiri),
    ];

    final screens = [
      const SurahScreen(),
      SizedBox(),
      SizedBox(),
      SizedBox(),
      SizedBox(),
      SizedBox(),
      // const JuzScreen(),
      // const SajdaScreen(),
      // const BookmarkScreen(),
      // const QiroatScreen(),
      // const TafsirScreen(),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            child: Text(
              l10n.boLimlar,
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: screenWidth * 0.04,
                  mainAxisSpacing: screenWidth * 0.04,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => screens[index]),
                      );
                    },
                    title: categories[index].title,
                    icon: categories[index].icon,
                    description: categories[index].description,
                  );
                },
              );
            },
          ),
          SizedBox(height: screenHeight * 0.03),
          const DailyVerseWidget(),
        ],
      ),
    );
  }
}
