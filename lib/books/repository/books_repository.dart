import 'dart:async';
import 'package:gutenberg/books/models/book.dart';
import 'package:gutenberg/common/common.dart';
import 'package:get_it/get_it.dart';
import "package:logger/logger.dart";

class BooksRepository {
  final log = Logger();
  GetIt getIt = GetIt.instance;
  final PreferencesRepository prefRepo;
  final ApiRepository apiRepo;

  BooksRepository({required this.prefRepo, required this.apiRepo});

  Future<List<Book>> getBooks({required String categoryName, required int page, required String search}) async {
    try {
      String? url = "${Constants.API_MAP["books"]}?mime_type=image&topic=$categoryName&page=$page&search=$search";
      final response = await apiRepo.getRequest(url: url);
      final results = response["results"] as List;
      return results.isNotEmpty ? results.map((book) => Book.fromJson(book as Map<String, dynamic>)).toList() : [];
    } catch (error) {
      log.e("BooksRepository:::getBooks::Error: $error");
      throw Exception('$error');
    }
  }
}
