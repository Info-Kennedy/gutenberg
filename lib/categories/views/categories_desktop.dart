import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gutenberg/app/route_names.dart';
import 'package:gutenberg/categories/bloc/categories_bloc.dart';
import 'package:gutenberg/categories/views/widgets/category_item.dart';
import 'package:gutenberg/categories/views/widgets/header_view.dart';

class CategoriesDesktop extends StatefulWidget {
  const CategoriesDesktop({super.key});

  @override
  State<CategoriesDesktop> createState() => _CategoriesDesktopState();
}

class _CategoriesDesktopState extends State<CategoriesDesktop> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.8),
              child: Column(
                spacing: 10.0,
                children: [
                  HeaderView(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15, vertical: 10.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 70.0,
                          mainAxisSpacing: 20.0,
                          childAspectRatio: 4,
                          mainAxisExtent: 70.0,
                        ),
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
