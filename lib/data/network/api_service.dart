import 'package:http/http.dart' as http;

import '../../core/env/environment_config.dart';

class ApiService {
  final String baseUrl = EnvironmentConfig.apiBaseUrl;

  Future<http.Response> fetchData(String endpoint) {
    return http.get(Uri.parse('$baseUrl/$endpoint'));
  }
}
