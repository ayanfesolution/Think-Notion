import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:think_notion_api/migration.dart';
import 'package:think_notion_api/services/logger_services.dart';
import 'package:think_notion_api/services/service_locator.dart';




Future<void> init(InternetAddress ip, int port) async {
  setupLocator();
  // Automatically apply migrations on server start

  final runner = MigrationRunner(); // Expose `_connection` if needed
  final logger = locator<CloudLogger>();
  await runner.runMigrations(logger);
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  // ignore: lines_longer_than_80_chars
  // 2. Use the provided `handler`, `ip`, and `port` to create a custom `HttpServer`.
  // Or use the Dart Frog serve method to do that for you.
  return serve(
    handler,
    ip,
    port,
    poweredByHeader: 'Padi4Life Limited',
  );
}
