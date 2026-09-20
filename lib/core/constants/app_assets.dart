abstract final class AppAssets {
  static const String _base = 'assets';

  static String category(String imageKey, {required bool isDark}) =>
      '$_base/${imageKey}_${isDark ? 'dark' : 'light'}.png';
}
