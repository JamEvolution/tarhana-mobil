import 'package:hive_flutter/hive_flutter.dart';
import 'package:tarhana_app/features/home/domain/entities/tarhana.dart';

class HiveStorage {
  // Singleton pattern
  static final HiveStorage _instance = HiveStorage._internal();
  factory HiveStorage() => _instance;
  HiveStorage._internal();

  // Box names
  static const String settingsBox = 'settings';
  static const String favoritesBox = 'favorites';
  static const String userBox = 'user';
  static const String tarhanaBox = 'tarhana';

  // Keys
  static const String themeKey = 'theme';
  static const String languageKey = 'language';
  static const String notificationsKey = 'notifications';
  static const String userIdKey = 'userId';
  static const String userTokenKey = 'userToken';

  // Initialize Hive
  Future<void> init() async {
    await Hive.initFlutter();
    
    // Open boxes
    await Hive.openBox(settingsBox);
    await Hive.openBox(favoritesBox);
    await Hive.openBox(userBox);
    await Hive.openBox(tarhanaBox);
  }

  // Settings methods
  bool isDarkMode() {
    final box = Hive.box(settingsBox);
    return box.get(themeKey, defaultValue: false);
  }

  Future<void> setDarkMode(bool value) async {
    final box = Hive.box(settingsBox);
    await box.put(themeKey, value);
  }

  String getLanguage() {
    final box = Hive.box(settingsBox);
    return box.get(languageKey, defaultValue: 'Türkçe');
  }

  Future<void> setLanguage(String value) async {
    final box = Hive.box(settingsBox);
    await box.put(languageKey, value);
  }

  bool isNotificationsEnabled() {
    final box = Hive.box(settingsBox);
    return box.get(notificationsKey, defaultValue: true);
  }

  Future<void> setNotificationsEnabled(bool value) async {
    final box = Hive.box(settingsBox);
    await box.put(notificationsKey, value);
  }

  // User methods
  String? getUserId() {
    final box = Hive.box(userBox);
    return box.get(userIdKey);
  }

  Future<void> setUserId(String value) async {
    final box = Hive.box(userBox);
    await box.put(userIdKey, value);
  }

  String? getUserToken() {
    final box = Hive.box(userBox);
    return box.get(userTokenKey);
  }

  Future<void> setUserToken(String value) async {
    final box = Hive.box(userBox);
    await box.put(userTokenKey, value);
  }

  Future<void> clearUserData() async {
    final box = Hive.box(userBox);
    await box.clear();
  }

  // Favorites methods
  List<String> getFavoriteIds() {
    final box = Hive.box(favoritesBox);
    return List<String>.from(box.values);
  }

  Future<void> addFavorite(String tarhanaId) async {
    final box = Hive.box(favoritesBox);
    final favorites = getFavoriteIds();
    if (!favorites.contains(tarhanaId)) {
      await box.add(tarhanaId);
    }
  }

  Future<void> removeFavorite(String tarhanaId) async {
    final box = Hive.box(favoritesBox);
    final favorites = getFavoriteIds();
    final index = favorites.indexOf(tarhanaId);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }

  bool isFavorite(String tarhanaId) {
    final favorites = getFavoriteIds();
    return favorites.contains(tarhanaId);
  }

  // Tarhana cache methods
  Future<void> cacheTarhanaList(List<Tarhana> tarhanaList) async {
    final box = Hive.box(tarhanaBox);
    final Map<String, Map<String, dynamic>> tarhanaMap = {};
    
    for (final tarhana in tarhanaList) {
      tarhanaMap[tarhana.id] = {
        'id': tarhana.id,
        'name': tarhana.name,
        'description': tarhana.description,
        'ingredients': tarhana.ingredients,
        'steps': tarhana.steps,
        'imageUrl': tarhana.imageUrl,
        'authorId': tarhana.authorId,
        'createdAt': tarhana.createdAt.toIso8601String(),
        'likes': tarhana.likes,
        'isFavorite': tarhana.isFavorite,
      };
    }
    
    await box.putAll(tarhanaMap);
  }

  List<Tarhana> getCachedTarhanaList() {
    final box = Hive.box(tarhanaBox);
    final List<Tarhana> tarhanaList = [];
    
    for (final key in box.keys) {
      final data = box.get(key);
      if (data != null && data is Map) {
        try {
          final tarhana = Tarhana(
            id: data['id'],
            name: data['name'],
            description: data['description'],
            ingredients: List<String>.from(data['ingredients']),
            steps: List<String>.from(data['steps']),
            imageUrl: data['imageUrl'],
            authorId: data['authorId'],
            createdAt: DateTime.parse(data['createdAt']),
            likes: data['likes'],
            isFavorite: data['isFavorite'],
          );
          tarhanaList.add(tarhana);
        } catch (e) {
          // Skip invalid data
        }
      }
    }
    
    return tarhanaList;
  }

  Future<void> clearCache() async {
    final box = Hive.box(tarhanaBox);
    await box.clear();
  }
} 