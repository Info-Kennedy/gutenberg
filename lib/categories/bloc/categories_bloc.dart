import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gutenberg/categories/repository/categories_repository.dart';
import 'package:logger/logger.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final log = Logger();
  final CategoriesRepository _repository;

  CategoriesBloc({required CategoriesRepository repository}) : _repository = repository, super(CategoriesState.initial) {
    on<InitializeCategories>(_onInitializeCategoriesToState);
  }

  Future<void> _onInitializeCategoriesToState(InitializeCategories event, Emitter<CategoriesState> emit) async {
    log.d("CategoriesBloc:::_onInitializeCategoriesToState:Event:: $event");
    emit(state.copyWith(status: () => CategoriesStatus.loading));
    try {
      final categories = await _repository.getCategories();
      emit(state.copyWith(status: () => CategoriesStatus.loaded, categories: () => categories));
    } catch (error) {
      log.e("CategoriesBloc:::_onInitializeCategoriesToState::Error: $error");
      emit(state.copyWith(status: () => CategoriesStatus.error, message: () => error.toString()));
    }
  }
}
