part of 'books_bloc.dart';

enum BooksStatus { initial, loaded, loading, changing, changed, success, error }

class BooksState extends Equatable {
  final String message;
  final BooksStatus status;
  final String categoryName;
  final List<Book> books;
  final int page;
  final String search;
  final bool hasMore;
  final GlobalKey<FormBuilderState> formKey;

  const BooksState({
    required this.status,
    required this.message,
    required this.books,
    required this.categoryName,
    required this.page,
    required this.search,
    required this.hasMore,
    required this.formKey,
  });

  static BooksState initial = BooksState(
    message: "",
    status: BooksStatus.initial,
    books: [],
    categoryName: "",
    page: 1,
    search: "",
    hasMore: true,
    formKey: GlobalKey<FormBuilderState>(),
  );

  BooksState copyWith({
    BooksStatus Function()? status,
    String Function()? message,
    List<Book> Function()? books,
    String Function()? categoryName,
    int Function()? page,
    String Function()? search,
    bool Function()? hasMore,
    GlobalKey<FormBuilderState> Function()? formKey,
  }) {
    return BooksState(
      status: status != null ? status() : this.status,
      message: message != null ? message() : this.message,
      books: books != null ? books() : this.books,
      categoryName: categoryName != null ? categoryName() : this.categoryName,
      page: page != null ? page() : this.page,
      search: search != null ? search() : this.search,
      hasMore: hasMore != null ? hasMore() : this.hasMore,
      formKey: formKey != null ? formKey() : this.formKey,
    );
  }

  @override
  List<Object?> get props => [status, message, books, categoryName, page, search, hasMore, formKey];
}
