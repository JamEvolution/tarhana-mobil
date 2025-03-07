import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarhana_app/core/logger/app_logger.dart';
import 'package:tarhana_app/core/network/network_exceptions.dart';
import 'package:tarhana_app/features/home/data/datasources/tarhana_remote_data_source.dart';
import 'package:tarhana_app/features/home/domain/entities/tarhana.dart';

final tarhanaRepositoryProvider = Provider<TarhanaRepository>((ref) {
  final remoteDataSource = ref.read(tarhanaRemoteDataSourceProvider);
  return TarhanaRepositoryImpl(remoteDataSource);
});

abstract class TarhanaRepository {
  Future<List<Tarhana>> getTarhanaList();
  Future<Tarhana> getTarhanaById(String id);
  Future<void> addTarhana(Tarhana tarhana);
  Future<void> updateTarhana(Tarhana tarhana);
  Future<void> deleteTarhana(String id);
  Future<void> toggleFavorite(String id);
}

class TarhanaRepositoryImpl implements TarhanaRepository {
  final TarhanaRemoteDataSource _remoteDataSource;

  TarhanaRepositoryImpl(this._remoteDataSource);

  /// API isteklerini yönetmek için yardımcı metot
  Future<T> _executeRequest<T>(
    Future<T> Function() request,
    String errorMessage,
  ) async {
    try {
      appLogger.d('Repository: $errorMessage işlemi başlatılıyor');
      final result = await request();
      appLogger.d('Repository: $errorMessage işlemi başarılı');
      return result;
    } on NetworkException catch (e) {
      appLogger.w('Repository: $errorMessage işlemi başarısız', e);
      throw Exception(e.userFriendlyMessage);
    } catch (e) {
      appLogger.e('Repository: $errorMessage işlemi beklenmeyen hata', e);
      throw Exception('$errorMessage: $e');
    }
  }

  @override
  Future<List<Tarhana>> getTarhanaList() async {
    appLogger.i('Repository: Tarhana listesi alınıyor');
    return _executeRequest(
      () => _remoteDataSource.getTarhanaList(),
      'Tarhana listesi alınamadı',
    );
  }

  @override
  Future<Tarhana> getTarhanaById(String id) async {
    appLogger.i('Repository: Tarhana detayları alınıyor: $id');
    return _executeRequest(
      () => _remoteDataSource.getTarhanaById(id),
      'Tarhana detayları alınamadı',
    );
  }

  @override
  Future<void> addTarhana(Tarhana tarhana) async {
    appLogger.i('Repository: Tarhana ekleniyor: ${tarhana.name}');
    return _executeRequest(
      () => _remoteDataSource.addTarhana(tarhana),
      'Tarhana eklenemedi',
    );
  }

  @override
  Future<void> updateTarhana(Tarhana tarhana) async {
    appLogger.i('Repository: Tarhana güncelleniyor: ${tarhana.id}');
    return _executeRequest(
      () => _remoteDataSource.updateTarhana(tarhana),
      'Tarhana güncellenemedi',
    );
  }

  @override
  Future<void> deleteTarhana(String id) async {
    appLogger.i('Repository: Tarhana siliniyor: $id');
    return _executeRequest(
      () => _remoteDataSource.deleteTarhana(id),
      'Tarhana silinemedi',
    );
  }

  @override
  Future<void> toggleFavorite(String id) async {
    appLogger.i('Repository: Tarhana favori durumu değiştiriliyor: $id');
    return _executeRequest(
      () => _remoteDataSource.toggleFavorite(id),
      'Favori durumu değiştirilemedi',
    );
  }
} 