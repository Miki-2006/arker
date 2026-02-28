import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String _get(String value, String key) {
    if (value.isNotEmpty) return value;
    return dotenv.env[key] ?? '';
  }

  static String get apiUrl => _get(
        const String.fromEnvironment('SUPABASE_URL'),
        'SUPABASE_URL',
      );

  static String get supabaseKey => _get(
        const String.fromEnvironment('SUPABASE_ANON_KEY'),
        'SUPABASE_ANON_KEY',
      );
}
