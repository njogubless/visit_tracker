import 'package:visit_tracker/Features/activities/domain/entities/activity.dart';
import 'package:visit_tracker/core/network/api_client.dart';

abstract class ActivityRemoteDataSource {
  Future<List<Activity>> getActivities();
  Future<Activity> createActivity(dynamic activity); // Changed to dynamic
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
      
      // Handle different response formats
      dynamic data = response.data;
      List<dynamic> activities;
      
      if (data is Map && data.containsKey('data')) {
        // If response is wrapped in a 'data' field
        activities = data['data'] as List<dynamic>;
      } else if (data is List) {
        // If response is directly a list
        activities = data;
      } else {
        throw Exception('Unexpected response format: ${data.runtimeType}');
      }
      
      return activities.map((json) => Activity.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch activities: $e');
    }
  }

  @override
  Future<Activity> createActivity(dynamic activity) async {
    try {
      final response = await apiClient.post('/activities', data: activity);
      
      // Handle different response formats
      dynamic data = response.data;
      Map<String, dynamic> activityData;
      
      if (data is Map && data.containsKey('data')) {
        activityData = data['data'] as Map<String, dynamic>;
      } else if (data is Map) {
        activityData = data as Map<String, dynamic>;
      } else {
        throw Exception('Unexpected response format: ${data.runtimeType}');
      }
      
      return Activity.fromJson(activityData);
    } catch (e) {
      throw Exception('Failed to create activity: $e');
    }
  }

  @override
  Future<Activity> updateActivity(Activity activity) async {
    try {
      final response = await apiClient.put('/activities/${activity.id}', data: activity.toJson());
      
      // Handle different response formats
      dynamic data = response.data;
      Map<String, dynamic> activityData;
      
      if (data is Map && data.containsKey('data')) {
        activityData = data['data'] as Map<String, dynamic>;
      } else if (data is Map) {
        activityData = data as Map<String, dynamic>;
      } else {
        throw Exception('Unexpected response format: ${data.runtimeType}');
      }
      
      return Activity.fromJson(activityData);
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