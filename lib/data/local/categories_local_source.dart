import '../models/category_model.dart';

abstract final class CategoriesLocalSource {
  static const List<CategoryModel> categories = [
    CategoryModel(id: 'general', imageKey: 'general'),
    CategoryModel(id: 'business', imageKey: 'busniess'),
    CategoryModel(id: 'sports', imageKey: 'sport'),
    CategoryModel(id: 'technology', imageKey: 'technology'),
    CategoryModel(id: 'entertainment', imageKey: 'entertainment'),
    CategoryModel(id: 'health', imageKey: 'helth'),
    CategoryModel(id: 'science', imageKey: 'science'),
  ];
}
