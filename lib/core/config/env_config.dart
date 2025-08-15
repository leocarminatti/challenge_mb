import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static bool get isInitialized {
    try {
      return dotenv.isInitialized;
    } catch (e) {
      return false;
    }
  }

  static String get baseUrl {
    if (!isInitialized) {
      throw StateError(
        'Dotenv não inicializado. Use EnvConfig.initialize() primeiro.',
      );
    }

    final url = dotenv.env['BASE_URL'];
    if (url?.isNotEmpty == true) {
      return url!;
    }

    throw StateError('BASE_URL não configurada no arquivo .env');
  }

  static String get coinMarketCapApiKey {
    if (!isInitialized) {
      throw StateError(
        'Dotenv não inicializado. Use EnvConfig.initialize() primeiro.',
      );
    }

    final apiKey = dotenv.env['COINMARKETCAP_API_KEY'];
    if (apiKey?.isNotEmpty == true) {
      return apiKey!;
    }

    throw StateError('COINMARKETCAP_API_KEY não configurada no arquivo .env');
  }

  static Future<bool> initialize() async {
    try {
      if (isInitialized) {
        return true;
      }

      await dotenv.load(fileName: '.env');
      return true;
    } catch (e) {
      return false;
    }
  }
}
