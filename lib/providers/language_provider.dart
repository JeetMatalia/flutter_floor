import 'package:riverpod/riverpod.dart';

// Define a provider for the language selection state (true for English, false for Arabic)
final languageProvider = StateProvider<bool>((ref) => true); // true = English, false = Arabic
