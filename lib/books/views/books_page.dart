import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutenberg/books/bloc/books_bloc.dart';
import 'package:gutenberg/books/repository/books_repository.dart';
import 'package:gutenberg/books/views/books_desktop.dart';
import 'package:gutenberg/books/views/books_mobile.dart';
import 'package:gutenberg/common/common.dart';
import 'package:responsive_framework/responsive_framework.dart';

class BooksPage extends StatelessWidget {
  final String categoryName;
  const BooksPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BooksBloc(
        repository: BooksRepository(prefRepo: getIt<PreferencesRepository>(), apiRepo: getIt<ApiRepository>()),
      )..add(InitializeBooks(categoryName: categoryName)),
      child: ResponsiveValue<Widget>(
        context,
        defaultValue: BooksDesktop(categoryName: categoryName),
        conditionalValues: [
          Condition.smallerThan(
            name: DESKTOP,
            value: BooksMobile(categoryName: categoryName),
          ),
        ],
      ).value,
    );
  }
}
