// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'News App';

  @override
  String get home => 'Home';

  @override
  String get greetingLine1 => 'Good Morning';

  @override
  String get greetingLine2 => 'Here is Some News For You';

  @override
  String get viewAll => 'View All';

  @override
  String get goToHome => 'Go To Home';

  @override
  String get theme => 'Theme';

  @override
  String get language => 'Language';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeLight => 'Light';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get retry => 'Retry';

  @override
  String get categoryGeneral => 'General';

  @override
  String get categoryBusiness => 'Business';

  @override
  String get categorySports => 'Sports';

  @override
  String get categoryTechnology => 'Technology';

  @override
  String get categoryEntertainment => 'Entertainment';

  @override
  String get categoryHealth => 'Health';

  @override
  String get categoryScience => 'Science';

  @override
  String get viewFullArticle => 'View Full Article';

  @override
  String get noArticles => 'No articles found';

  @override
  String get justNow => 'Just now';

  @override
  String byAuthor(String author) {
    return 'By : $author';
  }

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes ago',
      one: '1 minute ago',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours ago',
      one: '1 hour ago',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ago',
      one: '1 day ago',
    );
    return '$_temp0';
  }

  @override
  String get search => 'Search';

  @override
  String get searchPrompt => 'Search for news';
}
