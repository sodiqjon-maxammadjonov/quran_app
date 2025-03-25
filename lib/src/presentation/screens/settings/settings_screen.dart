import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data/bloc/settings/settings_bloc.dart';
import '../../utils/widgets/settings/settings_group.dart';
import '../../utils/widgets/settings/settings_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final fontSize = state.fontSize;
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal:screenWidth * 0.04),
          child: ListView(
            children: [
              SettingsGroup(
                title: l10n.umumiySozlamalar,
                children: [
                  SettingsItem(
                    icon: Icons.color_lens,
                    title: l10n.mavzu,
                    subtitle: l10n.ilovaNingMavzusiniOzgartirish,
                    trailing: DropdownButton<ThemeMode>(
                      value: state.themeMode,
                      underline: const SizedBox(),
                      onChanged: (ThemeMode? newMode) {
                        if (newMode != null) {
                          context.read<SettingsBloc>().add(ChangeThemeEvent(newMode));
                        }
                      },
                      items:  [
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text(l10n.yorug,style: TextStyle(fontSize: fontSize)),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text(l10n.qorongu,style: TextStyle(fontSize: fontSize)),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text(l10n.sistema,style: TextStyle(fontSize: fontSize)),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  SettingsItem(
                    icon: Icons.translate,
                    title: l10n.til,
                    subtitle: l10n.ilovaTilinTanlash,
                    trailing: DropdownButton<String>(
                      value: state.language,
                      underline: const SizedBox(),
                      onChanged: (String? newLang) {
                        if (newLang != null) {
                          context.read<SettingsBloc>().add(ChangeLanguageEvent(newLang));
                        }
                      },
                      items:  [
                        DropdownMenuItem(
                          value: 'uz',
                          child: Text(l10n.ozbekcha,style: TextStyle(fontSize: fontSize)),
                        ),
                        DropdownMenuItem(
                          value: 'ru',
                          child: Text(l10n.russian,style: TextStyle(fontSize: fontSize)),
                        ),
                        DropdownMenuItem(
                          value: 'en',
                          child: Text(l10n.english,style: TextStyle(fontSize: fontSize)),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  SettingsItem(
                    icon: Icons.text_fields,
                    title: l10n.shriftOlchami,
                    subtitle: l10n.matnOlchaminiSozlash,
                    trailing: SizedBox(
                      width: screenWidth * 0.4,
                      child: Slider(
                        value: state.fontSize.clamp(12, 22),
                        min: 12,
                        max: 22,
                        divisions: 10,
                        onChanged: (double value) {
                          context.read<SettingsBloc>().add(ChangeFontSizeEvent(value));
                        },
                      ),
                    ),

                    onTap: () {},
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.03),

              // Qo'shimcha sozlamalar
              SettingsGroup(
                title: l10n.qoshimchaSozlamalar,
                children: [
                  SettingsItem(
                    icon: Icons.notifications,
                    title: l10n.bildirishnomalar,
                    subtitle: l10n.eslatmalarniSozlash,
                    trailing: Switch(
                      value: state.notificationsEnabled,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(ToggleNotificationsEvent(value));
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () {},
                  ),
                  SettingsItem(
                    icon: Icons.cloud_download,
                    title: l10n.oflaynRejim,
                    subtitle: l10n.suraniYuklabOlish,
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.03),

              // Ma'lumot
              SettingsGroup(
                title: l10n.malumot,
                children: [
                  SettingsItem(
                    icon: Icons.info_outline,
                    title: l10n.ilovaHaqida,
                    subtitle: l10n.malumotVaYordam,
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                  SettingsItem(
                    icon: Icons.share,
                    title: l10n.ilovanniUlashish,
                    subtitle: l10n.dostlaringizBilanUlashing,
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                  SettingsItem(
                    icon: Icons.star,
                    title: l10n.baholar,
                    subtitle: l10n.ilovanniBaholang,
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                ],
              ),

              const Spacer(),

              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                  child: Text(
                    'Versiya 1.0.0',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}