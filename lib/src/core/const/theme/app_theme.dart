import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme
  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: const Color(0xFF1E8449), // Quron uchun to'q yashil
        onPrimary: Colors.white,
        primaryContainer: const Color(0xFFD5F5E3), // Och yashil container
        onPrimaryContainer: const Color(0xFF0E6655),
        secondary: const Color(0xFF5D6D7E), // Ko'kimtir-kulrang
        onSecondary: Colors.white,
        secondaryContainer: const Color(0xFFEBF5FB), // Och ko'k container
        onSecondaryContainer: const Color(0xFF21618C),
        tertiary: const Color(0xFF7D3C98), // Binafsha rang
        surface: Colors.white,
        background: const Color(0xFFF5F5F5),
        error: const Color(0xFFB71C1C),
      ),
      scaffoldBackgroundColor: const Color(0xFFF8F9F9),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, // Rangsiz (shaffof)
        foregroundColor: Color(0xFF1E8449), // Faqat text rangi yashil
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF1E8449),
        unselectedItemColor: Color(0xFF7F8C8D),
        elevation: 8,
      ),
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Color(0xFF17202A)),
        displayMedium: TextStyle(color: Color(0xFF17202A)),
        displaySmall: TextStyle(color: Color(0xFF17202A)),
        headlineMedium: TextStyle(color: Color(0xFF17202A)),
        titleLarge: TextStyle(color: Color(0xFF17202A), fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: Color(0xFF17202A)),
        bodyMedium: TextStyle(color: Color(0xFF17202A)),
      ),
    );
  }

  // Dark Theme
  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFF2ECC71), // Yorqin yashil
        onPrimary: Colors.black,
        primaryContainer: const Color(0xFF145A32), // To'q yashil container
        onPrimaryContainer: const Color(0xFFABEBC6),
        secondary: const Color(0xFF85C1E9), // Och ko'k
        onSecondary: Colors.black,
        secondaryContainer: const Color(0xFF1A5276), // To'q ko'k container
        onSecondaryContainer: const Color(0xFFD4E6F1),
        tertiary: const Color(0xFFBB8FCE), // Och binafsha
        surface: const Color(0xFF1C2833),
        background: const Color(0xFF17202A),
        error: const Color(0xFFE74C3C),
      ),
      scaffoldBackgroundColor: const Color(0xFF17202A),
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: const Color(0xFF1C2833),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, // Rangsiz (shaffof)
        foregroundColor: Color(0xFF2ECC71), // Faqat text rangi yashil
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1C2833),
        selectedItemColor: Color(0xFF2ECC71),
        unselectedItemColor: Color(0xFF7F8C8D),
        elevation: 8,
      ),
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Color(0xFFECF0F1)),
        displayMedium: TextStyle(color: Color(0xFFECF0F1)),
        displaySmall: TextStyle(color: Color(0xFFECF0F1)),
        headlineMedium: TextStyle(color: Color(0xFFECF0F1)),
        titleLarge: TextStyle(color: Color(0xFFECF0F1), fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: Color(0xFFECF0F1)),
        bodyMedium: TextStyle(color: Color(0xFFECF0F1)),
      ),
    );
  }
}