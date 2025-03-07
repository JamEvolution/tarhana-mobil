import 'package:tarhana_app/features/home/domain/entities/tarhana.dart';

class MockService {
  // Singleton pattern
  static final MockService _instance = MockService._internal();
  factory MockService() => _instance;
  MockService._internal();

  // Mock data
  final List<Map<String, dynamic>> _tarhanaData = [
    {
      'id': '1',
      'name': 'Domates Tarhana',
      'description': 'Geleneksel domates tarhana tarifi',
      'ingredients': [
        'domates',
        'un',
        'yoğurt',
        'tuz',
        'biber',
        'nane',
      ],
      'steps': [
        'Domatesleri doğrayın',
        'Diğer malzemeleri ekleyin',
        'Karıştırın',
        'Kurutun',
      ],
      'imageUrl': 'https://via.placeholder.com/300x200?text=Domates+Tarhana',
      'authorId': 'user1',
      'createdAt': DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
      'likes': 42,
      'isFavorite': true,
    },
    {
      'id': '2',
      'name': 'Sebzeli Tarhana',
      'description': 'Sebzeli tarhana çorbası için özel tarif',
      'ingredients': [
        'havuç',
        'kabak',
        'soğan',
        'un',
        'yoğurt',
        'tuz',
      ],
      'steps': [
        'Sebzeleri rendeleyin',
        'Diğer malzemeleri ekleyin',
        'Karıştırın',
        'Kurutun',
      ],
      'imageUrl': 'https://via.placeholder.com/300x200?text=Sebzeli+Tarhana',
      'authorId': 'user2',
      'createdAt': DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
      'likes': 28,
      'isFavorite': false,
    },
    {
      'id': '3',
      'name': 'Acılı Tarhana',
      'description': 'Acı sevenlere özel tarhana tarifi',
      'ingredients': [
        'kırmızı biber',
        'pul biber',
        'un',
        'yoğurt',
        'tuz',
      ],
      'steps': [
        'Biberleri doğrayın',
        'Diğer malzemeleri ekleyin',
        'Karıştırın',
        'Kurutun',
      ],
      'imageUrl': 'https://via.placeholder.com/300x200?text=Acılı+Tarhana',
      'authorId': 'user1',
      'createdAt': DateTime.now().subtract(const Duration(days: 15)).toIso8601String(),
      'likes': 35,
      'isFavorite': true,
    },
    {
      'id': '4',
      'name': 'Yoğurtlu Tarhana',
      'description': 'Bol yoğurtlu geleneksel tarhana',
      'ingredients': [
        'yoğurt',
        'un',
        'tuz',
        'nane',
      ],
      'steps': [
        'Yoğurt ve unu karıştırın',
        'Tuz ve nane ekleyin',
        'İyice yoğurun',
        'Kurutun',
      ],
      'imageUrl': 'https://via.placeholder.com/300x200?text=Yoğurtlu+Tarhana',
      'authorId': 'user3',
      'createdAt': DateTime.now().subtract(const Duration(days: 20)).toIso8601String(),
      'likes': 19,
      'isFavorite': false,
    },
    {
      'id': '5',
      'name': 'Mantarlı Tarhana',
      'description': 'Mantar severlere özel tarhana tarifi',
      'ingredients': [
        'mantar',
        'soğan',
        'un',
        'yoğurt',
        'tuz',
      ],
      'steps': [
        'Mantarları doğrayın',
        'Soğanları kavurun',
        'Diğer malzemeleri ekleyin',
        'Karıştırın',
        'Kurutun',
      ],
      'imageUrl': 'https://via.placeholder.com/300x200?text=Mantarlı+Tarhana',
      'authorId': 'user2',
      'createdAt': DateTime.now().subtract(const Duration(days: 25)).toIso8601String(),
      'likes': 23,
      'isFavorite': true,
    },
  ];

  final Map<String, dynamic> _userData = {
    'user1': {
      'id': 'user1',
      'name': 'Ahmet Yılmaz',
      'email': 'ahmet@example.com',
      'profileImage': 'https://via.placeholder.com/150?text=Ahmet',
    },
    'user2': {
      'id': 'user2',
      'name': 'Ayşe Demir',
      'email': 'ayse@example.com',
      'profileImage': 'https://via.placeholder.com/150?text=Ayşe',
    },
    'user3': {
      'id': 'user3',
      'name': 'Mehmet Kaya',
      'email': 'mehmet@example.com',
      'profileImage': 'https://via.placeholder.com/150?text=Mehmet',
    },
  };

  // Tarhana methods
  List<Tarhana> getTarhanaList() {
    return _tarhanaData.map((data) => _convertToTarhana(data)).toList();
  }

  Tarhana getTarhanaById(String id) {
    final data = _tarhanaData.firstWhere(
      (item) => item['id'] == id,
      orElse: () => throw Exception('Tarhana bulunamadı'),
    );
    return _convertToTarhana(data);
  }

  List<Tarhana> getTarhanaByAuthor(String authorId) {
    final filteredData = _tarhanaData.where((item) => item['authorId'] == authorId).toList();
    return filteredData.map((data) => _convertToTarhana(data)).toList();
  }

  List<Tarhana> getFavoriteTarhana() {
    final filteredData = _tarhanaData.where((item) => item['isFavorite'] == true).toList();
    return filteredData.map((data) => _convertToTarhana(data)).toList();
  }

  void toggleFavorite(String id) {
    final index = _tarhanaData.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      _tarhanaData[index]['isFavorite'] = !_tarhanaData[index]['isFavorite'];
    }
  }

  // User methods
  Map<String, dynamic> getUserById(String id) {
    if (_userData.containsKey(id)) {
      return _userData[id]!;
    } else {
      throw Exception('Kullanıcı bulunamadı');
    }
  }

  // Helper methods
  Tarhana _convertToTarhana(Map<String, dynamic> data) {
    return Tarhana(
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
  }
} 