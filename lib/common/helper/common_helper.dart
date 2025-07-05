// import 'package:chatapp/chat/models/message.dart';
import 'package:gutenberg/common/common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class CommonHelper {
  final log = Logger();
  String? _cachedLanguage;

  CommonHelper();

  String getAudioPath(String audioName) {
    return "assets/audio/$audioName";
  }

  String getIconPath(String iconName) {
    return "assets/icons/$iconName";
  }

  String getImagePath(String imageName) {
    return "assets/images/$imageName";
  }

  String getStringLabel(String label) {
    // Use cached language or default to "en"
    String userLanguage = _cachedLanguage ?? "en";
    return AppStrings.string[userLanguage]?[label] ?? "-";
  }

  Future<void> initializeLanguage() async {
    try {
      PreferencesRepository pref = getIt<PreferencesRepository>();
      _cachedLanguage = await pref.getPreference(Constants.PREF_KEY_USER_LANGUAGE) ?? "en";
    } catch (error) {
      log.e("CommonHelper: Error initializing language: $error");
      _cachedLanguage = "en";
    }
  }

  Future<String> getStringLabelAsync(String label) async {
    PreferencesRepository pref = getIt<PreferencesRepository>();
    String userLanguage = await pref.getPreference(Constants.PREF_KEY_USER_LANGUAGE) ?? "en";
    return AppStrings.string[userLanguage]?[label] ?? "-";
  }

  String convertDateToAppDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd.MM.yy | hh:mm a').format(parsedDate);
  }

  String convertDateTimeToTime(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('hh:mm a').format(parsedDate);
  }

  Future<void> alertDialog(
    BuildContext context,
    String? title,
    String message,
    String? negativeText,
    Function? negative,
    String postiveText,
    Function postive,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          title: Text(
            title ?? Constants.APP_NAME,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          content: Text(message, style: Theme.of(context).textTheme.bodyMedium),
          actions: [
            negativeText?.isNotEmpty == true ? OutlinedButton(onPressed: () => negative!(), child: Text(negativeText!)) : const SizedBox.shrink(),
            postiveText.isNotEmpty ? FilledButton(onPressed: () => postive(), child: Text(postiveText)) : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
