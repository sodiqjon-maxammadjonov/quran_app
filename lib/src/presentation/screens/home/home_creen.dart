import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/src/core/data/models/category/category_model.dart';
import '../../utils/widgets/cards/category_card.dart';
import '../../utils/widgets/cards/daily_verse.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final categories = [
      CategoryModel(title: 'Suralar', icon: Icons.format_list_numbered, description: 'Barcha suralar ro\'yxati'),
      CategoryModel(title: 'Juzlar', icon: Icons.book, description: '30 ta juz'),
      CategoryModel(title: 'Sajda Oyatlari', icon: Icons.animation, description: 'Sajda qilinadigan oyatlar'),
      CategoryModel(title: 'Bookmark', icon: Icons.bookmark, description: 'Saqlangan belgilar'),
      CategoryModel(title: 'Qiroat', icon: Icons.record_voice_over, description: 'Audio qiroatlar'),
      CategoryModel(title: 'Tafsir', icon: Icons.library_books, description: 'Oyatlar tafsiri'),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            child: Text(
              'Bo\'limlar',
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          // **Kategoriya tarmog‘i (GridView)**
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
                    title: categories[index].title,
                    icon: categories[index].icon,
                    description: categories[index].description,
                  );
                },
              );
            },
          ),

          // **Bugungi Oyat**
          SizedBox(height: screenHeight * 0.03),
          const DailyVerseWidget(),
        ],
      ),
    );
  }
}
