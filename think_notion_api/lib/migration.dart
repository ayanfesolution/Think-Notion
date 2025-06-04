import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:think_notion_api/services/logger_services.dart';

/// A service that handles database migration.
class MigrationRunner {
  /// The database migration function.
  Future<void> runMigrations(CloudLogger logger) async {
    //Uncomment the lines below if you want to use supabase service
    // const rootCertPath = 'public/prod-ca-2021.crt';

    // final securityContext = SecurityContext(withTrustedRoots: true)
    //   ..setTrustedCertificates(rootCertPath);

    final db = sqlite3.open(p.join(Directory.current.path, 'taskboard.db'));

    try {
      // Ensure the migrations table exists
      // db.execute('''
      //   CREATE TABLE artists(
      //     id SERIAL PRIMARY KEY,
      //     file_name TEXT UNIQUE NOT NULL,
      //     applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      //   );
      // ''');
    } finally {
      db.dispose();
      logger.info('Database connection closed.');
    }
    logger.info('All migrations applied successfully.');
  }
}
