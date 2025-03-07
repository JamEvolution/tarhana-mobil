import 'package:dio/dio.dart';
import 'package:tarhana_app/core/logger/app_logger.dart';

/// Ağ isteklerinde oluşabilecek hataları yönetmek için özel istisna sınıfı
class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic error;
  final String? requestPath;
  final String? requestMethod;

  NetworkException({
    required this.message,
    this.statusCode,
    this.error,
    this.requestPath,
    this.requestMethod,
  });

  /// DioException'dan NetworkException oluşturmak için fabrika metodu
  factory NetworkException.fromDioException(DioException e, String defaultMessage) {
    String message = defaultMessage;
    int? statusCode = e.response?.statusCode;
    final requestPath = e.requestOptions.path;
    final requestMethod = e.requestOptions.method;

    // Hata tipine göre mesaj oluştur
    if (e.type == DioExceptionType.connectionTimeout) {
      message = 'Bağlantı zaman aşımına uğradı';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      message = 'Yanıt alma zaman aşımına uğradı';
    } else if (e.type == DioExceptionType.sendTimeout) {
      message = 'İstek gönderme zaman aşımına uğradı';
    } else if (e.type == DioExceptionType.badResponse) {
      message = _handleErrorResponse(e.response, defaultMessage);
    } else if (e.type == DioExceptionType.cancel) {
      message = 'İstek iptal edildi';
    } else if (e.type == DioExceptionType.connectionError) {
      message = 'İnternet bağlantısı yok';
    } else {
      message = '$defaultMessage: ${e.message}';
    }

    // Detaylı log
    appLogger.e(
      'NetworkException: $message',
      {
        'type': e.type.toString(),
        'path': requestPath,
        'method': requestMethod,
        'statusCode': statusCode,
        'error': e.error,
      },
      e.stackTrace,
    );

    return NetworkException(
      message: message,
      statusCode: statusCode,
      error: e,
      requestPath: requestPath,
      requestMethod: requestMethod,
    );
  }

  /// Hata yanıtını işlemek için yardımcı metot
  static String _handleErrorResponse(Response? response, String defaultMessage) {
    if (response == null) {
      return defaultMessage;
    }

    try {
      final statusCode = response.statusCode;
      final data = response.data;

      // Hata mesajını çıkar
      if (data is Map<String, dynamic>) {
        if (data.containsKey('message')) {
          return '${data['message']} (Kod: $statusCode)';
        } else if (data.containsKey('error')) {
          if (data['error'] is String) {
            return '${data['error']} (Kod: $statusCode)';
          } else if (data['error'] is Map && data['error'].containsKey('message')) {
            return '${data['error']['message']} (Kod: $statusCode)';
          }
        }
      }
      
      // Durum koduna göre genel hata mesajları
      switch (statusCode) {
        case 400:
          return 'Geçersiz istek (Kod: 400)';
        case 401:
          return 'Yetkilendirme hatası (Kod: 401)';
        case 403:
          return 'Erişim reddedildi (Kod: 403)';
        case 404:
          return 'Kaynak bulunamadı (Kod: 404)';
        case 500:
          return 'Sunucu hatası (Kod: 500)';
        default:
          return '$defaultMessage (Kod: $statusCode)';
      }
    } catch (e) {
      appLogger.e('Hata yanıtı işlenirken beklenmeyen hata', e);
      return '$defaultMessage: $e';
    }
  }

  /// Kullanıcı dostu hata mesajı
  String get userFriendlyMessage {
    if (statusCode == 401) {
      return 'Oturum süreniz dolmuş olabilir. Lütfen tekrar giriş yapın.';
    } else if (statusCode == 403) {
      return 'Bu işlemi yapmak için yetkiniz bulunmuyor.';
    } else if (statusCode == 404) {
      return 'Aradığınız kaynak bulunamadı.';
    } else if (statusCode == 500) {
      return 'Sunucu hatası oluştu. Lütfen daha sonra tekrar deneyin.';
    } else if (statusCode == null && message.contains('bağlantı')) {
      return 'İnternet bağlantınızı kontrol edin ve tekrar deneyin.';
    }
    return message;
  }

  @override
  String toString() => message;
} 