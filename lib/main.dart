import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/src/core/const/theme/app_theme.dart';
import 'package:quran_app/src/core/data/bloc/ayah/ayah_bloc.dart';
import 'package:quran_app/src/core/data/bloc/settings/settings_bloc.dart';
import 'package:quran_app/src/core/data/bloc/surah/surah_bloc.dart';
import 'package:quran_app/src/presentation/screens/main/main_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingsBloc()..add(InitializeSettingsEvent()),
        ),
        BlocProvider(
          create: (context) => SurahBloc(),
        ),
        BlocProvider(
          create: (context) => AyahBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Quran App',
          theme: AppTheme().lightTheme,
          darkTheme: AppTheme().darkTheme,
          themeMode: state.themeMode,
          home: const MainScreen(),
          locale: Locale(state.language),
          supportedLocales: const [
            Locale('uz'),
            Locale('en'),
            Locale('ru'),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
