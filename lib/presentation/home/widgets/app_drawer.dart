import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_palette.dart';
import '../../../l10n/app_localizations.dart';
import '../../../logic/settings/settings_cubit.dart';
import '../../../logic/settings/settings_state.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final p = context.palette;

    return Drawer(
      width: MediaQuery.sizeOf(context).width * 0.62,
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final cubit = context.read<SettingsCubit>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 150,
                alignment: Alignment.center,
                color: p.drawerHeaderBackground,
                child: Text(
                  l10n.appTitle,
                  style: TextStyle(
                    color: p.drawerHeaderText,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _DrawerLabel(
                      icon: Icons.home_outlined,
                      text: l10n.goToHome,
                      onTap: () =>
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst),
                    ),
                    const Divider(height: 28),
                    _DrawerLabel(
                      icon: Icons.format_paint_outlined,
                      text: l10n.theme,
                    ),
                    const SizedBox(height: 10),
                    _BorderedDropdown<ThemeMode>(
                      value: state.themeMode,
                      items: {
                        ThemeMode.dark: l10n.themeDark,
                        ThemeMode.light: l10n.themeLight,
                      },
                      onChanged: cubit.changeTheme,
                    ),
                    const Divider(height: 28),
                    _DrawerLabel(
                      icon: Icons.language_outlined,
                      text: l10n.language,
                    ),
                    const SizedBox(height: 10),
                    _BorderedDropdown<String>(
                      value: state.locale.languageCode,
                      items: {
                        'en': l10n.languageEnglish,
                        'ar': l10n.languageArabic,
                      },
                      onChanged: (code) => cubit.changeLocale(Locale(code)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DrawerLabel extends StatelessWidget {
  const _DrawerLabel({required this.icon, required this.text, this.onTap});
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

class _BorderedDropdown<T> extends StatelessWidget {
  const _BorderedDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final T value;
  final Map<T, String> items;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: p.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          items: items.entries
              .map(
                (e) => DropdownMenuItem<T>(value: e.key, child: Text(e.value)),
              )
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}
