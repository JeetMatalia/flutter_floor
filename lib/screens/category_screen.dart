import 'package:flutter/material.dart';
import '../data/category.dart';
import '../providers/category_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/language_provider.dart';

class CategoryScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);
    final isEnglishSelected =
        ref.watch(languageProvider); // Get the current language selection

    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: Column(
        children: [
          // Slider or Switch widget to toggle between English and Arabic
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text('Language: ${isEnglishSelected ? "English" : "Arabic"}'),
                Switch(
                  value: isEnglishSelected,
                  onChanged: (value) {
                    ref.read(languageProvider.notifier).state = value;
                  },
                ),
              ],
            ),
          ),
          // List of categories
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];

                return ListTile(
                  title: Text(isEnglishSelected
                      ? category.englishName
                      : category.arabicName),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showEditDialog(context, ref, category);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          ref
                              .read(categoryProvider.notifier)
                              .deleteCategory(category);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newCategory = Category(
            id: DateTime.now().toIso8601String(),
            englishName: 'New Category',
            arabicName: 'تصنيف جديد',
          );
          ref.read(categoryProvider.notifier).addCategory(newCategory);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, Category category) {
    final TextEditingController controller =
        TextEditingController(text: category.englishName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Category'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'English Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedCategory =
                    category.copyWith(englishName: controller.text);
                ref
                    .read(categoryProvider.notifier)
                    .updateCategory(updatedCategory);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
