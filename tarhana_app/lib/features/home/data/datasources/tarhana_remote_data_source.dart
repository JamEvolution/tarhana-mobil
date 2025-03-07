import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarhana_app/core/constants/api_constants.dart';
import 'package:tarhana_app/core/logger/app_logger.dart';
import 'package:tarhana_app/core/network/dio_client.dart';
import 'package:tarhana_app/core/network/network_exceptions.dart';
import 'package:tarhana_app/features/home/domain/entities/tarhana.dart';

final tarhanaRemoteDataSourceProvider = Provider<TarhanaRemoteDataSource>((ref) {
  final dio = ref.read(dioClientProvider);
  return TarhanaRemoteDataSourceImpl(dio);
});

abstract class TarhanaRemoteDataSource {
  Future<List<Tarhana>> getTarhanaList();
  Future<Tarhana> getTarhanaById(String id);
  Future<void> addTarhana(Tarhana tarhana);
  Future<void> updateTarhana(Tarhana tarhana);
  Future<void> deleteTarhana(String id);
  Future<void> toggleFavorite(String id);
}

class TarhanaRemoteDataSourceImpl implements TarhanaRemoteDataSource {
  final Dio _dio;
  final String _endpoint = ApiConstants.tarhana;

  TarhanaRemoteDataSourceImpl(this._dio);

  /// API isteklerini yönetmek için yardımcı metot
  Future<T> _handleRequest<T>({
    required Future<Response> Function() request,
    required T Function(dynamic data) onSuccess,
    required String errorMessage,
  }) async {
    try {
      appLogger.d('API isteği başlatılıyor: $errorMessage');
      final response = await request();
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        appLogger.d('API isteği başarılı: $errorMessage');
        return onSuccess(response.data);
      } else {
        final exception = NetworkException(
          message: '$errorMessage (Kod: ${response.statusCode})',
          statusCode: response.statusCode,
          requestPath: response.requestOptions.path,
          requestMethod: response.requestOptions.method,
        );
        appLogger.w('API isteği başarısız: ${exception.userFriendlyMessage}');
        throw exception;
      }
    } on DioException catch (e) {
      final exception = NetworkException.fromDioException(e, errorMessage);
      appLogger.e('API isteği hata: ${exception.userFriendlyMessage}', e);
      throw exception;
    } catch (e) {
      final exception = NetworkException(message: '$errorMessage: $e');
      appLogger.e('API isteği beklenmeyen hata: ${exception.message}', e);
      throw exception;
    }
  }

  @override
  Future<List<Tarhana>> getTarhanaList() async {
    appLogger.i('Tarhana listesi alınıyor');
    return _handleRequest<List<Tarhana>>(
      request: () => _dio.get(_endpoint),
      onSuccess: (data) {
        final List<dynamic> responseData = data;
        final tarhanaList = responseData.map((json) => Tarhana.fromJson(json)).toList();
        appLogger.d('${tarhanaList.length} adet tarhana alındı');
        return tarhanaList;
      },
      errorMessage: 'Tarhana listesi alınamadı',
    );
  }

  @override
  Future<Tarhana> getTarhanaById(String id) async {
    appLogger.i('Tarhana detayları alınıyor: $id');
    return _handleRequest<Tarhana>(
      request: () => _dio.get('$_endpoint/$id'),
      onSuccess: (data) {
        final tarhana = Tarhana.fromJson(data);
        appLogger.d('Tarhana detayları alındı: ${tarhana.name}');
        return tarhana;
      },
      errorMessage: 'Tarhana detayları alınamadı',
    );
  }

  @override
  Future<void> addTarhana(Tarhana tarhana) async {
    appLogger.i('Tarhana ekleniyor: ${tarhana.name}');
    return _handleRequest<void>(
      request: () => _dio.post(
        _endpoint,
        data: tarhana.toJson(),
      ),
      onSuccess: (_) {
        appLogger.d('Tarhana başarıyla eklendi: ${tarhana.name}');
        return null;
      },
      errorMessage: 'Tarhana eklenemedi',
    );
  }

  @override
  Future<void> updateTarhana(Tarhana tarhana) async {
    appLogger.i('Tarhana güncelleniyor: ${tarhana.id}');
    return _handleRequest<void>(
      request: () => _dio.put(
        '$_endpoint/${tarhana.id}',
        data: tarhana.toJson(),
      ),
      onSuccess: (_) {
        appLogger.d('Tarhana başarıyla güncellendi: ${tarhana.name}');
        return null;
      },
      errorMessage: 'Tarhana güncellenemedi',
    );
  }

  @override
  Future<void> deleteTarhana(String id) async {
    appLogger.i('Tarhana siliniyor: $id');
    return _handleRequest<void>(
      request: () => _dio.delete('$_endpoint/$id'),
      onSuccess: (_) {
        appLogger.d('Tarhana başarıyla silindi: $id');
        return null;
      },
      errorMessage: 'Tarhana silinemedi',
    );
  }

  @override
  Future<void> toggleFavorite(String id) async {
    appLogger.i('Tarhana favori durumu değiştiriliyor: $id');
    return _handleRequest<void>(
      request: () => _dio.post('$_endpoint/$id/favorite'),
      onSuccess: (_) {
        appLogger.d('Tarhana favori durumu başarıyla değiştirildi: $id');
        return null;
      },
      errorMessage: 'Favori durumu değiştirilemedi',
    );
  }
} 