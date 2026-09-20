import 'package:flutter/widgets.dart';

import '../../../l10n/app_localizations.dart';

String categoryName(BuildContext context, String id) {
  final l10n = AppLocalizations.of(context);
  return switch (id) {
    'general' => l10n.categoryGeneral,
    'business' => l10n.categoryBusiness,
    'sports' => l10n.categorySports,
    'technology' => l10n.categoryTechnology,
    'entertainment' => l10n.categoryEntertainment,
    'health' => l10n.categoryHealth,
    'science' => l10n.categoryScience,
    _ => id,
  };
}
