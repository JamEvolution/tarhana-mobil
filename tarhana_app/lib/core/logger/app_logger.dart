import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

/// Uygulama genelinde kullanılacak logger sınıfı
class AppLogger {
  late final Logger _logger;
  
  /// Singleton instance
  static final AppLogger _instance = AppLogger._internal();
  
  /// Factory constructor
  factory AppLogger() => _instance;
  
  /// Private constructor
  AppLogger._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
      level: kDebugMode ? Level.verbose : Level.warning,
      filter: ProductionFilter(),
    );
  }
  
  /// Verbose log
  void v(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.v(message, error: error, stackTrace: stackTrace);
  }
  
  /// Debug log
  void d(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }
  
  /// Info log
  void i(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }
  
  /// Warning log
  void w(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }
  
  /// Error log
  void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
  
  /// WTF log
  void wtf(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}

/// Global erişim için getter
AppLogger get appLogger => GetIt.I<AppLogger>();

/// Servis locator'a logger'ı kaydetmek için extension
extension AppLoggerExtension on GetIt {
  void registerAppLogger() {
    if (!isRegistered<AppLogger>()) {
      registerLazySingleton<AppLogger>(() => AppLogger());
    }
  }
} 