part of 'books_bloc.dart';

sealed class BooksEvent extends Equatable {
  const BooksEvent();

  @override
  List<Object> get props => [];
}

final class InitializeBooks extends BooksEvent {
  final String categoryName;
  const InitializeBooks({required this.categoryName});

  @override
  List<Object> get props => [categoryName];
}

final class SearchBooks extends BooksEvent {
  final String search;
  const SearchBooks({required this.search});

  @override
  List<Object> get props => [search];
}

final class LoadMoreBooks extends BooksEvent {
  const LoadMoreBooks();

  @override
  List<Object> get props => [];
}
