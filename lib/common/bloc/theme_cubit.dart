import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutenberg/common/common.dart';

class ThemeCubit extends Cubit<String> {
  final PreferencesRepository _preferencesRepository;
  bool _isInitialized = false;

  ThemeCubit(this._preferencesRepository) : super(ThemeConfig.LIGHT);

  bool get isInitialized => _isInitialized;

  /// Initialize theme based on stored preference or system theme
  Future<void> initializeTheme() async {
    try {
      // Get stored theme preference
      String? storedTheme = await _preferencesRepository.getPreference(Constants.PREF_KEY_THEME_MODE);

      if (storedTheme != null && storedTheme.isNotEmpty) {
        // User has set a preference, use it
        emit(storedTheme);
      } else {
        // If no stored preference, start with system theme
        // But we'll need to determine if system is dark or light
        // For now, we'll start with system and let the UI determine the effective theme
        emit(ThemeConfig.SYSTEM);
      }

      _isInitialized = true;
    } catch (error) {
      // Fallback to light theme if there's an error
      emit(ThemeConfig.LIGHT);
      _isInitialized = true;
    }
  }

  /// Update theme mode and save to preferences
  Future<void> updateThemeMode(String themeMode) async {
    if (state != themeMode) {
      await _preferencesRepository.savePreference(Constants.PREF_KEY_THEME_MODE, themeMode);
      emit(themeMode);
    }
  }

  /// Get the effective theme mode considering system preference
  String getEffectiveThemeMode(bool isSystemDark) {
    if (state == ThemeConfig.SYSTEM) {
      return isSystemDark ? ThemeConfig.DARK : ThemeConfig.LIGHT;
    }
    return state;
  }

  /// Check if current theme is dark
  bool isDarkMode(bool isSystemDark) {
    final effectiveThemeMode = getEffectiveThemeMode(isSystemDark);
    return effectiveThemeMode == ThemeConfig.DARK;
  }

  /// Toggle between light and dark themes
  /// If currently on system theme, switch to the opposite of current system theme
  Future<void> toggleTheme() async {
    String newTheme;

    if (state == ThemeConfig.SYSTEM) {
      // If on system theme, switch to the opposite of current system appearance
      // We'll need to determine this from the UI context
      newTheme = ThemeConfig.LIGHT; // Default fallback
    } else if (state == ThemeConfig.LIGHT) {
      newTheme = ThemeConfig.DARK;
    } else {
      newTheme = ThemeConfig.LIGHT;
    }

    await updateThemeMode(newTheme);
  }

  /// Set theme to system preference
  Future<void> setSystemTheme() async {
    await updateThemeMode(ThemeConfig.SYSTEM);
  }

  /// Set theme to light mode
  Future<void> setLightTheme() async {
    await updateThemeMode(ThemeConfig.LIGHT);
  }

  /// Set theme to dark mode
  Future<void> setDarkTheme() async {
    await updateThemeMode(ThemeConfig.DARK);
  }
}
