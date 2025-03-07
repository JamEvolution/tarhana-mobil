import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarhana_app/features/home/domain/entities/tarhana.dart';
import 'package:tarhana_app/features/home/domain/repositories/tarhana_repository.dart';

final homeControllerProvider = AutoDisposeAsyncNotifierProvider<HomeController, List<Tarhana>>(() {
  return HomeController();
});

class HomeController extends AutoDisposeAsyncNotifier<List<Tarhana>> {
  late final TarhanaRepository _repository;
  
  @override
  Future<List<Tarhana>> build() async {
    _repository = ref.read(tarhanaRepositoryProvider);
    return _fetchTarhanaList();
  }
  
  Future<List<Tarhana>> _fetchTarhanaList() async {
    try {
      return await _repository.getTarhanaList();
    } catch (e) {
      throw Exception('Tarhana listesi alınamadı: $e');
    }
  }
  
  Future<void> refreshTarhanaList() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchTarhanaList());
  }
  
  Future<void> addTarhana(Tarhana tarhana) async {
    try {
      await _repository.addTarhana(tarhana);
      refreshTarhanaList();
    } catch (e) {
      throw Exception('Tarhana eklenemedi: $e');
    }
  }
  
  Future<void> deleteTarhana(String id) async {
    try {
      await _repository.deleteTarhana(id);
      refreshTarhanaList();
    } catch (e) {
      throw Exception('Tarhana silinemedi: $e');
    }
  }
} 