import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarhana_app/core/di/service_locator.dart';
import 'package:tarhana_app/core/logger/app_logger.dart';
import 'package:tarhana_app/core/router/app_router.dart';
import 'package:tarhana_app/core/storage/hive_storage.dart';
import 'package:tarhana_app/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  final hiveStorage = HiveStorage();
  await hiveStorage.init();
  
  // Dependency Injection
  await setupServiceLocator();
  
  // Log application start
  appLogger.i('🚀 Tarhana uygulaması başlatılıyor');
  
  runApp(
    const ProviderScope(
      child: TarhanaApp(),
    ),
  );
}

class TarhanaApp extends ConsumerWidget {
  const TarhanaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    appLogger.d('TarhanaApp build metodu çağrıldı');
    final appRouter = getIt<AppRouter>();
    
    return MaterialApp.router(
      title: 'Tarhana',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter.config(),
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) {
        appLogger.d('Uygulama başlığı oluşturuluyor');
        return 'Tarhana';
      },
    );
  }
}
