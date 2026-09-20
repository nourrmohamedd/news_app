import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/category_repository.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this._repository) : super(const CategoriesLoading());
  final CategoryRepository _repository;

  Future<void> load() async {
    emit(const CategoriesLoading());
    try {
      emit(CategoriesLoaded(await _repository.fetchCategories()));
    } catch (_) {
      emit(const CategoriesFailure());
    }
  }
}
