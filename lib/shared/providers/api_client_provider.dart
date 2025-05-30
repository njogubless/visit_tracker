import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(baseUrl: 'https://kqgbftwsodpttpqgqnbh.supabase.co/rest/v1/');
});

class ApiClient {
  final String baseUrl;
  ApiClient({required this.baseUrl});
  
  // Your HTTP client implementation
}