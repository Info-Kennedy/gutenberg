import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutenberg/categories/bloc/categories_bloc.dart';
import 'package:gutenberg/categories/repository/categories_repository.dart';
import 'package:gutenberg/categories/views/categories_desktop.dart';
import 'package:gutenberg/categories/views/categories_mobile.dart';
import 'package:gutenberg/common/common.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesBloc(
        repository: CategoriesRepository(prefRepo: getIt<PreferencesRepository>(), apiRepo: getIt<ApiRepository>()),
      )..add(InitializeCategories()),
      child: ResponsiveValue<Widget>(
        context,
        defaultValue: const CategoriesDesktop(),
        conditionalValues: [const Condition.smallerThan(name: DESKTOP, value: CategoriesMobile())],
      ).value,
    );
  }
}
