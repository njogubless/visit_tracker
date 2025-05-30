import 'package:dio/dio.dart';
import 'package:visit_tracker/Features/visits/Data/models/visit_model.dart';
import 'package:visit_tracker/core/constants/api_constants.dart';
import 'package:visit_tracker/core/errors/failures.dart';
import 'package:visit_tracker/core/network/api_client.dart';

abstract class VisitRemoteDataSource {
  Future<List<VisitModel>> getVisits();
  Future<VisitModel> createVisit(Map<String, dynamic> visitData);
  Future<VisitModel> updateVisit(int id, Map<String, dynamic> visitData);
  Future<void> deleteVisit(int id);
  String get baseUrl;
}

class VisitRemoteDataSourceImpl implements VisitRemoteDataSource {
  final ApiClient _apiClient;
  
  VisitRemoteDataSourceImpl(this._apiClient);
  
  @override
  String get baseUrl => 'https://kqgbftwsodpttpqgqnbh.supabase.co/rest/v1/';
  
  @override
  Future<List<VisitModel>> getVisits() async {
    try {
      print('🔄 Fetching visits from: ${baseUrl}${ApiConstants.visitsEndpoint}');
      
      final response = await _apiClient.dio.get(
        ApiConstants.visitsEndpoint,
        queryParameters: {'order': 'created_at.desc'},
      );
      
      print('✅ Response status: ${response.statusCode}');
      print('📦 Response data type: ${response.data.runtimeType}');
      print('📦 Response data: ${response.data}');
      
      // Handle different response formats
      List<dynamic> data;
      if (response.data is List) {
        data = response.data as List<dynamic>;
      } else if (response.data is Map && response.data.containsKey('data')) {
        data = response.data['data'] as List<dynamic>;
      } else {
        throw ServerFailure('Unexpected response format: ${response.data}');
      }
      
      print('📊 Found ${data.length} visits');
      
      final visits = data.map((json) {
        try {
          return VisitModel.fromJson(json as Map<String, dynamic>);
        } catch (e) {
          print('❌ Error parsing visit: $e');
          print('🔍 Raw JSON: $json');
          rethrow;
        }
      }).toList();
      
      print('✅ Successfully parsed ${visits.length} visits');
      return visits;
      
    } on DioException catch (e) {
      print('❌ Dio Error: ${e.message}');
      print('❌ Response: ${e.response?.data}');
      throw ServerFailure('Failed to fetch visits: ${e.message}');
    } catch (e) {
      print('❌ Unexpected error: $e');
      throw ServerFailure('Unexpected error while fetching visits: $e');
    }
  }
  
  @override
  Future<VisitModel> createVisit(Map<String, dynamic> visitData) async {
    try {
      print('🔄 Creating visit with data: $visitData');
      
      final response = await _apiClient.dio.post(
        ApiConstants.visitsEndpoint,
        data: visitData,
      );
      
      print('✅ Create response: ${response.data}');
      
      // Supabase usually returns an array even for single inserts
      dynamic responseData = response.data;
      if (responseData is List && responseData.isNotEmpty) {
        responseData = responseData.first;
      }
      
      return VisitModel.fromJson(responseData as Map<String, dynamic>);
    } on DioException catch (e) {
      print('❌ Create error: ${e.message}');
      print('❌ Response: ${e.response?.data}');
      throw ServerFailure('Failed to create visit: ${e.message}');
    }
  }
  
  @override
  Future<VisitModel> updateVisit(int id, Map<String, dynamic> visitData) async {
    try {
      print('🔄 Updating visit $id with data: $visitData');
      
      final response = await _apiClient.dio.patch(
        '${ApiConstants.visitsEndpoint}?id=eq.$id',
        data: visitData,
      );
      
      print('✅ Update response: ${response.data}');
      
      // Supabase returns an array for updates
      dynamic responseData = response.data;
      if (responseData is List && responseData.isNotEmpty) {
        responseData = responseData.first;
      } else if (responseData is List && responseData.isEmpty) {
        throw ServerFailure('Visit with id $id not found');
      }
      
      return VisitModel.fromJson(responseData as Map<String, dynamic>);
    } on DioException catch (e) {
      print('❌ Update error: ${e.message}');
      throw ServerFailure('Failed to update visit: ${e.message}');
    }
  }
  
  @override
  Future<void> deleteVisit(int id) async {
    try {
      print('🔄 Deleting visit $id');
      
      await _apiClient.dio.delete(
        '${ApiConstants.visitsEndpoint}?id=eq.$id',
      );
      
      print('✅ Visit $id deleted successfully');
    } on DioException catch (e) {
      print('❌ Delete error: ${e.message}');
      throw ServerFailure('Failed to delete visit: ${e.message}');
    }
  }
}