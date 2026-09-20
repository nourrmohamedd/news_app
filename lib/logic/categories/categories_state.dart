import 'package:equatable/equatable.dart';

import '../../data/models/category_model.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();
  @override
  List<Object?> get props => [];
}

class CategoriesLoading extends CategoriesState {
  const CategoriesLoading();
}

class CategoriesLoaded extends CategoriesState {
  const CategoriesLoaded(this.categories);
  final List<CategoryModel> categories;
  @override
  List<Object?> get props => [categories];
}

class CategoriesFailure extends CategoriesState {
  const CategoriesFailure();
}
