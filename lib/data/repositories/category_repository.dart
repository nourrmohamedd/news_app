import '../local/categories_local_source.dart';
import '../models/category_model.dart';

class CategoryRepository {
  Future<List<CategoryModel>> fetchCategories() async =>
      CategoriesLocalSource.categories;
}
