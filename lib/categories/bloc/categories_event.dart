part of 'categories_bloc.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

final class InitializeCategories extends CategoriesEvent {
  const InitializeCategories();
}
