// ignore_for_file: constant_identifier_names

import 'theme_config.dart';

class Constants {
  static const APP_NAME = "Gutenberg";
  static const API_BASE_URL = "http://skunkworks.ignitesol.com:8000/";

  // Constants file
  static const themeConfig = ThemeConfig();

  // Shared Preferences Keys
  static const PREF_KEY_AUTH_TOKEN = "auth_token";
  static const PREF_KEY_USER = "user";
  static const PREF_KEY_USER_LANGUAGE = "user_language";
  static const PREF_KEY_THEME_MODE = "theme_mode";
  // Style
  static const FONT_MONTESERRAT = "Montserrat";

  // Loader Type
  static const LOADER_LINER = "linear";
  static const LOADER_CIRCULAR = "circular";

  // Message Type
  static const MESSAGE_ERROR = "error";
  static const MESSAGE_NO_DATA = "no_data";

  static const LANGUAGES = {'English': 'en', 'Tamil': 'ta'};

  //************** APIS ****************
  static const API_MAP = {"books": "books"};
}
