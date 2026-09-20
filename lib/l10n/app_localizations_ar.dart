// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق الأخبار';

  @override
  String get home => 'الرئيسية';

  @override
  String get greetingLine1 => 'صباح الخير';

  @override
  String get greetingLine2 => 'إليك بعض الأخبار من أجلك';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get goToHome => 'الذهاب للرئيسية';

  @override
  String get theme => 'المظهر';

  @override
  String get language => 'اللغة';

  @override
  String get themeDark => 'داكن';

  @override
  String get themeLight => 'فاتح';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get somethingWentWrong => 'حدث خطأ ما';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get categoryGeneral => 'عام';

  @override
  String get categoryBusiness => 'أعمال';

  @override
  String get categorySports => 'رياضة';

  @override
  String get categoryTechnology => 'تكنولوجيا';

  @override
  String get categoryEntertainment => 'ترفيه';

  @override
  String get categoryHealth => 'صحة';

  @override
  String get categoryScience => 'علوم';

  @override
  String get viewFullArticle => 'عرض المقال كاملًا';

  @override
  String get noArticles => 'لا توجد أخبار';

  @override
  String get justNow => 'الآن';

  @override
  String byAuthor(String author) {
    return 'بواسطة : $author';
  }

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'منذ $count دقيقة',
      many: 'منذ $count دقيقة',
      few: 'منذ $count دقائق',
      two: 'منذ دقيقتين',
      one: 'منذ دقيقة',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'منذ $count ساعة',
      many: 'منذ $count ساعة',
      few: 'منذ $count ساعات',
      two: 'منذ ساعتين',
      one: 'منذ ساعة',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'منذ $count يوم',
      many: 'منذ $count يومًا',
      few: 'منذ $count أيام',
      two: 'منذ يومين',
      one: 'منذ يوم',
    );
    return '$_temp0';
  }

  @override
  String get search => 'بحث';

  @override
  String get searchPrompt => 'ابحث عن الأخبار';
}
