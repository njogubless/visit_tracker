// lib/Features/activities/data/repository/activity_repository_impl.dart

import 'package:visit_tracker/Features/activities/domain/entities/activity.dart';
import 'package:visit_tracker/Features/activities/data/datasources/activity_datasources.dart';
import 'package:visit_tracker/Features/activities/domain/repository/acitvity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityRemoteDataSource remoteDataSource;
  @override
  final String baseUrl = 'https://kqgbftwsodpttpqgqnbh.supabase.co/rest/v1/';

  ActivityRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Activity>> getActivities() async {
    try {
      return await remoteDataSource.getActivities();
    } catch (e) {
      throw Exception('Repository: Failed to get activities - $e');
    }
  }

  @override
  Future<Activity> createActivity(dynamic activity) async {
    try {
      return await remoteDataSource.createActivity(activity);
    } catch (e) {
      throw Exception('Repository: Failed to create activity - $e');
    }
  }

  @override
  Future<Activity> updateActivity(Activity activity) async {
    try {
      return await remoteDataSource.updateActivity(activity);
    } catch (e) {
      throw Exception('Repository: Failed to update activity - $e');
    }
  }

  @override
  Future<void> deleteActivity(String id) async {
    try {
      await remoteDataSource.deleteActivity(id);
    } catch (e) {
      throw Exception('Repository: Failed to delete activity - $e');
    }
  }
}