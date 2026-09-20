import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/repositories/category_repository.dart';
import 'data/repositories/settings_repository.dart';
import 'logic/categories/categories_cubit.dart';
import 'logic/settings/settings_cubit.dart';
import 'data/repositories/news_repository.dart';
import 'data/services/news_api_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => SettingsRepository(prefs)),
        RepositoryProvider(create: (_) => CategoryRepository()),
        RepositoryProvider(create: (_) => NewsRepository(NewsApiService())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (c) => SettingsCubit(c.read<SettingsRepository>()),
          ),
          BlocProvider(
            create: (c) =>
                CategoriesCubit(c.read<CategoryRepository>())..load(),
          ),
        ],
        child: const NewsApp(),
      ),
    ),
  );
}
