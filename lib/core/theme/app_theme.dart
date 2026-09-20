import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_palette.dart';

abstract final class AppTheme {
  static final ThemeData dark = _build(
    brightness: Brightness.dark,
    palette: AppPalette.dark,
    background: AppColors.darkScaffold,
    onBackground: AppColors.white,
  );

  static final ThemeData light = _build(
    brightness: Brightness.light,
    palette: AppPalette.light,
    background: AppColors.white,
    onBackground: AppColors.black,
  );

  static ThemeData _build({
    required Brightness brightness,
    required AppPalette palette,
    required Color background,
    required Color onBackground,
  }) {
    final base = ThemeData(brightness: brightness, useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: onBackground,
        onPrimary: background,
        secondary: onBackground,
        onSecondary: background,
        error: Colors.red,
        onError: AppColors.white,
        surface: background,
        onSurface: onBackground,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: onBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(),
      ),
      dividerTheme: DividerThemeData(color: palette.border, thickness: 1),
      textTheme: base.textTheme.apply(
        bodyColor: onBackground,
        displayColor: onBackground,
      ),
      extensions: [palette],
    );
  }
}
