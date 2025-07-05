import 'dart:async';
import 'package:gutenberg/common/common.dart';
import 'package:get_it/get_it.dart';
import "package:logger/logger.dart";

class CategoriesRepository {
  final log = Logger();
  GetIt getIt = GetIt.instance;
  final PreferencesRepository prefRepo;
  final ApiRepository apiRepo;

  CategoriesRepository({required this.prefRepo, required this.apiRepo});

  Future<List<Map<String, dynamic>>> getCategories() async {
    try {
      List<Map<String, dynamic>> response = [
        {"id": "1", "image": "ic_fiction.svg", "name": "Fiction"},
        {"id": "2", "image": "ic_drama.svg", "name": "Drama"},
        {"id": "3", "image": "ic_humour.svg", "name": "Humour"},
        {"id": "4", "image": "ic_politics.svg", "name": "Politics"},
        {"id": "5", "image": "ic_philosophy.svg", "name": "Philosophy"},
        {"id": "6", "image": "ic_history.svg", "name": "History"},
        {"id": "7", "image": "ic_adventure.svg", "name": "Adventure"},
      ];
      return response;
    } catch (error) {
      log.e("CategoriesRepository:::getCategories::Error: $error");
      throw Exception('$error');
    }
  }
}
