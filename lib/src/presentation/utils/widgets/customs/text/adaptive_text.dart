import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/src/core/data/bloc/settings/settings_bloc.dart';

class AdaptiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final double? multiplier;
  final Color? customColor;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;

  const AdaptiveText(
      this.text, {
        super.key,
        this.style,
        this.textAlign,
        this.multiplier = 1.0,
        this.customColor,
        this.fontWeight,
        this.maxLines,
        this.overflow,
      });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final double baseFontSize = state.fontSize;
        final adjustedFontSize = baseFontSize * (multiplier ?? 1.0);

        return Text(
          text,
          style: style?.copyWith(
            fontSize: adjustedFontSize,
            color: customColor ?? theme.textTheme.bodyMedium?.color,
            fontWeight: fontWeight ?? theme.textTheme.bodyMedium?.fontWeight,
          ) ?? TextStyle(
            fontSize: adjustedFontSize,
            color: customColor ?? theme.textTheme.bodyMedium?.color,
            fontWeight: fontWeight ?? theme.textTheme.bodyMedium?.fontWeight,
          ),
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );
      },
    );
  }

  // Tema stillaridan foydalanuvchi factory constructorlar
  factory AdaptiveText.headline1(
      String text, {
        Color? color,
        double multiplier = 1.0,
      }) => AdaptiveText(
    text,
    multiplier: multiplier * 1.5,
    fontWeight: FontWeight.bold,
    customColor: color,
  );

  factory AdaptiveText.subtitle(
      String text, {
        Color? color,
        double multiplier = 1.0,
      }) => AdaptiveText(
    text,
    multiplier: multiplier * 1.2,
    fontWeight: FontWeight.w600,
    customColor: color,
  );

  factory AdaptiveText.caption(
      String text, {
        Color? color,
        double multiplier = 1.0,
      }) => AdaptiveText(
    text,
    multiplier: multiplier * 0.8,
    fontWeight: FontWeight.w400,
    customColor: color,
  );
}