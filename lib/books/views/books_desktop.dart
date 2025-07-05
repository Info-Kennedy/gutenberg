import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gutenberg/app/route_names.dart';
import 'package:gutenberg/books/bloc/books_bloc.dart';
import 'package:gutenberg/books/views/widgets/book_card_item.dart';
import 'package:gutenberg/common/helper/common_helper.dart';
import 'package:gutenberg/common/utils/constants.dart';
import 'package:gutenberg/common/widgets/loader_widget.dart';

import 'widgets/book_search_bar.dart';

class BooksDesktop extends StatefulWidget {
  final String categoryName;
  const BooksDesktop({super.key, required this.categoryName});

  @override
  State<BooksDesktop> createState() => _BooksDesktopState();
}

class _BooksDesktopState extends State<BooksDesktop> {
  final CommonHelper commonHelper = CommonHelper();
  late final ScrollController _scrollController;
  late final TextEditingController _searchController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchController = TextEditingController();
    _focusNode = FocusNode();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<BooksBloc>().add(LoadMoreBooks());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<BooksBloc, BooksState>(
        builder: (context, state) {
          if (_searchController.text != state.search) {
            _searchController.text = state.search;
            _searchController.selection = TextSelection.fromPosition(TextPosition(offset: _searchController.text.length));
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.categoryName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary),
              ),
              leading: IconButton(
                onPressed: () => context.pushNamed(RouteNames.initial),
                icon: SvgPicture.asset(commonHelper.getIconPath("ic_back.svg"), width: 20, height: 20),
              ),
            ),
            body: state.status == BooksStatus.initial
                ? Center(child: LoaderWidget(loaderType: Constants.LOADER_CIRCULAR))
                : Container(
                    color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.8),
                    child: Column(
                      children: [
                        Container(
                          color: Theme.of(context).colorScheme.surface,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          child: BookSearchBar(
                            focusNode: _focusNode,
                            controller: _searchController,
                            onClear: () {
                              _searchController.clear();
                              context.read<BooksBloc>().add(SearchBooks(search: ""));
                            },
                            onChanged: (value) {
                              if (value.length > 7) {
                                context.read<BooksBloc>().add(SearchBooks(search: value));
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(16),
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.5,
                            ),
                            itemCount: state.books.length,
                            itemBuilder: (context, index) {
                              final book = state.books[index];
                              return BookCardItem(book: book);
                            },
                          ),
                        ),
                        state.status == BooksStatus.loading ? LoaderWidget(loaderType: Constants.LOADER_LINER) : const SizedBox.shrink(),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
