import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/settings_repository.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._repository)
    : super(
        SettingsState(
          themeMode: _repository.readThemeMode(),
          locale: _repository.readLocale(),
        ),
      );

  final SettingsRepository _repository;

  Future<void> changeTheme(ThemeMode mode) async {
    emit(state.copyWith(themeMode: mode));
    await _repository.saveThemeMode(mode);
  }

  Future<void> changeLocale(Locale locale) async {
    emit(state.copyWith(locale: locale));
    await _repository.saveLocale(locale);
  }
}
