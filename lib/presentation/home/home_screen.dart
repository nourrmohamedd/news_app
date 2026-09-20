import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_localizations.dart';
import '../../logic/categories/categories_cubit.dart';
import '../../logic/categories/categories_state.dart';
import 'widgets/app_drawer.dart';
import 'widgets/category_card.dart';
import '../category_news/category_news_screen.dart';
import '../../core/theme/app_palette.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.home,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const SearchScreen())),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) => switch (state) {
          CategoriesLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          CategoriesFailure() => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.somethingWentWrong),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => context.read<CategoriesCubit>().load(),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
          CategoriesLoaded(:final categories) => ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: categories.length + 1,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              if (i == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '${l10n.greetingLine1}\n${l10n.greetingLine2}',
                    style: Theme.of(context).textTheme.titleLarge
                        ?.copyWith(color: context.palette.border),
                  ),
                );
              }
              final category = categories[i - 1];
              return CategoryCard(
                category: category,
                index: i - 1,
                onViewAll: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CategoryNewsScreen(category: category),
                    ),
                  );
                },
              );
            },
          ),
        },
      ),
    );
  }
}
