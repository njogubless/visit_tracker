// lib/Features/activities/data/datasources/activity_datasources.dart

import 'package:visit_tracker/Features/activities/domain/entities/activity.dart';
import 'package:visit_tracker/core/network/api_client.dart';

abstract class ActivityRemoteDataSource {
  Future<List<Activity>> getActivities();
  Future<Activity> createActivity(Activity activity);
  Future<Activity> updateActivity(Activity activity);
  Future<void> deleteActivity(String id);
}

class ActivityRemoteDataSourceImpl implements ActivityRemoteDataSource {
  final ApiClient apiClient;

  ActivityRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<Activity>> getActivities() async {
    try {
      final response = await apiClient.get('/activities');
      final List<dynamic> data = response.data;
      return data.map((json) => Activity.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch activities: $e');
    }
  }

  @override
  Future<Activity> createActivity(Activity activity) async {
    try {
      final response = await apiClient.post('/activities', data: activity.toJson());
      return Activity.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create activity: $e');
    }
  }

  @override
  Future<Activity> updateActivity(Activity activity) async {
    try {
      final response = await apiClient.put('/activities/${activity.id}', data: activity.toJson());
      return Activity.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update activity: $e');
    }
  }

  @override
  Future<void> deleteActivity(String id) async {
    try {
      await apiClient.delete('/activities/$id');
    } catch (e) {
      throw Exception('Failed to delete activity: $e');
    }
  }
}