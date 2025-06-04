import 'dart:convert';
import 'dart:io';

/// All the loglevel used in the app
enum LogLevel {
  /// for debug
  debug,

  /// for info
  info,

  /// for warning
  warning,

  /// for error
  error,

  /// for critical
  critical,
}

///The logger class
class CloudLogger {
  /// The logger instance
  CloudLogger({
    required this.serviceName,
    required this.serviceVersion,
    this.prettyPrint = false,
  });

  /// The name of the service
  final String serviceName;

  /// The version of the service
  final String serviceVersion;

  /// Whether to pretty print the logs
  final bool prettyPrint;

  /// The logger function
  void log({
    required LogLevel level,
    required String message,
    Map<String, dynamic>? metadata,
    String? requestId,
  }) {
    final logEntry = {
      'severity': _logLevelToString(level),
      'message': message,
      'timestamp': DateTime.now().toUtc().toIso8601String(),
      'serviceContext': {
        'service': serviceName,
        'version': serviceVersion,
      },
      if (requestId != null) 'logging.googleapis.com/trace': requestId,
      if (metadata != null) 'metadata': metadata,
    };

    final output = prettyPrint
        ? const JsonEncoder.withIndent('  ').convert(logEntry)
        : jsonEncode(logEntry);
    stdout.writeln(output);
  }

  /// The log level to string function for debug
  void debug(String message, {Map<String, dynamic>? metadata}) => log(
        level: LogLevel.debug,
        message: message,
        metadata: metadata,
      );

  /// The log level to string function for info
  void info(String message, {Map<String, dynamic>? metadata}) => log(
        level: LogLevel.info,
        message: message,
        metadata: metadata,
      );

  /// The log level to string function for warning
  void warning(String message, {Map<String, dynamic>? metadata}) => log(
        level: LogLevel.warning,
        message: message,
        metadata: metadata,
      );

  /// The log level to string function for error
  void error(String message, {Map<String, dynamic>? metadata}) => log(
        level: LogLevel.error,
        message: message,
        metadata: metadata,
      );

  /// The log level to string function for fatal
  void critical(String message, {Map<String, dynamic>? metadata}) => log(
        level: LogLevel.critical,
        message: message,
        metadata: metadata,
      );

  String _logLevelToString(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 'DEBUG';
      case LogLevel.info:
        return 'INFO';
      case LogLevel.warning:
        return 'WARNING';
      case LogLevel.error:
        return 'ERROR';
      case LogLevel.critical:
        return 'CRITICAL';
    }
  }
}
