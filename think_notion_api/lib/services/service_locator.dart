import 'package:get_it/get_it.dart';
import 'package:think_notion_api/services/dio_services.dart';
import 'package:think_notion_api/services/logger_services.dart';

///in
final GetIt locator = GetIt.instance;

///invocation of used clases
void setupLocator() {
  // Register EnvService
  locator
    ..registerLazySingleton<CloudLogger>(
      () => CloudLogger(
        serviceName: 'padi4life',
        serviceVersion: '1.0',
        // Set to true for readable logs in local dev
        prettyPrint: true,
      ),
    )
    ..registerLazySingleton<DioService>(
      () => DioService(
        baseUrl: '',
      ),
      instanceName: 'oneSignal',
    );
}
