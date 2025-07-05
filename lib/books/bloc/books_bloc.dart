import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gutenberg/books/models/book.dart';
import 'package:gutenberg/books/repository/books_repository.dart';
import 'package:logger/logger.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final log = Logger();
  final BooksRepository _repository;

  BooksBloc({required BooksRepository repository}) : _repository = repository, super(BooksState.initial) {
    on<InitializeBooks>(_onInitializeBooksToState);
    on<SearchBooks>(_onSearchBooksToState);
    on<LoadMoreBooks>(_onLoadMoreBooksToState);
  }

  Future<void> _onInitializeBooksToState(InitializeBooks event, Emitter<BooksState> emit) async {
    log.d("BooksBloc:::_onInitializeBooksToState:Event:: $event");
    emit(state.copyWith(status: () => BooksStatus.initial));
    try {
      final books = await _repository.getBooks(categoryName: event.categoryName, page: 1, search: "");
      emit(
        state.copyWith(
          status: () => BooksStatus.loaded,
          books: () => books,
          categoryName: () => event.categoryName,
          page: () => 1,
          search: () => "",
          hasMore: () => books.isNotEmpty,
        ),
      );
    } catch (error) {
      log.e("BooksBloc:::_onInitializeBooksToState::Error: $error");
      emit(state.copyWith(status: () => BooksStatus.error, message: () => error.toString()));
    }
  }

  Future<void> _onSearchBooksToState(SearchBooks event, Emitter<BooksState> emit) async {
    log.d("BooksBloc:::_onSearchBooksToState:Event:: $event");
    emit(state.copyWith(status: () => BooksStatus.loading, search: () => event.search));
    try {
      final books = await _repository.getBooks(categoryName: state.categoryName, page: 1, search: event.search);
      emit(
        state.copyWith(
          status: () => BooksStatus.loaded,
          books: () => books,
          categoryName: () => state.categoryName,
          page: () => 1,
          search: () => event.search,
          hasMore: () => books.isNotEmpty,
        ),
      );
    } catch (error) {
      log.e("BooksBloc:::_onSearchBooksToState::Error: $error");
      emit(state.copyWith(status: () => BooksStatus.error, message: () => error.toString()));
    }
  }

  Future<void> _onLoadMoreBooksToState(LoadMoreBooks event, Emitter<BooksState> emit) async {
    log.d("BooksBloc:::_onLoadMoreBooksToState:Event:: $event");
    emit(state.copyWith(status: () => BooksStatus.loading));
    try {
      final books = await _repository.getBooks(categoryName: state.categoryName, page: state.page + 1, search: state.search);
      emit(
        state.copyWith(
          status: () => BooksStatus.loaded,
          books: () => [...state.books, ...books],
          categoryName: () => state.categoryName,
          page: () => state.page + 1,
          search: () => state.search,
          hasMore: () => books.isNotEmpty,
        ),
      );
    } catch (error) {
      log.e("BooksBloc:::_onLoadMoreBooksToState::Error: $error");
      emit(state.copyWith(status: () => BooksStatus.error, message: () => error.toString()));
    }
  }
}
