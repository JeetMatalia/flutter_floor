import 'package:riverpod/riverpod.dart';

import '../data/category.dart';
import '../data/category_dao.dart';
import 'database_provider.dart';

final categoryProvider = StateNotifierProvider<CategoryNotifier, List<Category>>((ref) {
  final database = ref.watch(databaseProvider);
  return CategoryNotifier(database.categoryDao);
});

class CategoryNotifier extends StateNotifier<List<Category>> {
  final CategoryDao _categoryDao;

  CategoryNotifier(this._categoryDao) : super([]) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    final categories = await _categoryDao.getAllCategories();
    state = categories;
  }

  Future<void> addCategory(Category category) async {
    await _categoryDao.insertCategory(category);
    loadCategories();
  }

  Future<void> updateCategory(Category category) async {
    await _categoryDao.updateCategory(category);
    loadCategories();
  }

  Future<void> deleteCategory(Category category) async {
    await _categoryDao.deleteCategory(category);
    loadCategories();
  }
}
