import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gutenberg/app/route_names.dart';
import 'package:gutenberg/categories/bloc/categories_bloc.dart';
import 'package:gutenberg/categories/views/widgets/category_item.dart';
import 'package:gutenberg/categories/views/widgets/header_view.dart';

class CategoriesMobile extends StatefulWidget {
  const CategoriesMobile({super.key});

  @override
  State<CategoriesMobile> createState() => _CategoriesMobileState();
}

class _CategoriesMobileState extends State<CategoriesMobile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            return Container(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.8),
              child: Column(
                spacing: 10.0,
                children: [
                  HeaderView(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          return CategoryItem(
                            category: state.categories[index],
                            onTap: (category) {
                              context.goNamed(RouteNames.books, extra: category["name"]);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
