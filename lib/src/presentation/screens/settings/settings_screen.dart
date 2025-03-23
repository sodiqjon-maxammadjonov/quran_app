import 'package:flutter/material.dart';
import '../../utils/widgets/settings/settings_group.dart';
import '../../utils/widgets/settings/settings_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.02,
              bottom: screenHeight * 0.03,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  size: screenWidth * 0.08,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: screenWidth * 0.03),
                Text(
                  'Sozlamalar',
                  style: TextStyle(
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          // Mavzu tanlash
          SettingsGroup(
            title: 'Umumiy sozlamalar',
            children: [
              SettingsItem(
                icon: Icons.color_lens,
                title: 'Mavzu',
                subtitle: 'Ilovaning mavzusini o\'zgartirish',
                trailing: DropdownButton<ThemeMode>(
                  underline: const SizedBox(),
                  onChanged: (ThemeMode? newMode) {
                    if (newMode != null) {
                      setState(() {});
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('Yorug\''),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('Qorong\'u'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('Sistema'),
                    ),
                  ],
                ),
                onTap: () {},
              ),
              SettingsItem(
                icon: Icons.translate,
                title: 'Til',
                subtitle: 'Ilova tilini tanlash',
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              SettingsItem(
                icon: Icons.text_fields,
                title: 'Shrift o\'lchami',
                subtitle: 'Matn o\'lchamini sozlash',
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.02),

          // Qo'shimcha sozlamalar
          SettingsGroup(
            title: 'Qo\'shimcha sozlamalar',
            children: [
              SettingsItem(
                icon: Icons.notifications,
                title: 'Bildirishnomalar',
                subtitle: 'Eslatmalarni sozlash',
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
                onTap: () {},
              ),
              SettingsItem(
                icon: Icons.cloud_download,
                title: 'Oflayn rejim',
                subtitle: 'Surani yuklab olish',
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.02),

          // Ma'lumot
          SettingsGroup(
            title: 'Ma\'lumot',
            children: [
              SettingsItem(
                icon: Icons.info_outline,
                title: 'Ilova haqida',
                subtitle: 'Ma\'lumot va yordam',
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              SettingsItem(
                icon: Icons.share,
                title: 'Ilovani ulashish',
                subtitle: 'Do\'stlaringiz bilan ulashing',
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              SettingsItem(
                icon: Icons.star,
                title: 'Baholar',
                subtitle: 'Ilovani baholang',
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.05),

          // Ilova versiyasi
          Center(
            child: Text(
              'Versiya 1.0.0',
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
