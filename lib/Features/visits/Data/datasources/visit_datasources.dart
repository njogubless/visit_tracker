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
}

class VisitRemoteDataSourceImpl implements VisitRemoteDataSource {
  final ApiClient _apiClient;
  
  VisitRemoteDataSourceImpl(this._apiClient);
  
  @override
  Future<List<VisitModel>> getVisits() async {
    try {
      final response = await _apiClient.dio.get(
        ApiConstants.visitsEndpoint,
        queryParameters: {'order': 'created_at.desc'},
      );
      
      final List<dynamic> data = response.data;
      return data.map((json) => VisitModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ServerFailure('Failed to fetch visits: ${e.message}');
    }
  }
  
  @override
  Future<VisitModel> createVisit(Map<String, dynamic> visitData) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.visitsEndpoint,
        data: visitData,
      );
      
      return VisitModel.fromJson(response.data[0]);
    } on DioException catch (e) {
      throw ServerFailure('Failed to create visit: ${e.message}');
    }
  }
  
  @override
  Future<VisitModel> updateVisit(int id, Map<String, dynamic> visitData) async {
    try {
      final response = await _apiClient.dio.patch(
        '${ApiConstants.visitsEndpoint}?id=eq.$id',
        data: visitData,
      );
      
      return VisitModel.fromJson(response.data[0]);
    } on DioException catch (e) {
      throw ServerFailure('Failed to update visit: ${e.message}');
    }
  }
  
  @override
  Future<void> deleteVisit(int id) async {
    try {
      await _apiClient.dio.delete(
        '${ApiConstants.visitsEndpoint}?id=eq.$id',
      );
    } on DioException catch (e) {
      throw ServerFailure('Failed to delete visit: ${e.message}');
    }
  }
}