import 'package:flutter/material.dart';

import 'app_colors.dart';

@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.cardBackground,
    required this.cardText,
    required this.arrowBackground,
    required this.arrowIcon,
    required this.pillBackground,
    required this.pillText,
    required this.border,
    required this.drawerHeaderBackground,
    required this.drawerHeaderText,
  });

  final Color cardBackground;
  final Color cardText;
  final Color arrowBackground;
  final Color arrowIcon;
  final Color pillBackground;
  final Color pillText;
  final Color border;
  final Color drawerHeaderBackground;
  final Color drawerHeaderText;

  static const AppPalette dark = AppPalette(
    cardBackground: AppColors.white,
    cardText: AppColors.black,
    arrowBackground: AppColors.black,
    arrowIcon: AppColors.white,
    pillBackground: AppColors.black50,
    pillText: AppColors.white,
    border: AppColors.white,
    drawerHeaderBackground: AppColors.white,
    drawerHeaderText: AppColors.black,
  );

  static const AppPalette light = AppPalette(
    cardBackground: AppColors.darkScaffold,
    cardText: AppColors.white,
    arrowBackground: AppColors.white,
    arrowIcon: AppColors.black,
    pillBackground: AppColors.white50,
    pillText: AppColors.black,
    border: AppColors.black,
    drawerHeaderBackground: AppColors.darkScaffold,
    drawerHeaderText: AppColors.white,
  );

  @override
  AppPalette copyWith({
    Color? cardBackground,
    Color? cardText,
    Color? arrowBackground,
    Color? arrowIcon,
    Color? pillBackground,
    Color? pillText,
    Color? border,
    Color? drawerHeaderBackground,
    Color? drawerHeaderText,
  }) => AppPalette(
    cardBackground: cardBackground ?? this.cardBackground,
    cardText: cardText ?? this.cardText,
    arrowBackground: arrowBackground ?? this.arrowBackground,
    arrowIcon: arrowIcon ?? this.arrowIcon,
    pillBackground: pillBackground ?? this.pillBackground,
    pillText: pillText ?? this.pillText,
    border: border ?? this.border,
    drawerHeaderBackground:
        drawerHeaderBackground ?? this.drawerHeaderBackground,
    drawerHeaderText: drawerHeaderText ?? this.drawerHeaderText,
  );

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppPalette(
      cardBackground: l(cardBackground, other.cardBackground),
      cardText: l(cardText, other.cardText),
      arrowBackground: l(arrowBackground, other.arrowBackground),
      arrowIcon: l(arrowIcon, other.arrowIcon),
      pillBackground: l(pillBackground, other.pillBackground),
      pillText: l(pillText, other.pillText),
      border: l(border, other.border),
      drawerHeaderBackground: l(
        drawerHeaderBackground,
        other.drawerHeaderBackground,
      ),
      drawerHeaderText: l(drawerHeaderText, other.drawerHeaderText),
    );
  }
}

extension PaletteX on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}
