import 'package:floor/floor.dart';

@entity
class Category {
  @PrimaryKey(autoGenerate: false)
  final String id;
  final String englishName;
  final String arabicName;

  Category({
    required this.id,
    required this.englishName,
    required this.arabicName,
  });

  // Adding the copyWith method to allow modifications to fields
  Category copyWith({
    String? id,
    String? englishName,
    String? arabicName,
  }) {
    return Category(
      id: id ?? this.id,
      englishName: englishName ?? this.englishName,
      arabicName: arabicName ?? this.arabicName,
    );
  }
}
