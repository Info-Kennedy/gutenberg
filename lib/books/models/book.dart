import 'author.dart';
import 'formats.dart';

class Book {
  final int id;
  final String title;
  final List<Author> authors;
  final List<Author> translators;
  final List<String> subjects;
  final List<String> bookshelves;
  final List<String> languages;
  final bool copyright;
  final String mediaType;
  final Formats formats;
  final int downloadCount;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.translators,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    required this.mediaType,
    required this.formats,
    required this.downloadCount,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int,
      title: json['title'] as String,
      authors: (json['authors'] as List<dynamic>).map((author) => Author.fromJson(author as Map<String, dynamic>)).toList(),
      translators: (json['translators'] as List<dynamic>).map((translator) => Author.fromJson(translator as Map<String, dynamic>)).toList(),
      subjects: (json['subjects'] as List<dynamic>).cast<String>(),
      bookshelves: (json['bookshelves'] as List<dynamic>).cast<String>(),
      languages: (json['languages'] as List<dynamic>).cast<String>(),
      copyright: json['copyright'] as bool,
      mediaType: json['media_type'] as String,
      formats: Formats.fromJson(json['formats'] as Map<String, dynamic>),
      downloadCount: json['download_count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': authors.map((author) => author.toJson()).toList(),
      'translators': translators.map((translator) => translator.toJson()).toList(),
      'subjects': subjects,
      'bookshelves': bookshelves,
      'languages': languages,
      'copyright': copyright,
      'media_type': mediaType,
      'formats': formats.toJson(),
      'download_count': downloadCount,
    };
  }
}
