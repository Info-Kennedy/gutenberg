part of 'categories_bloc.dart';

enum CategoriesStatus { initial, loaded, loading, changing, changed, success, error }

class CategoriesState extends Equatable {
  final String message;
  final CategoriesStatus status;
  final List<Map<String, dynamic>> categories;

  const CategoriesState({required this.status, required this.message, required this.categories});

  static CategoriesState initial = CategoriesState(message: "", status: CategoriesStatus.initial, categories: []);

  CategoriesState copyWith({CategoriesStatus Function()? status, String Function()? message, List<Map<String, dynamic>> Function()? categories}) {
    return CategoriesState(
      status: status != null ? status() : this.status,
      message: message != null ? message() : this.message,
      categories: categories != null ? categories() : this.categories,
    );
  }

  @override
  List<Object?> get props => [status, message, categories];
}
