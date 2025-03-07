import 'package:get_it/get_it.dart';
import 'package:tarhana_app/core/logger/app_logger.dart';
import 'package:tarhana_app/core/network/mock_service.dart';
import 'package:tarhana_app/core/router/app_router.dart';
import 'package:tarhana_app/core/storage/hive_storage.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Logger
  getIt.registerAppLogger();
  
  // Router
  getIt.registerSingleton<AppRouter>(AppRouter());
  
  // Storage
  getIt.registerLazySingleton<HiveStorage>(() => HiveStorage());
  
  // Services
  getIt.registerLazySingleton<MockService>(() => MockService());
  
  // Repositories
  
  // Controllers
} 