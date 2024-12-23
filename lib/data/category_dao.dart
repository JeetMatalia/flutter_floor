import 'package:floor/floor.dart';
import 'category.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM Category')
  Future<List<Category>> getAllCategories();

  @Query('SELECT * FROM Category WHERE id = :id')
  Future<Category?> getCategoryById(String id);

  @insert
  Future<void> insertCategory(Category category);

  @update
  Future<void> updateCategory(Category category);

  @delete
  Future<void> deleteCategory(Category category);
}